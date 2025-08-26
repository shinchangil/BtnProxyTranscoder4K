program TranscoderViewer;

uses
  Forms,
  Windows,
  UnitMain in 'UnitMain.pas' {Form1},
  Cromis.DirectoryWatch in 'Cromis.DirectoryWatch.pas';

{$R *.res}
var
   Mutex : THandle;
begin
  Mutex := CreateMutex(nil, True, 'TranscoderV');
  if (0 <> Mutex) and (0 = GetLastError) then
  begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
  end;
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    CloseHandle(Mutex);
  end;
end.
