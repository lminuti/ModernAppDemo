unit Demo.Formula.Test;

interface

uses
  Demo.Interfaces;

type
  TFirstCalculator = class(TInterfacedObject, ICalculator)
  public
    function Calculate(FirstValue: Integer; SecondValue: Integer): Integer;
  end;

  TSecondCalculator = class(TInterfacedObject, ICalculator)
  public
    function Calculate(FirstValue: Integer; SecondValue: Integer): Integer;
  end;

implementation

{ TFirstCalculator }

uses
  Demo.Core.Registry;

function TFirstCalculator.Calculate(FirstValue, SecondValue: Integer): Integer;
begin
  Result := FirstValue + SecondValue;
end;

{ TSecondCalculator }

function TSecondCalculator.Calculate(FirstValue, SecondValue: Integer): Integer;
begin
  Result := FirstValue * SecondValue;
end;

initialization

  //TClassRegistry.Instance.RegisterForm(TFirstCalculator);
  TClassRegistry.Instance.RegisterClass(TSecondCalculator);

end.
