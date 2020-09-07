unit Pessoa.Impl;

interface

type
  TPessoa = class(TObject)
  private
    FNome: string;
    class var FInstance: TPessoa;
  protected
    constructor CreateInstance;
  public
    constructor Create;
    destructor Destroy; override;
    class function GetInstance: TPessoa;
    class procedure ReleaseInstance;
    function Nome: string; overload;
    function Nome(AValue: string): string; overload;
  end;

implementation

uses
  System.SysUtils;

{ TPessoa }

constructor TPessoa.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through GetInstance only',
    [ClassName]);
end;

constructor TPessoa.CreateInstance;
begin
  inherited Create;
end;

destructor TPessoa.Destroy;
begin

  inherited Destroy;
end;

class function TPessoa.GetInstance: TPessoa;
begin
  if not Assigned(FInstance) then
    FInstance := CreateInstance;
  Result := FInstance;
end;

class procedure TPessoa.ReleaseInstance;
begin
  FInstance.Free;
end;

function TPessoa.Nome: string;
begin
  Result := FNome;
end;

function TPessoa.Nome(AValue: string): string;
begin
  FNome := AValue;
end;

end.
