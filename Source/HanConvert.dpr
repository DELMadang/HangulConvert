program HanConvert;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  DM.Hangul in 'DM.Hangul.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
