unit Anon.Generators.Date;

interface

uses
  SysUtils, Anon.Interfaces, Demo.Core.ServiceLocator, Demo.Core.Rtti;

type
  [Alias('Date')]
  TDateGenerator = class(TInterfacedObject, IGenerator)
  private
    FStartDate: TDateTime;
    FEndDate: TDateTime;
  public
    function GenerateValue: Variant;
    procedure SetParams(const Params: System.TArray<System.string>);
  end;

implementation

{ TDateGenerator }

function TDateGenerator.GenerateValue: Variant;
var
  Range: Integer;
  ADate: TDateTime;
begin
  Range := Random(Trunc(FEndDate) - Trunc(FStartDate));
  ADate := Trunc(FStartDate + Range);
  Result := ADate;
end;

procedure TDateGenerator.SetParams(
  const Params: System.TArray<System.string>);
begin
  if Length(Params) > 0 then
    FStartDate := StrToDateDef(Params[0], 0)
  else
    FStartDate := EncodeDate(1900, 1, 1);

  if Length(Params) > 1 then
    FEndDate := StrToDateDef(Params[1], 0)
  else
    FEndDate := Date;
end;

initialization
  ServiceLocator.RegisterClass(TDateGenerator);

end.
