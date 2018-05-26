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
  Demo.Core.Registry;

{ THooliCalculator }

function THooliCalculator.Calculate(FirstValue, SecondValue: Integer): Integer;
begin
  Result := FirstValue + SecondValue;
end;

initialization

  ClassRegistry.RegisterClass(THooliCalculator);

end.
