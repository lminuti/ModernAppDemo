unit UI.Documento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, UI.Base, FMX.Controls.Presentation, System.Actions,
  FMX.ActnList, UI.Interfaces, Model.Interfaces, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.DateTimeCtrls, Data.Bind.Components,
  Data.Bind.DBScope, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TUIDocumento = class(TUIBase, IUIDocumento)
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    EditCliente: TEdit;
    ListBoxItem2: TListBoxItem;
    EditData: TDateEdit;
    DocBindSourceDB: TBindSourceDB;
    DocMemTable: TFDMemTable;
    DocMemTableTIPO: TStringField;
    DocMemTableDATA: TDateField;
    DocMemTableCLIENTE: TStringField;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    ListBox2: TListBox;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    EditTotaleIVA: TEdit;
    EditTotaleDocumento: TEdit;
    EditTotaleImponibile: TEdit;
    DocMemTableTOTALEIMPONIBILE: TCurrencyField;
    DocMemTableTOTALEIVA: TCurrencyField;
    DocMemTableTOTALEDOCUMENTO: TCurrencyField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    RigheBindSourceDB: TBindSourceDB;
    RigheMemTable: TFDMemTable;
    RigheMemTableID: TIntegerField;
    RigheMemTableID_DOC: TIntegerField;
    RigheMemTableCODICE: TStringField;
    RigheMemTableDESCRIZIONE: TStringField;
    RigheMemTableQTA: TFloatField;
    RigheMemTablePREZZO: TCurrencyField;
    RigheMemTableSCONTO: TFloatField;
    RigheMemTableIMPORTO: TCurrencyField;
    ListViewRighe: TListView;
    LinkListControlToField1: TLinkListControlToField;
    SpeedButton2: TSpeedButton;
    acNuovaRiga: TAction;
    acEliminaRiga: TAction;
    SpeedButton3: TSpeedButton;
    ListBoxItem6: TListBoxItem;
    EditQta: TEdit;
    EditPrezzo: TEdit;
    EditSconto: TEdit;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField7: TLinkControlToField;
    LinkControlToField8: TLinkControlToField;
    ListBoxItem7: TListBoxItem;
    procedure acNuovaRigaExecute(Sender: TObject);
    procedure acEliminaRigaExecute(Sender: TObject);
    procedure acBackExecute(Sender: TObject);
  private
    { Private declarations }
    FDocumento: IModelDocumento;
  public
    { Public declarations }
    procedure SetDocumento(const ADocumento: IModelDocumento);
  end;

implementation

{$R *.fmx}

{ TUIDocumento }

procedure TUIDocumento.acBackExecute(Sender: TObject);
begin
  if FDocumento.CanSave then
    FDocumento.Save;
  inherited;
end;

procedure TUIDocumento.acEliminaRigaExecute(Sender: TObject);
begin
  inherited;
  FDocumento.EliminaRiga;
end;

procedure TUIDocumento.acNuovaRigaExecute(Sender: TObject);
begin
  inherited;
  FDocumento.AggiungiRiga;
end;

procedure TUIDocumento.SetDocumento(const ADocumento: IModelDocumento);
begin
  FDocumento := ADocumento;

  DocBindSourceDB.DataSet := FDocumento.GetDataSet;
  RigheBindSourceDB.DataSet := FDocumento.GetDataSetRighe;
end;

end.
