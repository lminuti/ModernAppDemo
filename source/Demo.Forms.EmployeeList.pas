unit Demo.Forms.EmployeeList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Demo.Interfaces, Vcl.Grids,
  System.Rtti, Vcl.StdCtrls, Demo.Core.Rtti, Data.DB, Vcl.DBGrids, Vcl.ExtCtrls,
  Demo.Modules.Main;

type
  [FrameTitle('Employee List')]
  [Alias('employee-list')]
  TFrameEmployeeList = class(TFrame, IFrame, ILookupFrame, IEmployeeListFrame)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
  private
    FDataModuleMain: TDataModuleMain;
  public
    function GetResultValue: TValue;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

uses
  Demo.Core.Registry;

{ TFrameEmployeeList }

constructor TFrameEmployeeList.Create(AOwner: TComponent);
begin
  inherited;
  FDataModuleMain := TDataModuleMain.Create(Self);
  FDataModuleMain.FDQueryEmployee.Open;
end;

function TFrameEmployeeList.GetResultValue: TValue;
begin
  Result := -1;
  if not FDataModuleMain.FDQueryEmployee.IsEmpty then
    Result := FDataModuleMain.FDQueryEmployee.FieldByName('EMP_NO').AsInteger;
end;

initialization
  TClassRegistry.Instance.RegisterClass(TFrameEmployeeList);

end.
