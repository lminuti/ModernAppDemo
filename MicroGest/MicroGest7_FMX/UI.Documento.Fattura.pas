unit UI.Documento.Fattura;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, UI.Documento, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.DB, Data.Bind.Components, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, System.Actions,
  FMX.ActnList, FMX.ListView, FMX.DateTimeCtrls, FMX.Edit, FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation;

type
  TUIFattura = class(TUIDocumento)
    ListBoxItem8: TListBoxItem;
    EditPagamento: TEdit;
    DocMemTablePAGAMENTO: TStringField;
    LinkControlToField9: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UIFattura: TUIFattura;

implementation

{$R *.fmx}

end.
