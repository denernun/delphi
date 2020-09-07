unit Pessoa.Int;

interface

type
  IPessoa = interface(IInterface)
    ['{5038A411-1785-4EE2-AC84-A97D2382F708}']
    function Nome: string; overload;
    function Nome(AValue: string): IPessoa; overload;
  end;

implementation

end.
