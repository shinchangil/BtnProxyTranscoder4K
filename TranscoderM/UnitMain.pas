unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, xmldom, XMLIntf, msxmldom, XMLDoc, ShellAPI, StdCtrls,
  bsTrayIcon, IOUtils;

type
  TfrmMain = class(TForm)
    tmr_QueryTrans: TTimer;
    XMLDocument1: TXMLDocument;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    bsTrayIcon1: TbsTrayIcon;
    lbl_Count: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmr_QueryTransTimer(Sender: TObject);
    procedure bsTrayIcon1DblClick(Sender: TObject);
  private
    { Private declarations }
    function workProcessCount : Integer;
    function possibleProcessName : string;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses UnitGlobal, SyncObjs, UnitCommunicateSoap;
{$R *.dfm}

procedure TfrmMain.bsTrayIcon1DblClick(Sender: TObject);
begin
   bsTrayIcon1.ShowMainForm;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   g_Sync.Free;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if MessageDlg('종료하시겠습니까?', mtConfirmation, mbYesNo, 0) = mrYes then
   begin
      EventLog('evt', '프로그램 종료');
      CanClose := True;
   end
   else begin
      CanClose := False;
   end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
   i : Integer;
begin
   g_ProgramPath := ExtractFilePath( Application.ExeName );
   ForceDirectories( g_ProgramPath + 'Log\TranscodeM' );
   g_Sync := TCriticalSection.Create;
   LoadIniFile;
   for i := 1 to g_WorkMax do
   begin
      if Not FileExists(g_ProgramPath + 'TranscoderC' + IntToStr(i) + '.exe') then
      begin
         CopyFile( PWideChar( g_ProgramPath + 'TranscoderC.exe' ), PWideChar( g_ProgramPath + 'TranscoderC' + IntToStr(i) + '.exe'), False );
      end;

      if Not DirectoryExists( g_ProgramPath + 'LibAV' + IntToStr(i) ) then
      begin
         TDirectory.Copy( g_ProgramPath + 'LibAV', g_ProgramPath + 'LibAV' + IntToStr(i) );
      end;

   end;


   EventLog('evt', '프로그램 시작 - 20160405');
   FSoapInterfaceObject := TCommunicateSoap.Create( XMLDocument1, g_SoapIP );
   tmr_QueryTrans.Enabled := True;
end;

procedure TfrmMain.tmr_QueryTransTimer(Sender: TObject);
var
   rDatas : RTranscodeInfo;
   sParam : String;
   iCount : Integer;
begin
   tmr_QueryTrans.Enabled := False;
   try
      iCount := workProcessCount;
      lbl_Count.Caption := IntToStr(iCount);
      //ProcessCount 조회
      if iCount < g_WorkMax then
      begin
         //작업 리스트 조회
         FSoapInterfaceObject.GetWorkList(rDatas);

         if rDatas.CONTENT_ID <> '' then
         begin
            //작업 진행 보고
            FSoapInterfaceObject.StatuUpdate(rDatas.CONTENT_ID, '진행중');
            //TranscoderC 에 작업 던저주기
            sParam := Format('"%s" "%s" "%s" "%s"', [rDatas.CONTENT_ID, rDatas.TRANS_FILENAME, rDatas.STORAGE_PATH, rDatas.STORAGE_SUBPATH]);
            //ShowMessage(possibleProcessName);
            ShellExecute(Handle, 'open', PWideChar( possibleProcessName ), PWideChar(sParam), nil, SW_NORMAL);
         end;
      end;

   finally
      tmr_QueryTrans.Enabled := True;
   end;
end;

function TfrmMain.workProcessCount : Integer;
var
   iProcessCount : Integer;
   i : Integer;
   sProcessName : String;
begin
   iProcessCount := 0;
   sProcessName := '';

   for i := 1 to g_WorkMax do
   begin
      sProcessName := 'TranscoderC' + IntToStr(i) + '.exe';
      if GetProcessCount( sProcessName ) > 0 then
      begin
         Inc(iProcessCount);
      end;
   end;

   Result := iProcessCount;
end;

function TfrmMain.possibleProcessName : string;
var
   i : Integer;
   sProcessName : String;
   sResult : String;
begin
   sProcessName := '';
   sResult := '';
   for i := 1 to g_WorkMax do
   begin
      sProcessName := 'TranscoderC' + IntToStr(i) + '.exe';
      if GetProcessCount( sProcessName ) < 1 then
      begin
         sResult := sProcessName;
         Break;
      end;
   end;

   Result := sResult;
end;

end.
