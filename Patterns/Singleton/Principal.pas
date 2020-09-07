unit Principal;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.Controls, Vcl.StdCtrls,
  Winapi.Windows, Winapi.Messages,
  Vcl.Forms, Vcl.Dialogs, Vcl.Graphics;

type

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Pessoa.Impl;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  PessoaFisica: TPessoa;
begin
  PessoaFisica := TPessoa.GetInstance;
  PessoaFisica.Nome('Dener');
  ShowMessage(PessoaFisica.Nome);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  PessoaJuridica: TPessoa;
begin
  PessoaJuridica := TPessoa.GetInstance;
  ShowMessage(PessoaJuridica.Nome);

  PessoaJuridica.Nome('Dener Rocha');
  ShowMessage(PessoaJuridica.Nome);
end;

end.
