program TranscoderM4K;

uses
  Forms,
  Windows,
  UnitMain in 'UnitMain.pas' {frmMain},
  Service in 'Service.pas',
  UnitCommunicateSoap in 'UnitCommunicateSoap.pas',
  UnitGlobal in 'UnitGlobal.pas';

{$R *.res}
var
   Mutex : THandle;
begin
  Mutex := CreateMutex(nil, True, 'TranscoderM4K');
  if (0 <> Mutex) and (0 = GetLastError) then
  begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
  end;
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    CloseHandle(Mutex);
  end;
end.
