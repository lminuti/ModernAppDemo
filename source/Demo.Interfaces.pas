unit Demo.Interfaces;

interface

uses
  System.Rtti, System.Types, Vcl.Controls;

type
  IFrame = interface
  ['{D25B0435-5778-4803-AE95-4A1492643BF5}']
    procedure SetParent(AParent: TWinControl);
    function GetClientRect: TRect;
  end;

  ILookupFrame = interface(IFrame)
    ['{351D00D9-493F-4BFE-9B1F-21D56D38C777}']
    function GetResultValue: TValue;
  end;

  IEmployeeListFrame = interface(ILookupFrame)
    ['{3E031E7B-3BBF-4BA2-9C69-BE54CAC47437}']
  end;

  ICalculator = interface
    ['{863A2FD5-F39C-45E5-B014-9E09DEDA21F6}']
    function Calculate(FirstValue, SecondValue: Integer): Integer;
  end;

implementation

end.
