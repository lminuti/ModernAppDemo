unit UI.Factory.VCL;

interface

uses
  UI.Interfaces, Model.Interfaces;

type

  TUIFactoryVCL = class(TInterfacedObject, IUILayerFactory)
  private
    class var FInstance: IUILayerFactory;
  public
    class function GetInstance: IUILayerFactory;
    function GetUIDocumento(const ATipo: String; const AID: Integer = 0): IUIDocumento;
    procedure GetUIListaArticoli(const ASelectionMethod: TSelectionMethod);
  end;

implementation

uses
  Model.Factory, UI.Documento, UI.Articoli.Lista, System.SysUtils,
  UI.Documento.Preventivo, UI.Documento.Fattura;

{ TUIFactoryVCL }

class function TUIFactoryVCL.GetInstance: IUILayerFactory;
begin
  // Singleton
  if not Assigned(FInstance) then
    FInstance := Self.Create;
  Result := FInstance;
end;

function TUIFactoryVCL.GetUIDocumento(const ATipo: String; const AID: Integer): IUIDocumento;
var
  LDocumento: IModelDocumento;
begin
  LDocumento := TModelFactory.GetModelDocumento(ATipo, AID);

  Result := TDocumentoForm.Create(nil);

  Result.SetDocumento(LDocumento);
end;

procedure TUIFactoryVCL.GetUIListaArticoli(const ASelectionMethod: TSelectionMethod);
var
  LModelListaArticoli: IModelListaArticoli;
begin
  LModelListaArticoli := TModelFactory.GetModelListaArticoli(ASelectionMethod);
  TListaArticoliForm.Create(nil, LModelListaArticoli);
end;

end.
