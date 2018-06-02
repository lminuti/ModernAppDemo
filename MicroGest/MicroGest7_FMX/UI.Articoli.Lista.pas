unit UI.Articoli.Lista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, UI.Base, System.Actions, FMX.ActnList,
  FMX.Controls.Presentation, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.Components, Data.Bind.DBScope,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Model.Interfaces;

type
  TUIListaArticoli = class(TUIBase)
    BindSourceDB1: TBindSourceDB;
    FDMemTable1: TFDMemTable;
    FDMemTable1DESCRIZIONE: TStringField;
    FDMemTable1PREZZO: TCurrencyField;
    ListView1: TListView;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    acSeleziona: TAction;
    procedure acSelezionaExecute(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    { Private declarations }
    FModelListaArticoli: IModelListaArticoli;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AModelListaArticoli: IModelListaArticoli); overload;
  end;

implementation

{$R *.fmx}

procedure TUIListaArticoli.acSelezionaExecute(Sender: TObject);
begin
  inherited;
  FModelListaArticoli.Seleziona;
end;

constructor TUIListaArticoli.Create(AOwner: TComponent; AModelListaArticoli: IModelListaArticoli);
begin
  inherited Create(AOwner);
  FModelListaArticoli := AModelListaArticoli;
  BindSourceDB1.DataSet := FModelListaArticoli.GetDataSet;
end;

procedure TUIListaArticoli.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  inherited;
  acSeleziona.Execute;
end;

end.
