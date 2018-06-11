unit UI.Start;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Graphics, FMX.Forms, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.Bind.Components, Data.Bind.DBScope, FMX.ListView, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Model.Interfaces;

type
  TStartForm = class(TForm)
    ActionList1: TActionList;
    PreviousTabAction1: TPreviousTabAction;
    NextTabAction1: TNextTabAction;
    MainTabControl: TTabControl;
    TabItemMain: TTabItem;
    ToolBarTop: TToolBar;
    SpeedButton1: TSpeedButton;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    acEsci: TAction;
    acVisualizza: TAction;
    FDMemTable1: TFDMemTable;
    FDMemTable1CLIENTE: TStringField;
    FDMemTable1TIPO: TStringField;
    FDMemTable1DATA: TDateField;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure acEsciExecute(Sender: TObject);
    procedure acVisualizzaExecute(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    { Private declarations }
    FModelListaDocumenti: IModelListaDocumenti;
  public
    { Public declarations }
  end;

var
  StartForm: TStartForm;

implementation

uses
  Model.Factory;

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone4in.fmx IOS}

procedure TStartForm.acEsciExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TStartForm.acVisualizzaExecute(Sender: TObject);
begin
  FModelListaDocumenti.Edit;
end;

procedure TStartForm.FormCreate(Sender: TObject);
begin
  FModelListaDocumenti := TModelFactory.GetModelListaDocumenti;
  BindSourceDB1.DataSet := FModelListaDocumenti.GetDataSet;
end;

procedure TStartForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = vkHardwareBack) and (MainTabControl.TabIndex <> 0) then
  begin
    MainTabControl.First;
    Key := 0;
  end;
end;

procedure TStartForm.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  acVisualizza.Execute;
end;

end.
