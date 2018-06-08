unit Persistence.FireDAC.SQLite;

interface

uses
  System.Classes,
  {$IFDEF MSWINDOWS}
  Winapi.Windows, Winapi.Messages,
  {$ENDIF}
  Persistence.Interfaces, FireDAC.Comp.Client, FireDAC.Stan.Param, Data.DB,
  FireDAC.Comp.ScriptCommands,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Script,
  FireDAC.Stan.Def,
  FireDAC.Phys.SQLite,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.DApt,
  FireDAC.UI.Intf,
  FireDAC.Comp.UI,
  FireDAC.Stan.Async,
{$IFDEF mgFMX}
  FireDAC.FMXUI.Wait;
{$ELSE}
  FireDAC.VCLUI.Wait;
{$ENDIF}

type
  TPersistanceFireDacSQLiteFactory = class(TInterfacedObject, IPersistanceLayerFactory)
  private
    class var FInstance: IPersistanceLayerFactory;
    FConnection: TFDConnection;
    procedure InitDatabase;
  protected
    function GetQuery: TFDQuery;
    function GetNextDocID: Integer; virtual;
  public
    class function GetInstance: IPersistanceLayerFactory;
    constructor Create;
    Destructor Destroy; override;

    function GetListaDocumentiDS: TDataSet;
    function GetListaArticoliDS: TDataSet;

    function GetDocumentoDS(const ATipoDoc: String; const AID:Integer=0): TDataSet;
    function GetRigheDocumentoDS(const AID:Integer=0): TDataSet;

    procedure ApplyUpdates(const ADataSet:TDataSet);
    procedure CancelUpdates(const ADataSet:TDataSet);
    procedure CommitUpdates(const ADataSet:TDataSet);
    function CanSave(const ADataSet:TDataSet): Boolean;

    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
  end;

implementation

uses
  System.IOUtils, System.SysUtils;

{ TPersistanceFireDacSQLiteFactory }

procedure TPersistanceFireDacSQLiteFactory.ApplyUpdates(const ADataSet: TDataSet);
begin
  if CanSave(ADataSet) then
    (ADataSet as TFDQuery).ApplyUpdates;
end;

procedure TPersistanceFireDacSQLiteFactory.CancelUpdates(const ADataSet: TDataSet);
begin
  if CanSave(ADataSet) then
    (ADataSet as TFDQuery).CancelUpdates;
end;

function TPersistanceFireDacSQLiteFactory.CanSave(const ADataSet: TDataSet): Boolean;
begin
  Result := (ADataSet as TFDQuery).UpdatesPending or (ADataSet.State in [dsEdit, dsInsert]);
end;

procedure TPersistanceFireDacSQLiteFactory.CommitTransaction;
begin
  FConnection.Commit;
end;

procedure TPersistanceFireDacSQLiteFactory.CommitUpdates(const ADataSet: TDataSet);
begin
  if CanSave(ADataSet) then
    (ADataSet as TFDQuery).CommitUpdates;
end;

constructor TPersistanceFireDacSQLiteFactory.Create;
var
  DatabasePath: string;
  AutoCreateDatabase: Boolean;
begin
  DatabasePath := TPath.Combine(TPath.GetDocumentsPath, 'microgest.db');
  AutoCreateDatabase := not FileExists(DatabasePath);

  FConnection := TFDConnection.Create(nil);
  FConnection.Params.DriverID := 'SQLite';
  FConnection.Params.Database := DatabasePath;
  FConnection.Open;

  if AutoCreateDatabase then
    InitDatabase;
end;

destructor TPersistanceFireDacSQLiteFactory.Destroy;
begin
  FConnection.Free;
  inherited;
end;

function TPersistanceFireDacSQLiteFactory.GetDocumentoDS(const ATipoDoc: String; const AID: Integer): TDataSet;
var
  LQuery: TFDQuery;
begin
  LQuery := GetQuery;
  LQuery.SQL.Text := 'SELECT * FROM DOCUMENTI WHERE ID = :P_ID';
  LQuery.ParamByName('P_ID').AsInteger := AID;
  LQuery.Open;

  (LQuery.FieldByName('TOTALEIMPONIBILE') as TFloatField).Currency := True;
  (LQuery.FieldByName('TOTALEIVA') as TFloatField).Currency := True;
  (LQuery.FieldByName('TOTALEDOCUMENTO') as TFloatField).Currency := True;

  if LQuery.Eof and (AID = 0) then
  begin
    LQuery.Append;
    LQuery.FieldByName('ID').Value := GetNextDocID;
    LQuery.FieldByName('TIPO').Value := ATipoDoc;
    LQuery.FieldByName('DATA').Value := Date;
  end;

  Result := LQuery;
end;

class function TPersistanceFireDacSQLiteFactory.GetInstance: IPersistanceLayerFactory;
begin
  // Singleton
  if not Assigned(FInstance) then
    FInstance := Self.Create;
  Result := FInstance;
end;

function TPersistanceFireDacSQLiteFactory.GetListaArticoliDS: TDataSet;
var
  LQuery: TFDQuery;
begin
  LQuery := GetQuery;
  LQuery.SQL.Text := 'SELECT * FROM ARTICOLI';
  LQuery.Open;
  Result := LQuery;
end;

function TPersistanceFireDacSQLiteFactory.GetListaDocumentiDS: TDataSet;
var
  LQuery: TFDQuery;
begin
  LQuery := GetQuery;
  LQuery.SQL.Text := 'SELECT TIPO, ID, DATA, CLIENTE, TOTALEDOCUMENTO FROM DOCUMENTI';
  LQuery.Open;
  (LQuery.FieldByName('TOTALEDOCUMENTO') as TFloatField).Currency := True;
  Result := LQuery;
end;

function TPersistanceFireDacSQLiteFactory.GetNextDocID: Integer;
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery := GetQuery;
    LQuery.SQL.Text := 'SELECT MAX(ID) FROM DOCUMENTI';
    LQuery.Open;
    Result := LQuery.Fields[0].AsInteger + 1;
  finally
    LQuery.Free;
  end;
end;

function TPersistanceFireDacSQLiteFactory.GetQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.CachedUpdates := True;
  Result.Connection := FConnection;
end;

function TPersistanceFireDacSQLiteFactory.GetRigheDocumentoDS(const AID: Integer): TDataSet;
var
  LQuery: TFDQuery;
begin
  LQuery := GetQuery;
  LQuery.SQL.Text := 'SELECT * FROM RIGHEDOCUMENTI WHERE ID_DOC = :P_ID_DOC';
  LQuery.ParamByName('P_ID_DOC').AsInteger := AID;
  LQuery.Open;

  (LQuery.FieldByName('PREZZO') as TFloatField).Currency := True;
  (LQuery.FieldByName('IMPORTO') as TFloatField).Currency := True;

  Result := LQuery;
end;

procedure TPersistanceFireDacSQLiteFactory.RollbackTransaction;
begin
  FConnection.Rollback;
end;

procedure TPersistanceFireDacSQLiteFactory.StartTransaction;
begin
  FConnection.StartTransaction;
end;

procedure TPersistanceFireDacSQLiteFactory.InitDatabase;
{$IFDEF MSWINDOWS}
const
  SQLLiteCreateDB = 'MICROGEST_SQLLITE_DATA'; // resource name
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
{$ELSE}
begin
end;
{$ENDIF}

end.
