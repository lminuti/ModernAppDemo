unit UI.Factory.FMX;

interface

uses
  UI.Interfaces, Model.Interfaces, FMX.Controls;

type

  TUIFactoryFMX = class(TInterfacedObject, IUILayerFactory)
  private
    class var FInstance: IUILayerFactory;
  protected
    function GetNewViewContext: TControl; virtual;
    procedure StartAnim;
  public
    class function GetInstance: IUILayerFactory;
    function GetUIDocumento(const ATipo: String; const AID: Integer = 0): IUIDocumento;
    procedure GetUIListaArticoli(const ASelectionMethod: TSelectionMethod);
  end;

implementation

uses
  UI.Start, Model.Factory, System.SysUtils, UI.Documento, FMX.Types,
  UI.Articoli.Lista, UI.Documento.Preventivo, UI.Documento.Fattura;

{ TUIFactoryFMX }

class function TUIFactoryFMX.GetInstance: IUILayerFactory;
begin
  // Singleton
  if not Assigned(FInstance) then
    FInstance := Self.Create;
  Result := FInstance;
end;

function TUIFactoryFMX.GetNewViewContext: TControl;
begin
  Result := StartForm.MainTabControl.Add;
end;

function TUIFactoryFMX.GetUIDocumento(const ATipo: String; const AID: Integer): IUIDocumento;
var
  LDocumento: IModelDocumento;
  LViewContext: TControl;
begin
  LDocumento := TModelFactory.GetModelDocumento(ATipo, AID);
  LViewContext := GetNewViewContext;

  if ATipo.StartsWith('Preventivo') then
    Result := TUIPreventivo.Create(LViewContext)
  else
  if ATipo.StartsWith('Fattura') then
    Result := TUIFattura.Create(LViewContext)
  else
    Result := TUIDocumento.Create(LViewContext);

  Result.SetDocumento(LDocumento);

  (Result as TControl).Parent := LViewContext;
  (Result as TControl).Align := TAlignLayout.Client;
  StartAnim;
end;

procedure TUIFactoryFMX.GetUIListaArticoli(const ASelectionMethod: TSelectionMethod);
var
  LModelListaArticoli: IModelListaArticoli;
  LViewContext: TControl;
begin
  LModelListaArticoli := TModelFactory.GetModelListaArticoli(ASelectionMethod);
  LViewContext := GetNewViewContext;

  with TUIListaArticoli.Create(LViewContext, LModelListaArticoli) as TControl do
  begin
    Parent := LViewContext;
    Align := TAlignLayout.Client;
    StartAnim;
  end;
end;

procedure TUIFactoryFMX.StartAnim;
begin
  StartForm.NextTabAction1.Execute;
end;

end.
