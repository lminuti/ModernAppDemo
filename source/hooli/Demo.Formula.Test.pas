unit Demo.Formula.Test;

interface

uses
  Demo.Interfaces;

type
  THooliCalculator = class(TInterfacedObject, ICalculator)
  public
    function Calculate(FirstValue: Integer; SecondValue: Integer): Integer;
  end;

implementation

uses
  Demo.Core.ServiceLocator;

{ THooliCalculator }

function THooliCalculator.Calculate(FirstValue, SecondValue: Integer): Integer;
begin
  Result := FirstValue + SecondValue;
end;

initialization

  ServiceLocator.RegisterClass(THooliCalculator);

end.
