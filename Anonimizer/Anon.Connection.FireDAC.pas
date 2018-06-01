unit Anon.Connection.FireDAC;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Anon.Interfaces,
  Demo.Core.ServiceLocator, Demo.Core.Rtti,

  Winapi.Windows, Winapi.Messages, System.Variants, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Comp.Script;

type
  [Alias('FireDAC')]
  TFireDACConnection = class(TInterfacedObject, IConnection)
  private
    FConnection: TFDConnection;
    procedure InitDatabase;
  public
    procedure Connect(DatabaseConfig: TDatabaseConfig);
    procedure FetchTable(const TableName: string; AProc: TProc<TDataSet>);
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TFireDACConnection }

procedure TFireDACConnection.Connect(DatabaseConfig: TDatabaseConfig);
var
  ConfigValues: TStringList;
  AutoCreateDatabase: Boolean;
begin
  AutoCreateDatabase := False;

  ConfigValues := TStringList.Create;
  try
    ConfigValues.Delimiter := ';';
    ConfigValues.StrictDelimiter := True;
    ConfigValues.DelimitedText := DatabaseConfig.ConnectionString;
    ConfigValues.Values['User_Name'] := DatabaseConfig.UserName;
    ConfigValues.Values['Password'] := DatabaseConfig.Password;

    if (DatabaseConfig.AutoCreateDatabase) and (not FileExists(ConfigValues.Values['Database'])) then
      AutoCreateDatabase := True;

    FConnection.Params.Assign(ConfigValues);
    FConnection.Connected := True;

  finally
    ConfigValues.Free;
  end;

  if AutoCreateDatabase then
    InitDatabase;
end;

constructor TFireDACConnection.Create;
begin
  inherited;
  FConnection := TFDConnection.Create(nil);
end;

destructor TFireDACConnection.Destroy;
begin
  FConnection.Free;
  inherited;
end;

procedure TFireDACConnection.FetchTable(const TableName: string;
  AProc: TProc<TDataSet>);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    FConnection.StartTransaction;
    LQuery.Open('SELECT * FROM ' + TableName);
    try
      while not LQuery.Eof do
      begin
        AProc(LQuery);
        LQuery.Next;
      end;
      FConnection.Commit;
    except
      FConnection.Rollback;
      raise;
    end;
  finally
    LQuery.Free;
  end;
end;

procedure TFireDACConnection.InitDatabase;
const
  SQLLiteCreateDB = 'ANON_SQLLITE_CREATEDB'; // resource name
var
  FDScript: TFDScript;
  FDSQLScript: TFDSQLScript;
  SQLScriptStream: TStream;
begin
  FDScript := TFDScript.Create(nil);
  try
    FDScript.Connection := FConnection;
    FDSQLScript := FDScript.SQLScripts.Add;
    SQLScriptStream := TResourceStream.Create(HInstance, SQLLiteCreateDB, RT_RCDATA);
    try
      SQLScriptStream.Position := 0;
      FDSQLScript.SQL.LoadFromStream(SQLScriptStream);
    finally
      SQLScriptStream.Free;
    end;
    FDScript.ExecuteAll;
  finally
    FDScript.Free;
  end;
end;

initialization
  ServiceLocator.RegisterClass(TFireDACConnection);

end.
