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
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type
  [Alias('FireDAC')]
  TFireDACConnection = class(TInterfacedObject, IConnection)
  private
    FConnection: TFDConnection;
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
begin
  ConfigValues := TStringList.Create;
  try
    ConfigValues.Delimiter := ';';
    ConfigValues.StrictDelimiter := True;
    ConfigValues.DelimitedText := DatabaseConfig.ConnectionString;
    ConfigValues.Values['User_Name'] := DatabaseConfig.UserName;
    ConfigValues.Values['Password'] := DatabaseConfig.Password;

    FConnection.Params.Assign(ConfigValues);
    FConnection.Connected := True;

  finally
    ConfigValues.Free;
  end;
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

initialization
  ServiceLocator.RegisterClass(TFireDACConnection);

end.
