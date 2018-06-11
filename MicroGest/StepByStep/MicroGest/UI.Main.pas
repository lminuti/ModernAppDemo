unit UI.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Menus, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids,
  Model.Interfaces;

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
    FModelListaDocumenti: IModelListaDocumenti;
    procedure PopolaMenuNuovo;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  Model.Factory, Vcl.Dialogs, System.UITypes, UI.Factory;

{$R *.dfm}

procedure TMainForm.acRefreshExecute(Sender: TObject);
begin
  FModelListaDocumenti.Refresh;
end;

procedure TMainForm.acVisualizzaExecute(Sender: TObject);
begin
  FModelListaDocumenti.Edit;
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
    FModelListaDocumenti.Delete;
end;

procedure TMainForm.acEliminaUpdate(Sender: TObject);
begin
  acElimina.Enabled := FModelListaDocumenti.CanDelete;
end;

procedure TMainForm.acEsciExecute(Sender: TObject);
begin
  if MessageDlg('Chiudere l''applicazione?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    Application.Terminate;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FModelListaDocumenti := TModelFactory.GetModelListaDocumenti;
  DSListaDocumenti.DataSet := FModelListaDocumenti.GetDataSet;
  PopolaMenuNuovo;
end;

procedure TMainForm.MenuNuovoClick(Sender: TObject);
begin
  TUIFactory.GetConcreteFactory.GetUIDocumento(  (Sender as TMenuItem).Caption  );
end;

procedure TMainForm.PopolaMenuNuovo;
var
  LTipiDocs: TStrings;
  LTipoDoc: String;
  function NewMenuItem: TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    Result.Caption := LTipoDoc;
    Result.OnClick := MenuNuovoClick;
  end;
begin
  LTipiDocs := TModelFactory.GetListaTipiDocumenti;
  try
    for LTipoDoc in LTipiDocs do
    begin
      // Add main menù item
      MenuNuovo.Add( NewMenuItem );
      // Add popup menù item
      PopupMenuNuovo.Items.Add( NewMenuItem );
    end;
  finally
    LTipiDocs.Free;
  end;
end;

end.
