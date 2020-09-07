unit ConcreateFactoryMethod;

interface

uses
  FactoryMethod;

type

  TConcreteProductCreator = class(TAbstractProductCreator)
  public
    function CreateProduct(AProductID: integer): IProduct; override;
  end;

  // The function that creates the products is virtual and can be overridden at least from

implementation

type

  TAdvancedProductX = class(TInterfacedObject, IProduct)
    // definition not important for illustration
  end;

  TAdvancedProductY = class(TProductA)
    // definition not important for illustration
  end;

function TConcreteProductCreator.CreateProduct(AProductID: integer): IProduct;
begin
  Case AProductID of
    1: result := TAdvancedProductX.Create;
    2: result := TAdvancedProductY.Create;
  else
    result := inherited;
  end;
end;

end.
