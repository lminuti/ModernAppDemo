unit Anon.Generators.RandomString;

interface

uses
  SysUtils, Anon.Interfaces, Demo.Core.ServiceLocator, Demo.Core.Rtti;

type
  [Alias('String')]
  TRandomStringGenerator = class(TInterfacedObject, IGenerator)
  private
    FSize: Integer;
  public
    function GenerateValue: Variant;
    procedure SetParams(const Params: System.TArray<System.string>);
  end;

implementation

{ TRandomStringGenerator }

function TRandomStringGenerator.GenerateValue: Variant;
const
  ValidChar = ' 1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  i: Integer;
begin
  Result := '';
  for i := 0 to FSize - 1 do
  begin
    Result := Result + ValidChar[Random(Length(ValidChar)) + 1];
  end;
end;

procedure TRandomStringGenerator.SetParams(
  const Params: System.TArray<System.string>);
begin
  if Length(Params) > 0 then
    FSize := StrToIntDef(Params[0], 10)
  else
    FSize := 10;
end;

initialization
  ServiceLocator.RegisterClass(TRandomStringGenerator);

end.
