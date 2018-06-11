unit F.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Menus, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  DM.Main;

type
  TMainForm = class(TForm)
    PanelTop: TPanel;
    ButtonExit: TSpeedButton;
    ButtonDelete: TSpeedButton;
    ButtonNew: TSpeedButton;
    ButtonAdd: TSpeedButton;
    MainMenu1: TMainMenu;
    ManuFile: TMenuItem;
    MenuDocumenti: TMenuItem;
    MenuEsci: TMenuItem;
    MenuVisualizza: TMenuItem;
    MenuNuovo: TMenuItem;
    MenuElimina: TMenuItem;
    ActionList1: TActionList;
    acEsci: TAction;
    DSListaDocumenti: TDataSource;
    DBGrid1: TDBGrid;
    acVisualizza: TAction;
    acElimina: TAction;
    ButtonRefresh: TSpeedButton;
    acRefresh: TAction;
    MenuRefresh: TMenuItem;
    N1: TMenuItem;
    PopupMenuNuovo: TPopupMenu;
    QryListaDocumenti: TFDQuery;
    QryListaDocumentiTIPO: TStringField;
    QryListaDocumentiID: TIntegerField;
    QryListaDocumentiDATA: TDateField;
    QryListaDocumentiCLIENTE: TStringField;
    QryListaDocumentiTOTALEDOCUMENTO: TFloatField;
    procedure acEsciExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acVisualizzaExecute(Sender: TObject);
    procedure acEliminaExecute(Sender: TObject);
    procedure acEliminaUpdate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure MenuNuovoClick(Sender: TObject);
    procedure ButtonNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  Vcl.Dialogs, System.UITypes, Form.Documento;

{$R *.dfm}

procedure TMainForm.acRefreshExecute(Sender: TObject);
begin
  QryListaDocumenti.Refresh;
end;

procedure TMainForm.acVisualizzaExecute(Sender: TObject);
begin
  Application.CreateForm(TDocumentoForm, DocumentoForm);
  DocumentoForm.QryDocumento.ParamByName('P_ID').AsInteger := QryListaDocumentiID.AsInteger;
  DocumentoForm.QryDocumento.Open;
  DocumentoForm.QryRighe.ParamByName('P_ID_DOC').AsInteger := QryListaDocumentiID.AsInteger;
  DocumentoForm.QryRighe.Open;
end;

procedure TMainForm.ButtonNewClick(Sender: TObject);
begin
  PopupMenuNuovo.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TMainForm.DBGrid1DblClick(Sender: TObject);
begin
  acVisualizza.Execute;
end;

procedure TMainForm.acEliminaExecute(Sender: TObject);
begin
  if MessageDlg('Eliminare il documento?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    QryListaDocumenti.Delete;
end;

procedure TMainForm.acEliminaUpdate(Sender: TObject);
begin
//  acElimina.Enabled := FModelListaDocumenti.CanDelete;
end;

procedure TMainForm.acEsciExecute(Sender: TObject);
begin
  if MessageDlg('Chiudere l''applicazione?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    Application.Terminate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  QryListaDocumenti.Open;
end;

procedure TMainForm.MenuNuovoClick(Sender: TObject);
begin
  // Da fare
end;

end.
