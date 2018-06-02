unit Model.Documento.Lista;

interface

uses
  Data.DB, Model.Interfaces;

type

  TModelListaDocumenti = class(TInterfacedObject, IModelListaDocumenti)
  private
    FDataSet: TDataSet;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function GetDataSet: TDataSet;
    procedure Refresh;
    procedure Append;
    procedure Delete;
    procedure Edit;
    function CanDelete: Boolean;
  end;

implementation

uses
  Persistence.Factory, UI.Factory;

{ TListaDocumenti }

procedure TModelListaDocumenti.Append;
begin
  TUIFactory.GetViewDocumento(FDataSet.FieldByName('TIPO').AsString);
end;

function TModelListaDocumenti.CanDelete: Boolean;
begin
  Result := FDataSet.RecordCount > 0;
end;

constructor TModelListaDocumenti.Create;
begin
  FDataSet := TPersistanceFactory.GetConcreteFactory.GetListaDocumentiDS;
end;

procedure TModelListaDocumenti.Delete;
begin
  FDataSet.Delete;
end;

destructor TModelListaDocumenti.Destroy;
begin
  FDataSet.Free;
  inherited;
end;

procedure TModelListaDocumenti.Edit;
begin
  TUIFactory.GetViewDocumento(FDataSet.FieldByName('TIPO').AsString, FDataSet.FieldByName('ID').AsInteger);
end;

function TModelListaDocumenti.GetDataSet: TDataSet;
begin
  Result := FDataSet;
end;

procedure TModelListaDocumenti.Refresh;
begin
  FDataSet.Refresh;
end;

end.
