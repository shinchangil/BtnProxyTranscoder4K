unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FFBaseComponent, FFEncode, ComCtrls, xmldom, XMLIntf, msxmldom,
  XMLDoc, StdCtrls, FileCtrl, FFPlay, ExtCtrls, jpeg, FFDecode;
const
   LICENSE_KEY = 'FSGVRVNV-FTYRCJPB-JTYIJXNO-KSOZVHMD-DEQAZOLT';
   CLibAVPath = 'LibAV';

type
  TfrmMain = class(TForm)
    FFEncoder1: TFFEncoder;
    ProgressBar1: TProgressBar;
    XMLDocument1: TXMLDocument;
    FileListBox1: TFileListBox;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl_ContentId: TLabel;
    lbl_FileName: TLabel;
    FFDecoder1: TFFDecoder;
    procedure FormCreate(Sender: TObject);
    procedure FFEncoder1Progress(Sender: TObject; AProgressInfo: PProgressInfo);
    procedure FFEncoder1Terminate(Sender: TObject;
      const ATerminateInfo: TTerminateInfo);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    bTranswork : Boolean;
    bHaveAJob : Boolean;
    nDuration : int64;
    sDuration : string;
    sDuration_dsp : string;
    bTerminate : Boolean;
    procedure BeginTranscoding;
    procedure SetTranswork(const Value: Boolean);
    procedure DoAddFile(const AIO: TInputOptions; const AOO: TOutputOptions);
    function GetInputOptions: TInputOptions;
    function GetOutputOptions: TOutputOptions;
    procedure SuccessUpdate;
    procedure CaptureContent;
    procedure CaptureImage2(AFileName : string);
    function GetProcessNumber : String;
  public
    { Public declarations }
  public
   property Transwork : Boolean read bTranswork write SetTranswork;
   property HavaAJob : Boolean read bHaveAJob write bHaveAJob default False;
  end;

var
  frmMain: TfrmMain;

implementation
uses UnitGlobal, SyncObjs, UnitCommunicateSoap;
{$R *.dfm}

function DurationToStr(ADuration: Int64): string;
begin
  Result := Format('%.2d:%.2d:%.2d.%.3d',
    [ADuration div AV_TIME_BASE div 60 div 60,      //��
     ADuration div AV_TIME_BASE div 60 mod 60,      //��
     ADuration div AV_TIME_BASE mod 60,             //��
     ADuration mod AV_TIME_BASE * 1000 div AV_TIME_BASE]);  //micro sec
end;

function PtsToFrameCount(APTS : int64) : integer;
begin
   Result := Round ( APTS * 29.97 / AV_TIME_BASE );
end;

function FrameToTimeCode2(AFrameCount : integer) : string;
const
   BASE10 = Integer(17982);
   FIRST_TERM = Integer(1800);
var
   iFrameCount, iFrameCount2 : Integer;
   iBase10Minute : Integer;
   iFirstArea : Integer;
   hours, mins, secs, ff, t: Integer;
   n1, n2 : Integer;
   i10MinuteDivide : Integer;
begin
   iFrameCount := AFrameCount;
   iBase10Minute := iFrameCount div BASE10;

   iFirstArea := iFrameCount - (BASE10 * iBase10Minute);

   OutputDebugString(PChar(IntToStr(iFirstArea)));
   if iFirstArea <= 1799 then         //00:00:00;00 ~ 00:59:59;29
   begin
      secs := (iFrameCount + (iBase10Minute * 20) - (iBase10Minute * 2)) div 30;
      ff := (iFrameCount + (iBase10Minute * 20) - (iBase10Minute * 2)) mod 30;
      OutputDebugString(PChar('00:00:00;00 ~ 00:59:59;29'));
   end
   else if iFirstArea = FIRST_TERM then //00:01:00;02
   begin
      n1 := iFrameCount div FIRST_TERM;
      if iBase10Minute > 1 then
      begin
         iFrameCount := iFrameCount + (n1 * 2) - ((iBase10Minute - 1)* 2);
      end
      else
         iFrameCount := iFrameCount + (n1 * 2);
      secs := iFrameCount div 30;
      ff := iFrameCount mod 30;
      OutputDebugString(PChar('00:01:00;02'));
   end
   else begin
      //iFrameCount�� Decoder���� ����ϴ� Frame ��ġ.
      iFrameCount2 := iFrameCount - (1800 * (iBase10Minute + 1)) ; //1�� 2Frame
      n1 := iFrameCount2 div 1798;
      n2 := iFrameCount2 mod 1798;
      iFrameCount2 := (1800 * (iBase10Minute + 1)) + (1798 * n1) + n2 + ((n1 + 1) * 2);

      iFrameCount := iFrameCount2;
      secs := iFrameCount div 30;
      ff := iFrameCount mod 30;
      OutputDebugString(PChar('00:01:00;02 < '));
   end;
   hours := secs div 3600;
   t := secs mod 3600;
   mins := t div 60;
   secs := t mod 60;
   Result := Format('%.2d:%.2d:%.2d;%.2d', [hours, mins, secs, ff]);
