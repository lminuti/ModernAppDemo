unit Model.Documento;

interface

uses
  Data.DB, Model.Interfaces, Persistence.Interfaces;

type

  TModelDocumento = class(TInterfacedObject, IModelDocumento)
  private
    FPersistance: IPersistanceLayerFactory;
    FDataSet: TDataSet;
    FRighe: IModelRigheDocumento;
    FCalcolatoreDoc: ICalcolatoreDoc;
  protected
    procedure onBeforePostEventHandler(DataSet: TDataSet); virtual;
    procedure Validate; virtual;
    procedure Calculate; virtual;
  public
    constructor Create(const ATipo: String; const ADocID: Integer);
    destructor Destroy; override;
    function GetDataSet: TDataSet;
    function GetDataSetRighe: TDataSet;
    function CanSave: Boolean;
    procedure Save;
    procedure Cancel;
    procedure AggiungiRiga;
    procedure EliminaRiga;
  end;

implementation

uses
  Persistence.Factory, Model.Factory, System.SysUtils, UI.Factory;

{ TDocumento }

procedure TModelDocumento.Calculate;
begin
  FCalcolatoreDoc.Calcola(FDataSet, GetDataSetRighe);
end;

procedure TModelDocumento.Cancel;
begin
  // Cancel documento
  FPersistance.CancelUpdates(FDataSet);
  // Cancel righe
  FPersistance.CancelUpdates(GetDataSetRighe);
end;

function TModelDocumento.CanSave: Boolean;
begin
  Result := FPersistance.CanSave(FDataSet) or FPersistance.CanSave(GetDataSetRighe);
end;

constructor TModelDocumento.Create(const ATipo: String; const ADocID: Integer);
//var
//  LCalcMethod: TProc;
begin
  FPersistance := TPersistanceFactory.GetConcreteFactory;

  FDataSet := FPersistance.GetDocumentoDS(ATipo, ADocID);
  FDataSet.BeforePost := onBeforePostEventHandler;

  FCalcolatoreDoc := TModelFactory.GetCalcolatoreDoc(ATipo);

  FRighe := TModelFactory.GetModelRigheDocumento(ADocID,
    procedure
    begin
      FCalcolatoreDoc.Calcola(FDataSet, GetDataSetRighe);
    end
  );

//  LCalcMethod := procedure
//    begin
//      FCalcolatoreDoc.Calcola(FDataSet, GetDataSetRighe);
//    end;
//  FRighe := TModelFactory.GetRigheDocumento(ADocID, LCalcMethod);
end;

destructor TModelDocumento.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

procedure TModelDocumento.EliminaRiga;
begin
  FRighe.Delete;
  Calculate;
end;

function TModelDocumento.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

function TModelDocumento.GetDataSetRighe: TDataSet;
begin
  Result := FRighe.GetDataSet;
end;

procedure TModelDocumento.AggiungiRiga;
begin
  TUIFactory.GetViewListaArticoli(
    procedure(ACodice, ADescrizione: String; APrezzo: Currency)
    begin
      FRighe.Append(
        FDataSet.FieldByName('ID').AsInteger,
        ACodice,
        ADescrizione,
        1,
        APrezzo);
    end
  );
end;

procedure TModelDocumento.onBeforePostEventHandler(DataSet: TDataSet);
begin
  Validate;
  Calculate;
end;

procedure TModelDocumento.Save;
begin
  FPersistance.StartTransaction;
  try
    FPersistance.ApplyUpdates(FDataSet);
    FPersistance.ApplyUpdates(GetDataSetRighe);

    FPersistance.CommitTransaction;

    FPersistance.CommitUpdates(FDataSet);
    FPersistance.CommitUpdates(GetDataSetRighe);
  except
    FPersistance.RollbackTransaction;
    raise;
  end;
end;

procedure TModelDocumento.Validate;
begin
  if FDataSet.FieldByName('CLIENTE').AsString.Trim.IsEmpty then
     raise Exception.Create('Cliente non specificato.');
end;

end.
