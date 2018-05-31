unit Demo.Formula.Test;

interface

uses
  Demo.Interfaces;

type
  TPiedPiperCalculator = class(TInterfacedObject, ICalculator)
  public
    function Calculate(FirstValue: Integer; SecondValue: Integer): Integer;
  end;

implementation

uses
  Demo.Core.ServiceLocator;

{ TPiedPiperCalculator }

function TPiedPiperCalculator.Calculate(FirstValue, SecondValue: Integer): Integer;
begin
  Result := FirstValue * SecondValue;
end;

initialization

  ServiceLocator.RegisterClass(TPiedPiperCalculator);

end.
