unit Persistence.dbx.Firebird;

interface

uses
  System.SysUtils, System.Classes, Data.DbxSqlite, Data.DB, Data.SqlExpr,
  Persistence.Interfaces, SimpleDS, Datasnap.DBClient, Data.DBXCommon, Data.DBXFirebird;

type
  TPersistanceDbxFirebirdFactory = class(TDataModule, IPersistanceLayerFactory)
    Connection: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    class var FInstance: IPersistanceLayerFactory;
    FTransaction: TDBXTransaction;
    procedure onRigheAfterInsertEventHandler(DataSet: TDataSet);
  protected
    function GetQuery: TSimpleDataSet;
    function GetNextDocID: Integer; virtual;
    function GetNextRowID: Integer; virtual;
  public
    class function GetInstance: IPersistanceLayerFactory;

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

{%CLASSGROUP 'System.Classes.TPersistent'}

uses System.IOUtils;

{$R *.dfm}

{ TPersistanceDbxSQLiteFactory }

procedure TPersistanceDbxFirebirdFactory.ApplyUpdates(const ADataSet: TDataSet);
begin
  if CanSave(ADataSet) then
    (ADataSet as TSimpleDataSet).ApplyUpdates(0);
end;

procedure TPersistanceDbxFirebirdFactory.CancelUpdates(const ADataSet: TDataSet);
begin
  if CanSave(ADataSet) then
    (ADataSet as TSimpleDataSet).CancelUpdates;
end;

function TPersistanceDbxFirebirdFactory.CanSave(const ADataSet: TDataSet): Boolean;
begin
  Result := ((ADataSet as TSimpleDataSet).ChangeCount > 0) or (ADataSet.State in [dsEdit, dsInsert]);
end;

procedure TPersistanceDbxFirebirdFactory.CommitTransaction;
begin
  Connection.CommitFreeAndNil(FTransaction);
end;

procedure TPersistanceDbxFirebirdFactory.CommitUpdates(const ADataSet: TDataSet);
begin
  // Nothing
end;

procedure TPersistanceDbxFirebirdFactory.DataModuleCreate(Sender: TObject);
begin
//  Connection.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'MicroGest.fdb');
  Connection.Params.Values['Database'] := TPath.Combine(TPath.GetPublicPath, 'MicroGest.fdb');
end;

function TPersistanceDbxFirebirdFactory.GetDocumentoDS(const ATipoDoc: String; const AID: Integer): TDataSet;
var
  LQuery: TSimpleDataSet;
begin
  LQuery := GetQuery;
  LQuery.DataSet.CommandText := 'SELECT * FROM DOCUMENTI WHERE ID = :P_ID';
  LQuery.DataSet.ParamByName('P_ID').AsInteger := AID;
  LQuery.Open;

  (LQuery.FieldByName('TOTALEIMPONIBILE') as TFMTBCDField).Currency := True;
  (LQuery.FieldByName('TOTALEIVA') as TFMTBCDField).Currency := True;
  (LQuery.FieldByName('TOTALEDOCUMENTO') as TFMTBCDField).Currency := True;

  if LQuery.Eof and (AID = 0) then
  begin
    LQuery.Append;
    LQuery.FieldByName('ID').Value := GetNextDocID;
    LQuery.FieldByName('TIPO').Value := ATipoDoc;
    LQuery.FieldByName('DATA').Value := Date;
  end;

  Result := LQuery;
end;

class function TPersistanceDbxFirebirdFactory.GetInstance: IPersistanceLayerFactory;
begin
  // Singleton
  if not Assigned(FInstance) then
    FInstance := Self.Create(nil);
  Result := FInstance;
end;

function TPersistanceDbxFirebirdFactory.GetListaArticoliDS: TDataSet;
var
  LQuery: TSimpleDataSet;
begin
  LQuery := GetQuery;
  LQuery.DataSet.CommandText := 'SELECT * FROM ARTICOLI';
  LQuery.Open;
  Result := LQuery;
end;

function TPersistanceDbxFirebirdFactory.GetListaDocumentiDS: TDataSet;
var
  LQuery: TSimpleDataSet;
begin
  LQuery := GetQuery;
  LQuery.DataSet.CommandText := 'SELECT TIPO, ID, DATA, CLIENTE, TOTALEDOCUMENTO FROM DOCUMENTI';
  LQuery.Open;

  (LQuery.FieldByName('TOTALEDOCUMENTO') as TFMTBCDField).Currency := True;

  Result := LQuery;
end;

function TPersistanceDbxFirebirdFactory.GetNextDocID: Integer;
var
  LQuery: TSimpleDataSet;
begin
  LQuery := GetQuery;
  try
    LQuery.DataSet.CommandText := 'SELECT NEXT VALUE FOR DOCUMENTI FROM RDB$DATABASE';
    LQuery.Open;
    Result := LQuery.Fields[0].AsInteger + 1;
  finally
    LQuery.Free;
  end;
end;

function TPersistanceDbxFirebirdFactory.GetNextRowID: Integer;
var
  LQuery: TSimpleDataSet;
begin
  LQuery := GetQuery;
  try
    LQuery.DataSet.CommandText := 'SELECT NEXT VALUE FOR RIGHEDOCUMENTI FROM RDB$DATABASE';
    LQuery.Open;
    Result := LQuery.Fields[0].AsInteger + 1;
  finally
    LQuery.Free;
  end;
end;

function TPersistanceDbxFirebirdFactory.GetQuery: TSimpleDataSet;
begin
  Result := TSimpleDataSet.Create(nil);
  Result.Connection := Connection;
  Result.DataSet.CommandType := ctQuery;
end;

function TPersistanceDbxFirebirdFactory.GetRigheDocumentoDS(const AID: Integer): TDataSet;
var
  LQuery: TSimpleDataSet;
begin
  LQuery := GetQuery;
  LQuery.DataSet.CommandText := 'SELECT * FROM RIGHEDOCUMENTI WHERE ID_DOC = :P_ID_DOC';
  LQuery.DataSet.ParamByName('P_ID_DOC').AsInteger := AID;
  LQuery.Open;

  (LQuery.FieldByName('PREZZO') as TFMTBCDField).Currency := True;
  (LQuery.FieldByName('IMPORTO') as TFMTBCDField).Currency := True;

  LQuery.AfterInsert := onRigheAfterInsertEventHandler;

  Result := LQuery;
end;

procedure TPersistanceDbxFirebirdFactory.onRigheAfterInsertEventHandler(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID').Value := GetNextRowID;
end;

procedure TPersistanceDbxFirebirdFactory.RollbackTransaction;
begin
  Connection.RollbackFreeAndNil(FTransaction);
end;

procedure TPersistanceDbxFirebirdFactory.StartTransaction;
begin
  FTransaction := Connection.BeginTransaction;
end;

end.
