unit UI.Factory;

interface

uses
  UI.Interfaces, Model.Interfaces;

type

  TUIFactory = class
  public
    class function GetViewDocumento(const ATipo: String; const AID: Integer = 0): IUIDocumento;
    class procedure GetViewListaArticoli(const ASelectionMethod: TSelectionMethod);
  end;

implementation

uses
  UI.Documento, Model.Factory, UI.Articoli.Lista, System.SysUtils;

{ TViewFactory }

class function TUIFactory.GetViewDocumento(const ATipo: String; const AID: Integer): IUIDocumento;
var
  LDocumento: IModelDocumento;
begin
  LDocumento := TModelFactory.GetModelDocumento(ATipo, AID);

  Result := TDocumentoForm.Create(nil);

  Result.SetDocumento(LDocumento);
end;

class procedure TUIFactory.GetViewListaArticoli(const ASelectionMethod: TSelectionMethod);
var
  LModelListaArticoli: IModelListaArticoli;
begin
  LModelListaArticoli := TModelFactory.GetModelListaArticoli(ASelectionMethod);
  TListaArticoliForm.Create(nil, LModelListaArticoli);
end;

end.
