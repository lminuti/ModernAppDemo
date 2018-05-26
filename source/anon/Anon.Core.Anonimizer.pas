unit Anon.Core.Anonimizer;

interface

uses
  System.SysUtils, System.IOUtils, System.JSON, Anon.Interfaces, Data.DB;

type
  EAnonimizerError = class(Exception);

  EAnonimizerConfigError = class(EAnonimizerError);

  TAnonimizer = class(TInterfacedObject, IAnonimizer)
  private
    FPassword: string;
    procedure AnonimizeTable(Connection: IConnection; const TableName: string; JsonTable: TJSONValue);
  protected
    procedure SetPassword(const Value: string);
    function GetPassword: string;
  public
    procedure Anonimize(const FileName: string);
  end;

implementation

uses
  Demo.Core.Registry, Demo.Core.Rtti, Anon.Generators;

{ TAnonimizer }

procedure TAnonimizer.Anonimize(const FileName: string);
var
  JsonConfig, JsonDatabase: TJSONValue;
  JsonTables: TJSONObject;
  DatabaseConfig: TDatabaseConfig;
  TableIndex: Integer;

  Connection: IConnection;
begin
  JsonConfig := TJSONObject.ParseJSONValue(TFile.ReadAllText(FileName));
  try
    if not Assigned(JsonConfig) then
      raise EAnonimizerError.Create('Configurazione errata');

    // Fa il parsing delle informazioni relative alla connessione
    JsonDatabase := JsonConfig.GetValue<TJSONValue>('database');
    DatabaseConfig.ConnectionString := JsonDatabase.GetValue<string>('connectionString');
    DatabaseConfig.UserName := JsonDatabase.GetValue<string>('userName');
    DatabaseConfig.Password := FPassword;
    Connection := ClassRegistry.GetClass<IConnection>;
    Connection.Connect(DatabaseConfig);

    // Fa il parsing delle informazioni relative alle tabelle
    JsonTables := JsonConfig.GetValue<TJSONValue>('tables') as TJSONObject;
    for TableIndex := 0 to JsonTables.Count - 1 do
    begin
      AnonimizeTable(Connection, JsonTables.Pairs[TableIndex].JsonString.Value, JsonTables.Pairs[TableIndex].JsonValue);
    end;

  finally
    JsonConfig.Free;
  end;
end;

procedure TAnonimizer.AnonimizeTable(Connection: IConnection;
  const TableName: string; JsonTable: TJSONValue);
var
  GeneratorList: TGeneratorList;
begin
  GeneratorList := TGeneratorList.CreateFromConfig(JsonTable as TJSONObject);
  try
    Connection.FetchTable(TableName,
      procedure (DataSet: TDataSet)
      var
        ColumnIndex: Integer;
        Field: TField;
        Generator: IGenerator;
      begin
        DataSet.Edit;
        for ColumnIndex := 0 to DataSet.FieldCount - 1 do
        begin
          Field := DataSet.Fields[ColumnIndex];
          if GeneratorList.TryGetValue(Field.FieldName, Generator) then
          begin
            Field.AsVariant := Generator.GenerateValue;
          end;
        end;
        DataSet.Post;
      end);
  finally
    GeneratorList.Free;
  end;
end;

function TAnonimizer.GetPassword: string;
begin
  Result := FPassword;
end;

procedure TAnonimizer.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

initialization

  ClassRegistry.RegisterClass(TAnonimizer);

end.
