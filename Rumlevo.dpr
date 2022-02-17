program Rumlevo;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MapForm},
  splashscreen in 'splashscreen.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMapForm, MapForm);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
