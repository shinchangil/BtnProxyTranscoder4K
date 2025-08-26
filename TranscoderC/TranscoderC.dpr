program TranscoderC;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {frmMain},
  UnitGlobal in 'UnitGlobal.pas',
  UnitCommunicateSoap in 'UnitCommunicateSoap.pas',
  Service in 'Service.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
