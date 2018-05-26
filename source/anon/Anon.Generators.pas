unit Anon.Generators;

interface

uses
  System.SysUtils, System.IOUtils, System.JSON, Anon.Interfaces,
  Generics.Collections;

type
  TGeneratorList = class(TDictionary<string, IGenerator>)
  private
    function CreateGenerator(Config: TJSONValue): IGenerator;
  public
    constructor CreateFromConfig(Config: TJSONObject);
  end;

implementation

{ TGeneratorList }

uses Demo.Core.Registry;

constructor TGeneratorList.CreateFromConfig(Config: TJSONObject);
var
  GenIndex: Integer;
  FieldName: string;
  Generator: IGenerator;
begin
  inherited Create();
  for GenIndex := 0 to Config.Count - 1 do
  begin
    FieldName := Config.Pairs[GenIndex].JsonString.Value;
    Generator := CreateGenerator(Config.Pairs[GenIndex].JsonValue);
    Add(FieldName, Generator);
  end;
end;

function TGeneratorList.CreateGenerator(Config: TJSONValue): IGenerator;
var
  GeneratorName: string;
  JsonParams: TJSONArray;
  Params: TArray<string>;
  ParamIndex: Integer;
begin
  GeneratorName := Config.GetValue<string>('generator');
  JsonParams := Config.GetValue<TJSONArray>('params');
  SetLength(Params, JsonParams.Count);
  for ParamIndex := 0 to JsonParams.Count - 1 do
    Params[ParamIndex] := JsonParams.Items[ParamIndex].GetValue<string>;

  Result := ClassRegistry.GetClass<IGenerator>(GeneratorName);
  Result.SetParams(Params);
end;

initialization
  Randomize;

end.
