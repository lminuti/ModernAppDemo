unit Demo.Forms.EmployeeList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Demo.Interfaces, Vcl.Grids,
  System.Rtti, Vcl.StdCtrls, Demo.Core.Rtti;

type
  [FrameTitle('Employee List')]
  [Alias('employee-list')]
  TFrameEmployeeList = class(TFrame, IFrame, ILookupFrame, IEmployeeListFrame)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    function GetResultValue: TValue;
  end;

implementation

{$R *.dfm}

uses
  Demo.Core.Registry;

{ TFrameEmployeeList }

procedure TFrameEmployeeList.Button1Click(Sender: TObject);
var
  Calculator: ICalculator;
begin
  Calculator := TClassRegistry.Instance.GetClass<ICalculator>;
  Edit3.Text := Calculator.Calculate(StrToInt(Edit1.Text), StrToInt(Edit2.Text)).ToString;
end;

function TFrameEmployeeList.GetResultValue: TValue;
begin
  Result := 123;
end;

initialization
  TClassRegistry.Instance.RegisterClass(TFrameEmployeeList);

end.
