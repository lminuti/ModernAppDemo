unit Model.Articoli.Lista;

interface

uses
  Model.Interfaces, Data.DB;

type

  TModelListaArticoli = class(TInterfacedObject, IModelListaArticoli)
  private
    FDataSet: TDataSet;
    FSelectionMethod: TSelectionMethod;
  protected
  public
    constructor Create(const ASelectionMethod: TSelectionMethod);
    destructor Destroy; override;
    function GetDataSet: TDataSet;
    procedure Seleziona;
  end;

implementation

uses
  Persistence.Factory;

{ TModelListaArticoli }

constructor TModelListaArticoli.Create(const ASelectionMethod: TSelectionMethod);
begin
  FSelectionMethod := ASelectionMethod;
  FDataSet := TPersistanceFactory.GetConcreteFactory.GetListaArticoliDS;
end;

destructor TModelListaArticoli.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

function TModelListaArticoli.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

procedure TModelListaArticoli.Seleziona;
begin
  FSelectionMethod(
    FDataSet.FieldByName('CODICE').AsString,
    FDataSet.FieldByName('DESCRIZIONE').AsString,
    FDataSet.FieldByName('PREZZO').AsCurrency);
end;

end.