end;

//Ʈ�����ڵ� ����
procedure TfrmMain.BeginTranscoding;

begin
   if not FFEncoder1.Decoder.LoadFile( g_STORAGE_PATH + g_STORAGE_SUBPATH + g_TRANS_FILENAME ) then
   begin
      Transwork := False;
      ProgressBar1.Position := 0;
      Exit;
   end;

   try
      DoAddFile(GetInputOptions, GetOutputOptions);
   finally
      FFEncoder1.Decoder.CloseFile;
   end;

   FFEncoder1.ThreadPriority := TThreadPriority(2);
   FFEncoder1.Start(1);
   OutputDebugString('');
end;

///������ ���Ͽ��� �̹����� �����Ѵ�.
procedure TfrmMain.CaptureContent;
const
   iTerm = Int64(60000000);
var
   curPos : int64;
   curPos2 : Int64;
   lastPos : int64;
   sImageFileName : string;
   sl: TStringList;
   i : integer;
   iExtractCount : Integer;
   iii : Int64;
   bChange : Boolean;
   biChange : Boolean;
   currentPTS : Int64;
   iiii : Int64;
   curValue : String;
   curValue2 : String;
   sduration_dsp2 : String;
begin
   curPos := 0;
   iExtractCount := 1;
   curValue2 := '';
   bChange := False;
   FFDecoder1.SetLicenseKey(LICENSE_KEY);
   FFDecoder1.LoadAVLib( ExtractFilePath( Application.ExeName ) + CLibAVPath + g_LibraryNum );

   if FFDecoder1.LoadFile(g_STORAGE_PATH + g_STORAGE_SUBPATH + g_TRANS_FILENAME) then
   begin
      FFDecoder1.Decode;
   end;
   nduration := FFDecoder1.FileStreamInfo.Duration;
   sduration := inttostr(nduration);
   sduration_dsp := durationtostr(FFDecoder1.FileStreamInfo.Duration);

   ForceDirectories(g_PREVIEW_PATH + g_STORAGE_SUBPATH + 'Thumbnail\' + g_CONTENT_ID);
   g_ThumbStart := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
   WriteWorkHistory('������', '');
   //���� �����鼭 ĸ�� (�ٽ�)
   iExtractCount := nDuration div iTerm + 1;
   for i := 0 to iExtractCount - 1 do
   begin
      if i = 0 then
      begin
         curPos := (1 * 1000000);
         sImageFileName := g_PREVIEW_PATH + g_STORAGE_SUBPATH + 'Thumbnail\' + g_CONTENT_ID + '\' + format('%.6d', [i * 60]) + '.jpg';
         CaptureImage2(sImageFileName);
      end
      else begin
         curPos := (i * iTerm) - 5000000;
         curPos2 := (i * iTerm) - 1;
         FFDecoder1.Seek(curPos);
         FFDecoder1.Seek(curPos, [sfBackward]);
         FFDecoder1.Seek(curPos, [sfAny]);

         while FFDecoder1.Decode do
         begin

            sduration_dsp := durationtostr(FFDecoder1.FrameInfo.PTS);
            sduration_dsp2 := FrameToTimeCode2(PtsToFrameCount(FFDecoder1.FrameInfo.PTS));
            curValue := Copy(sduration_dsp2, 4, 2);
            if curValue = format('%.2d', [i mod 60]) then
            begin
               sImageFileName := g_PREVIEW_PATH + g_STORAGE_SUBPATH + 'Thumbnail\' + g_CONTENT_ID + '\' + format('%.6d', [i * 60]) + '.jpg';
               CaptureImage2(sImageFileName);
               break;
            end;
         end;
      end;


   end;
   FFDecoder1.CloseFile;
   g_ThumbEnd := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
   WriteWorkHistory('������', '');
end;


///�̹��� ���� Core
procedure TfrmMain.CaptureImage2(AFileName: string);
var
   BMP, BMP2, BMP3: TBitmap;
   Jpg : TJPEGImage;
   rec : TRect;
begin
   BMP := TBitmap.Create;
   BMP2 := TBitmap.Create;
   BMP3 := TBitmap.Create;
   try
      try
         rec.Left := 0;
         rec.Right := 320;
         rec.Top := 0;
         rec.Bottom := 180;

         BMP2.Width := 320;
         BMP2.Height := 180;
         BMP2.Canvas.Brush.Color := clBlack;
         BMP2.Canvas.Brush.Style := bsSolid;
         BMP2.Canvas.FillRect( Rect(0, 0, BMP2.Width, BMP2.Height) );
         FFDecoder1.CopyToBitmap(BMP3);
         if BMP3.Width = 1920 then
         begin
            BMP2.Canvas.StretchDraw(Rect(0, 0, 320, 180), BMP3);
         end
         else begin
            BMP2.Canvas.StretchDraw(Rect(25, -9, 295, 180), BMP3);
         end;

         BMP.Assign(BMP2);
      finally
         BMP3.Free;
         BMP2.Free;
      end;

      if BMP.Width > 0 then
      begin
         Jpg := TJPEGImage.Create;
         try
            Jpg.CompressionQuality := 50;
            Jpg.Assign(BMP);
            Jpg.SaveToFile(AFileName);
         finally
            Jpg.Free;
         end;

      end;
   finally
      BMP.Free;
   end;
end;

procedure TfrmMain.DoAddFile(const AIO: TInputOptions;
  const AOO: TOutputOptions);
var
  LIndex: Integer;
begin
  // try to open input file with input options
   try
      LIndex := FFEncoder1.AddTask(AIO.FileName, @AIO);
      if LIndex < 0 then
      begin
         Transwork := False;
         ProgressBar1.Position := 0;
         Exit;
      end;

     // try to set output file with output options
      if FFEncoder1.SetOutput(LIndex, AOO.FileName, @AOO) < 0 then
      begin // cannot do output file, do not forget to remove input file!!!
         FFEncoder1.RemoveTask(LIndex);

         Transwork := False;
         ProgressBar1.Position := 0;
         Exit;
      end;
      try
         WriteWorkHistory('������', '');
         FSoapInterfaceObject.StatuUpdate(g_CONTENT_ID, '������');
      except
         //ShowMessage('������');
      end;
   except
      FFEncoder1.ClearTasks;
   end;
end;

procedure TfrmMain.FFEncoder1Progress(Sender: TObject;
  AProgressInfo: PProgressInfo);
begin
   with AProgressInfo^ do
   begin
      if TotalDuration > 0 then
      begin
         ProgressBar1.Position := CurrentDuration * 100 div TotalDuration;
         FSoapInterfaceObject.SendToEngineProgressUpdate(g_CONTENT_ID,
            IntToStr(CurrentDuration * 100 div TotalDuration), '������', '');
      end
      else
         ProgressBar1.Position := 0;
   end;

end;

procedure TfrmMain.FFEncoder1Terminate(Sender: TObject;
  const ATerminateInfo: TTerminateInfo);
var
   bExcep : Boolean;
begin
   bExcep := False;
   if ATerminateInfo.TaskIndex < 0 then
   begin
      ProgressBar1.Position := 0;
   end
   else if ATerminateInfo.Finished then
   begin // TaskIndex task converted success
      FFEncoder1.ClearTasks;
      ProgressBar1.Position := 100;
      if Not FileExists(g_PREVIEW_PATH + g_STORAGE_SUBPATH + 'Preview\' + ChangeFileExt( g_TRANS_FILENAME, '.mp4' )) then
      begin
         g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
         WriteWorkHistory('����', '������ ������ �����ϴ�.');
         FSoapInterfaceObject.StatuUpdate(ParamStr(1), '����');
         Application.Terminate;
         Exit;
      end;
      try
         CaptureContent;
      except
         begin
            bExcep := True;
         end;
      end;
      if bExcep = True then
      begin
         try
            g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
            WriteWorkHistory('����', '�̹��� ���� �� ����');
            FSoapInterfaceObject.StatuUpdate(g_CONTENT_ID, '����');
         except

         end;
      end
      else begin
         SuccessUpdate;
      end;
      Timer1.Enabled := True;
   end;

   if ATerminateInfo.Exception then
   begin
      FFEncoder1.ClearTasks;
      ProgressBar1.Position := 0;
      try
         g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
         WriteWorkHistory('����', ATerminateInfo.ExceptionMsg);
         FSoapInterfaceObject.StatuUpdate(g_CONTENT_ID, '����');
         Application.Terminate;
         Exit;
      except
      end;
   end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if bTerminate = False then
   begin
      g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
      WriteWorkHistory('����', '����� ����');
      FSoapInterfaceObject.StatuUpdate(ParamStr(1), '����');
   end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
   iParam: Integer;
   tStart : TDateTime;
begin
   iParam := ParamCount;
   g_ProgramPath := ExtractFilePath( Application.ExeName );
   g_LibraryNum := GetProcessNumber;
   tStart := now;
   g_StartTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', tStart);
   g_StartTime := FormatDateTime('YYYYMMddhhmmss', tStart);
   LoadIniFile;
   FSoapInterfaceObject := TCommunicateSoap.Create( XMLDocument1, g_SoapIP );
   SysUtils.ForceDirectories(g_ProgramPath + 'History');


   if iParam = 4 then
   begin
      g_CONTENT_ID := ParamStr(1);
      g_TRANS_FILENAME := ParamStr(2);
      g_STORAGE_PATH := ParamStr(3);
      g_STORAGE_SUBPATH := ParamStr(4);
      lbl_ContentId.Caption := g_CONTENT_ID;
      lbl_FileName.Caption := g_TRANS_FILENAME;
      SysUtils.ForceDirectories(g_PREVIEW_PATH + g_STORAGE_SUBPATH);
      Sleep(1000);
      if Not FileExists(g_STORAGE_PATH + g_STORAGE_SUBPATH + g_TRANS_FILENAME) then
      begin
         g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
         WriteWorkHistory('����', '���������� �����ϴ�.');
         FSoapInterfaceObject.StatuUpdate(ParamStr(1), '����');
         Application.Terminate;
         Exit;
      end;

      if Not SysUtils.DirectoryExists(g_PREVIEW_PATH + g_STORAGE_SUBPATH) then
      begin
         g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
         WriteWorkHistory('����', '������ ������ �����ϴ�.');
         FSoapInterfaceObject.StatuUpdate(ParamStr(1), '����');
         Application.Terminate;
         Exit;
      end;

   end
   else begin
      g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
      WriteWorkHistory('����', '�������� ���п����� ����');
      FSoapInterfaceObject.StatuUpdate(ParamStr(1), '����');
      Application.Terminate;
   end;
   //�� �ڵ�� Ȯ���� ���� ���α׷��Դϴ�.
//   g_CONTENT_ID := '20160128153313103';
//   g_TRANS_FILENAME := 'NA-STHD0_18_000_000_20160317130615.mxf';
//   g_STORAGE_PATH := 'E:\Project\2012-12-04-�ұ�\Program\Transcoder';
//   g_STORAGE_SUBPATH := '\201601\Content\Video\';
//   lbl_ContentId.Caption := g_CONTENT_ID;
//   lbl_FileName.Caption := g_TRANS_FILENAME;

   FFEncoder1.SetLicenseKey(LICENSE_KEY);
   //FFEncoder1.UnloadAVLib;
   if not FFEncoder1.AVLibLoaded then
   begin
      if not FFEncoder1.LoadAVLib(ExtractFilePath(Application.ExeName) + CLibAVPath + g_LibraryNum ) then
      begin
         g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
         WriteWorkHistory('����', '���̺귯�� �ε� ����');
         FSoapInterfaceObject.StatuUpdate(ParamStr(1), '����');
         ShowMessage('���ڴ� ���̺귯���� �ε� ���� ���߽��ϴ�. ���α׷� ������ Ȯ���ϼ���.');

         Application.Terminate;
         Exit;
      end;
   end;
   FFEncoder1.DisableFPUExceptions;
   WriteWorkHistory('������', '');
   BeginTranscoding;
end;

function TfrmMain.GetInputOptions: TInputOptions;
var
   IO: TInputOptions;
begin
   InitInputOptions(@IO); // Initialize empty options

   IO.FileName := FFEncoder1.Decoder.FileName;
   if FFEncoder1.Decoder.ForceFormat <> '' then
{$IFDEF UNICODE}{$WARNINGS OFF}{$ENDIF}
    IO.Options := IO.Options + ' -f ' + FFEncoder1.Decoder.ForceFormat;
{$IFDEF UNICODE}{$WARNINGS ON}{$ENDIF}

{$IFDEF QUICK_CUT}
  // cut a piece clip, see also -t in OutputOptions
  if chkCutClip.Enabled and chkCutClip.Checked and (FEndTime > FStartTime) then
{$IFDEF UNICODE}{$WARNINGS OFF}{$ENDIF}
    IO.Options := IO.Options + ' -ss ' + FloatToStr(GetClipStartTime / 1000000); // start time offset
{$IFDEF UNICODE}{$WARNINGS ON}{$ENDIF}
{$ENDIF}

  Result := IO;
end;

function TfrmMain.GetOutputOptions: TOutputOptions;
var
   IO: TOutputOptions;
   i : Integer;
   iw : Integer;
begin
   i := 0;
   iw := 0;
   InitOutputOptions(@IO);
   SysUtils.ForceDirectories( g_PREVIEW_PATH + g_STORAGE_SUBPATH + 'Preview' );
   IO.FileName := g_PREVIEW_PATH + g_STORAGE_SUBPATH + 'Preview\' + ChangeFileExt( g_TRANS_FILENAME, '.mp4' );

   for i := 0 to FFEncoder1.Decoder.StreamCount - 1 do
   begin
      if FFEncoder1.Decoder.IsVideoStream(i) then
      begin
         iw := FFEncoder1.Decoder.VideoStreamInfos[i].Width;
         break;
      end;
   end;

   if iw = 1920 then
   begin
      //-filter_complex join=inputs=2      => input 2���� Stereo�� �����.
      //IO.Options := ' -ar 44100 -filter_complex join=inputs=2 -b:a 126k -b:v 500k -c:v libx264 -vf "scale=512:288" -sn';
      IO.Options := ' -ar 44100 -filter_complex join=inputs=2 -b:a 126k -b:v 500k -g 33 -bf 1 -coder 0 -refs 1 -x264opts b-pyramid=0 -c:v libx264 -vf "scale=512:288" -sn';
   end
   else begin
//      IO.Options := ' -ar 44100 -af "pan=stereo:c0=FL:c1=FR" -b:a 126k -b:v 500k -c:v libx264 -aspect 16:9 -vf "crop=720:471:0:35,pad=856:471:68:0:black,scale=512:288" -sn';
      IO.Options := ' -ar 44100 -af "pan=stereo:c0=FL:c1=FR" -b:a 126k -b:v 500k -g 33 -bf 1 -coder 0 -refs 1 -x264opts b-pyramid=0 -c:v libx264 -aspect 16:9 -vf "crop=720:471:0:35,pad=856:471:68:0:black,scale=512:288" -sn';
   end;

//   if iw = 1920 then
//   begin
//      IO.Options := ' -ar 44100 -b:a 126k -b:v 500k -c:v libx264 -threads 8 -vf "scale=512:288" -sn';
//   end
//   else begin
//      IO.Options := ' -ar 44100 -ac 2 -b:a 126k -b:v 500k -c:v libx264 -aspect 16:9 -vf "crop=720:471:0:35,pad=856:471:68:0:black,scale=512:288" -sn';
//   end;

   //IO.Options := ' -ar 44100 -ac 2 -b:a 126k -b:v 500k -c:v libx264 -aspect 16:9 -vf "crop=720:471:0:35,pad=856:471:68:0:black,scale=512:288" -sn';
   result := IO;
end;

procedure TfrmMain.SetTranswork(const Value: Boolean);
begin
   bTranswork := Value;
end;

procedure TfrmMain.SuccessUpdate;
var
   strFolder : string;
   list : TStringList;
   i : Integer;
begin
   strFolder := g_PREVIEW_PATH + g_STORAGE_SUBPATH + 'Thumbnail\' + g_CONTENT_ID + '\';
   FileListBox1.Clear;
   FileListBox1.Directory := strFolder;
   FileListBox1.Update;

   list := TStringList.Create;
   try
      for i := 0 to FileListBox1.Items.Count - 1 do
      begin
         if FileListBox1.Items.Strings[i] = 'btn_default.jpg' then
            Continue;
         list.Add(FileListBox1.Items.Strings[i]);
      end;
      g_EndTimeFormat := FormatDateTime('YYYY-MM-dd hh:mm:ss', now);
      WriteWorkHistory('����', '');
      strFolder := g_STORAGE_PATH + g_STORAGE_SUBPATH + 'Thumbnail\' + g_CONTENT_ID + '\';
      FSoapInterfaceObject.StatuUpdateuccess(g_CONTENT_ID,
         g_STORAGE_PATH + g_STORAGE_SUBPATH + 'Preview\',
         ChangeFileExt(g_TRANS_FILENAME, '.mp4'), strFolder, list);
   finally
      list.Clear;
      list.Free;
   end;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   bTerminate := True;
   frmMain.Close;
end;

function TfrmMain.GetProcessNumber : String;
var
   iDotLength : Integer;
   iProcessNameLength : Integer;
   sNumber : string;
   sProcessName : String;
begin
   sProcessName := ExtractFileName( Application.ExeName );
   iDotLength := Pos('.', sProcessName);
   sNumber := Copy(sProcessName, 12, iDotLength - 12);

   Result := sNumber;
end;

end.
