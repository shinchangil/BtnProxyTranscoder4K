unit UnitCommunicateSoap;

interface
uses xmldom, XMLIntf, msxmldom, XMLDoc, Classes, UnitGlobal;

type
   TCommunicateSoap = class
   private
      FXMLCom1 : TXMLDocument;
      serverip : string;
   private
      function GetWorkListRequestStr : string;
      procedure ParsingWorkList(sXML : string; out rData : RTranscodeInfo);
      function MakeXMLStatuUpdate(contentid, statu : string) : string;
      function MakexmlStatuUpdateSuccess(contentid, path, filenames, imagePath : string; listimg : TStringList) : string;
      function MakeXmlProgressUpdate(Contentid, progress, state, jobid : string) : string;
   public
      constructor Create(var XMLComp : TXMLDocument; serverip1 : string);
      destructor Destroy; override;
      procedure GetWorkList(out rData : RTranscodeInfo);
      procedure StatuUpdate(contentid, statu : string);
      procedure StatuUpdateuccess(contentid, path, filenames, imagePath : string; listimg : TStringList);
      procedure SendToEngineProgressUpdate(Contentid, progress, state, jobid : string);
   end;
var
   FSoapInterfaceObject : TCommunicateSoap;

implementation
uses Service, Windows;
{ TCommunicateSoap }

constructor TCommunicateSoap.Create(var XMLComp: TXMLDocument; serverip1 : string);
begin
   FXMLCom1 := XMLComp;
   serverip := serverip1;
end;

destructor TCommunicateSoap.Destroy;
begin
   FXMLCom1 := nil;
   Inherited Destroy;
end;


procedure TCommunicateSoap.GetWorkList(out rData : RTranscodeInfo);
var
   sRequetStr : string;
   sReplyStr : string;
   Soap : ServiceSoap;
begin
   sRequetStr := GetWorkListRequestStr;

   try
      Soap := GetServiceSoap(true, 'http://' + serverip + '/CMS/Service.asmx?wsdl', nil);
      sReplyStr := Soap.EngineAPI(sRequetStr);
      ParsingWorkList(sReplyStr, rData);
   except
   end;

end;

function TCommunicateSoap.GetWorkListRequestStr: string;
var
   str : string;
begin
   str := '<?xml version="1.0" encoding="utf-8" standalone="no"?>';
   str := str + '<castwareXML APIVer="1.0" TaskType="TRANSCODING_JOB_LIST" JobName="TRANSCODING_JOB_LIST" UserID="btn">';
   str := str + '<command>';
   str := str + '</command>';
   str := str + '</castwareXML>';

   result := str;
end;

function TCommunicateSoap.MakeXmlProgressUpdate(Contentid, progress, state,
  jobid: string): string;
var
   str : string;
begin
   str := '<?xml version="1.0" encoding="utf-8" standalone="no"?>';
   str := str + '<castwareXML APIVer="1.0" TaskType="Transcoding_job_Progress_Update" JobName="Transcoding_job_Progress_Update" UserID="btn">';
   str := str + '<command>';
   str := str + '<content_id><![CDATA[' + Contentid + ']]></content_id>';
   str := str + '<transcode_state><![CDATA[' + state + ']]></transcode_state>';
   str := str + '<progress><![CDATA[' + progress + ']]></progress>';
   str := str + '<transcode_job_id><![CDATA[' + jobid + ']]></transcode_job_id>';
   str := str + '</command>';
   str := str + '</castwareXML>';

   result := str;
end;

function TCommunicateSoap.MakeXMLStatuUpdate(contentid, statu: string): string;
var
   str : string;
begin
   str := '<?xml version="1.0" encoding="utf-8" standalone="no"?>';
   str := str + '<castwareXML APIVer="1.0" TaskType="TRANSCODING_JOB_UPDATE" JobName="TRANSCODING_JOB_UPDATE" UserID="btn">';
   str := str + '<command>';
   str := str + '<content_id><![CDATA[' + contentid + ']]></content_id>';
   str := str + '<transcode_state><![CDATA[' + statu + ']]></transcode_state>';
   str := str + '</command>';
   str := str + '</castwareXML>';

   result := str;
end;

function TCommunicateSoap.MakexmlStatuUpdateSuccess(contentid, path, filenames, imagePath : string; listimg : TStringList): string;
var
   str : string;
   i : Integer;
begin
   str := '<?xml version="1.0" encoding="utf-8" standalone="no"?>';
   str := str + '<castwareXML APIVer="1.0" TaskType="TRANSCODING_JOB_UPDATE" JobName="TRANSCODING_JOB_UPDATE" UserID="btn">';
   str := str + '<command>';
   str := str + '<content_id><![CDATA[' + contentid + ']]></content_id>';
   str := str + '<transcode_state><![CDATA[¼º°ø]]></transcode_state>';
   str := str + '<mp4_filepath><![CDATA[' + path + ']]></mp4_filepath>';
   str := str + '<mp4_filename><![CDATA[' + filenames + ']]></mp4_filename>';
   if listimg.Count > 0 then
   begin
      for i := 0 to listimg.Count - 1 do
      begin
         str := str + '<thumb_filepath><![CDATA[' + imagePath + ']]></thumb_filepath>';
         str := str + '<thumb_filename><![CDATA[' + listimg[i] + ']]></thumb_filename>';
      end;
   end;
   str := str + '</command>';
   str := str + '</castwareXML>';

   result := str;
