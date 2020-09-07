{
  In short its a method that creates a product, the method must be overriden by
  decendents to extend the base (or sometimes fail-over) product range.
}
unit FactoryMethod;

interface

type

  IProduct = interface
    // definition not important for illustration
  end;

  TAbstractProductCreator = class abstract
  public
    function CreateProduct(AProductID: integer): IProduct; virtual;
  end;

  // The function that creates the products is virtual and can be overridden
  // The abstract creator may have an implementation or we may also have
  // a base product creator defined. The design pattern really only centers
  // around the method. It must be virtual, Descendents implement and fall throug
  // is handled via inheritence

implementation

uses
  System.SysUtils;

Type

  TBaseProductA = class(TInterfacedObject, IProduct)
    // definition not important for illustration
  end;

  TBaseProductB = class(TInterfacedObject, IProduct)
    // definition not important for illustration
  end;

function TAbstractProductCreator.CreateProduct(AProductID: integer): IProduct;
begin
  // Case statement against AProductID. Descendants should add their own
  // cases and call inherited as a fall through
  Case AProductID of
    1:
      result := TBaseProductA.Create;
    2:
      result := TBaseProductB.Create;
  else
    raise Exception.Create('Error Message');
  end;
end;

end.
