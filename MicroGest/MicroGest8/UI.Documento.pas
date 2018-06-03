unit UI.Documento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.UITypes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  Model.Interfaces, UI.Interfaces, System.Actions, Vcl.ActnList;

type
  TDocumentoForm = class(TForm, IUIDocumento)
    PanelTop: TPanel;
    ButtonExit: TSpeedButton;
    ButtonDeleteRow: TSpeedButton;
    ButtonAddRow: TSpeedButton;
    DSDocumento: TDataSource;
    DSRighe: TDataSource;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    ButtonCancel: TSpeedButton;
    ButtonPost: TSpeedButton;
    ActionList1: TActionList;
    acIndietro: TAction;
    acSalva: TAction;
    acAnnulla: TAction;
    acNuovaRiga: TAction;
    acEliminaRiga: TAction;
    DBText1: TDBText;
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure acIndietroExecute(Sender: TObject);
    procedure acSalvaExecute(Sender: TObject);
    procedure acAnnullaExecute(Sender: TObject);
    procedure acNuovaRigaExecute(Sender: TObject);
    procedure acEliminaRigaExecute(Sender: TObject);
    procedure acSalvaUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FDocumento: IModelDocumento;
  public
    { Public declarations }
    procedure SetDocumento(const ADocumento: IModelDocumento);
  end;

implementation

{$R *.dfm}

{ TDocumentoForm }

procedure TDocumentoForm.acAnnullaExecute(Sender: TObject);
begin
  if MessageDlg('Annullare le modifiche?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    FDocumento.Cancel;
end;

procedure TDocumentoForm.acEliminaRigaExecute(Sender: TObject);
begin
  FDocumento.EliminaRiga;
end;

procedure TDocumentoForm.acIndietroExecute(Sender: TObject);
begin
  if not (FDocumento.CanSave and (MessageDlg('Ci sono modifiche non salvate che andranno perdute.'#13#13'Uscire ugualmente?', mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes)) then
    Close;
end;

procedure TDocumentoForm.acNuovaRigaExecute(Sender: TObject);
begin
  FDocumento.AggiungiRiga;
end;

procedure TDocumentoForm.acSalvaExecute(Sender: TObject);
begin
  FDocumento.Save;
end;

procedure TDocumentoForm.acSalvaUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := FDocumento.CanSave;
end;

procedure TDocumentoForm.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = VK_RETURN then
    DSRighe.DataSet.Post;
end;

procedure TDocumentoForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TDocumentoForm.SetDocumento(const ADocumento: IModelDocumento);
begin
  FDocumento := ADocumento;

  DSDocumento.DataSet := FDocumento.GetDataSet;
  DSRighe.DataSet := FDocumento.GetDataSetRighe;
end;

end.