end;



procedure TCommunicateSoap.ParsingWorkList(sXML: string; out rData : RTranscodeInfo);
var
   FirstNode : IXMLNode;
   nodechild : IXMLNode;
   subnode : IXMLNode;
   i, j, k   : Integer;
   ResultStatu : String;
   ResultMessage : String;
   rDatas : RTranscodeInfo;
begin
   FXMLCom1.XML.Clear;
   FXMLCom1.XML.Text := sXML;
   FXMLCom1.Active := True;
   try
      FirstNode := FXMLCom1.DocumentElement;
      for i := 0 to FirstNode.ChildNodes.Count - 1 do
      begin
         if FirstNode.ChildNodes[i].NodeName = 'Result' then
         begin
            nodechild := FirstNode.ChildNodes[i];
            for j := 0 to nodechild.ChildNodes.Count - 1 do
            begin
               if 'Status' = nodechild.ChildNodes[j].NodeName then
               begin
                  ResultStatu := nodechild.ChildNodes[j].Text;
               end;
               if 'Message' = nodechild.ChildNodes[j].NodeName then
               begin
                  ResultMessage := nodechild.ChildNodes[j].Text;
               end;
            end;
            if 'OK' <> ResultStatu then
            begin
               Exit;
            end;
         end;
         if 'Data' = FirstNode.ChildNodes[i].NodeName then
         begin
            nodechild := FirstNode.ChildNodes[i];
            if 0 < nodechild.ChildNodes.Count then
            begin
               j := 0;
               if 'Item' = nodechild.ChildNodes[j].NodeName then
               begin
                  subnode := nodechild.ChildNodes[j];

                  for k := 0 to subnode.ChildNodes.Count - 1 do
                  begin
                     if 'Title' = subnode.ChildNodes[k].NodeName then
                     begin
                        rDatas.TITLE := subnode.ChildNodes[k].Text;
                     end;
                     if 'SubTitle' = subnode.ChildNodes[k].NodeName then
                     begin
                        rDatas.SubTitle := subnode.ChildNodes[k].Text;
                     end;
                     if 'FileName' = subnode.ChildNodes[k].NodeName then
                     begin
                        rDatas.TRANS_FILENAME := subnode.ChildNodes[k].Text;
                     end;
                     if 'content_id' = subnode.ChildNodes[k].NodeName then
                     begin
                        rDatas.content_id := subnode.ChildNodes[k].Text;
                     end;
                     if 'storage_path' = subnode.ChildNodes[k].NodeName then
                     begin
                        rDatas.storage_path := subnode.ChildNodes[k].Text;
                     end;
                     if 'storage_subpath' = subnode.ChildNodes[k].NodeName then
                     begin
                        rDatas.storage_subpath := subnode.ChildNodes[k].Text;
                     end;
                     if 'presetname' = subnode.ChildNodes[k].NodeName then
                     begin
                        rDatas.presetname := subnode.ChildNodes[k].Text;
                     end;
                     if 'transcode_state' = subnode.ChildNodes[k].NodeName then
                     begin
                        rDatas.transcode_state := subnode.ChildNodes[k].Text;
                     end;
                  end;
                  if '' <> rDatas.CONTENT_ID then
                  begin
                     rData := rDatas;
                  end;
                  break;
               end;
            end;
         end;
      end;
   finally
      FXMLCom1.Active := False;
   end;
end;

procedure TCommunicateSoap.SendToEngineProgressUpdate(Contentid, progress,
  state, jobid: string);
var
   sRequetStr : string;
   sReplyStr : string;
   Soap : ServiceSoap;
begin
   sRequetStr := MakeXmlProgressUpdate( Contentid, progress,state, jobid );

   try
      Soap := GetServiceSoap(true, 'http://' + serverip + '/CMS/Service.asmx?wsdl', nil);
      sReplyStr := Soap.EngineAPI(sRequetStr);
      OutputDebugString('');
   except
   end;

end;

procedure TCommunicateSoap.StatuUpdate(contentid, statu: string);
var
   sRequetStr : string;
   sReplyStr : string;
   Soap : ServiceSoap;
begin
   sRequetStr := MakeXMLStatuUpdate(contentid, statu);

   try
      Soap := GetServiceSoap(true, 'http://' + serverip + '/CMS/Service.asmx?wsdl', nil);
      sReplyStr := Soap.EngineAPI(sRequetStr);
   except
   end;

end;

procedure TCommunicateSoap.StatuUpdateuccess(contentid, path, filenames, imagePath : string; listimg : TStringList);
var
   sRequetStr : string;
   sReplyStr : string;
   Soap : ServiceSoap;
begin
   sRequetStr := MakexmlStatuUpdateSuccess(contentid, path, filenames, imagePath, listimg);

   try
      Soap := GetServiceSoap(true, 'http://' + serverip + '/CMS/Service.asmx?wsdl', nil);
      sReplyStr := Soap.EngineAPI(sRequetStr);
   except
   end;

end;

end.

