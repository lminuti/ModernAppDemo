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
  Model.Factory, System.SysUtils, UI.Documento.Preventivo, UI.Documento.Fattura,
  UI.Documento, UI.Articoli.Lista;

{ TViewFactory }

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

  if ATipo.StartsWith('Preventivo') then
    Result := TUIPreventivo.Create(nil)
  else
  if ATipo.StartsWith('Fattura') then
    Result := TUIFattura.Create(nil)
  else
    Result := TUIDocumento.Create(nil);

  Result.SetDocumento(LDocumento);
end;

procedure TUIFactoryVCL.GetUIListaArticoli(const ASelectionMethod: TSelectionMethod);
var
  LModelListaArticoli: IModelListaArticoli;
begin
  LModelListaArticoli := TModelFactory.GetModelListaArticoli(ASelectionMethod);
  TUIListaArticoli.Create(nil, LModelListaArticoli);
end;

end.
