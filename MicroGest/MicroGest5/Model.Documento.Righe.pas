unit Model.Documento.Righe;

interface

uses
  Model.Interfaces, Data.DB, Persistence.Interfaces, System.SysUtils;

type

  TModelRigheDocumento = class(TInterfacedObject, IModelRigheDocumento)
  private
    FDataSet: TDataSet;
    FCalcMethod: TProc;
  protected
    procedure onBeforePostEventHandler(DataSet: TDataSet); virtual;
    procedure onAfterPostEventHandler(DataSet: TDataSet); virtual;
    procedure Validate; virtual;
    procedure Calculate; virtual;
  public
    constructor Create(const ADocID: Integer; const ACalcMethod:TProc);
    destructor Destroy; override;
    function GetDataSet: TDataSet;
    procedure Append(const ADocID: Integer; const ACodice, ADescrizione: String; const AQta, APrezzo: Double);
    procedure Delete;
  end;

implementation

uses
  Persistence.Factory;

{ TDocumentoRighe }

procedure TModelRigheDocumento.Append(const ADocID: Integer; const ACodice, ADescrizione: String; const AQta, APrezzo: Double);
begin
  FDataSet.Append;
  FDataSet.FieldByName('ID_DOC').Value := ADocID;
  FDataSet.FieldByName('CODICE').Value := ACodice;
  FDataSet.FieldByName('DESCRIZIONE').Value := ADescrizione;
  FDataSet.FieldByName('QTA').Value := AQta;
  FDataSet.FieldByName('PREZZO').Value := APrezzo;
  FDataSet.Post;
end;

procedure TModelRigheDocumento.Calculate;
var
  LTemp: Currency;
begin
  LTemp := FDataSet.FieldByName('PREZZO').AsCurrency * FDataSet.FieldByName('QTA').AsFloat;
  FDataSet.FieldByName('IMPORTO').AsCurrency := LTemp * (100 - FDataSet.FieldByName('SCONTO').AsFloat) / 100;
end;

constructor TModelRigheDocumento.Create(const ADocID: Integer; const ACalcMethod:TProc);
begin
  FCalcMethod := ACalcMethod;

  FDataSet := TPersistanceFactory.GetConcreteFactory.GetRigheDocumentoDS(ADocID);
  FDataSet.BeforePost := onBeforePostEventHandler;
  FDataSet.AfterPost := onAfterPostEventHandler;
end;

procedure TModelRigheDocumento.Delete;
begin
  FDataSet.Delete;
end;

destructor TModelRigheDocumento.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

function TModelRigheDocumento.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

procedure TModelRigheDocumento.onAfterPostEventHandler(DataSet: TDataSet);
begin
  FCalcMethod;
end;

procedure TModelRigheDocumento.onBeforePostEventHandler(DataSet: TDataSet);
begin
  Validate;
  Calculate;
end;

procedure TModelRigheDocumento.Validate;
begin
  if FDataSet.FieldByName('QTA').AsFloat <= 0 then
     raise Exception.Create('La quantità deve essere maggiore di zero.');
  if FDataSet.FieldByName('PREZZO').AsCurrency <= 0 then
     raise Exception.Create('Il prezzo uintario deve essere maggiore di zero.');
end;

end.
