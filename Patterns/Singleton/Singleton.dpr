program Singleton;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {Form1},
  Pessoa.Impl in 'Pessoa.Impl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
