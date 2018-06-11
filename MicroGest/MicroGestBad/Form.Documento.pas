unit Form.Documento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.UITypes, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids,
  System.Actions, Vcl.ActnList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DM.Main;

type
  TDocumentoForm = class(TForm)
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
    QryDocumento: TFDQuery;
    QryRighe: TFDQuery;
    QryDocumentoID: TIntegerField;
    QryDocumentoDATA: TDateField;
    QryDocumentoTIPO: TStringField;
    QryDocumentoCLIENTE: TStringField;
    QryDocumentoTOTALEIMPONIBILE: TFloatField;
    QryDocumentoTOTALEIVA: TFloatField;
    QryDocumentoTOTALEDOCUMENTO: TFloatField;
    QryDocumentoVALIDITA_GG: TIntegerField;
    QryDocumentoPAGAMENTO: TStringField;
    QryRigheID: TFDAutoIncField;
    QryRigheID_DOC: TIntegerField;
    QryRigheCODICE: TStringField;
    QryRigheDESCRIZIONE: TStringField;
    QryRigheQTA: TFloatField;
    QryRighePREZZO: TFloatField;
    QryRigheSCONTO: TFloatField;
    QryRigheIMPORTO: TFloatField;
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure acIndietroExecute(Sender: TObject);
    procedure acSalvaExecute(Sender: TObject);
    procedure acAnnullaExecute(Sender: TObject);
    procedure acNuovaRigaExecute(Sender: TObject);
    procedure acEliminaRigaExecute(Sender: TObject);
    procedure acSalvaUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QryDocumentoBeforePost(DataSet: TDataSet);
    procedure QryRigheBeforePost(DataSet: TDataSet);
    procedure QryRigheAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    FCalculating: Boolean;
    procedure Calculate;
    procedure Validate;
  public
    { Public declarations }
  end;

var
  DocumentoForm: TDocumentoForm;

implementation

uses
  F.Articoli.Lista;

{$R *.dfm}

{ TDocumentoForm }

procedure TDocumentoForm.acAnnullaExecute(Sender: TObject);
begin
  if MessageDlg('Annullare le modifiche?', mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
    QryDocumento.CancelUpdates;
    QryRighe.CancelUpdates;
  end;
end;

procedure TDocumentoForm.acEliminaRigaExecute(Sender: TObject);
begin
  QryRighe.Delete;
  Calculate;
end;

procedure TDocumentoForm.acIndietroExecute(Sender: TObject);
begin
  if (QryDocumento.UpdatesPending or (QryDocumento.State in [dsEdit, dsInsert])
  or QryRighe.UpdatesPending or (QryRighe.State in [dsEdit, dsInsert]))
  and (MessageDlg('Ci sono modifiche non salvate che andranno perdute.'#13#13'Uscire ugualmente?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) <> mrYes)
  then
    Exit;
  Close;
end;

procedure TDocumentoForm.acNuovaRigaExecute(Sender: TObject);
begin
  Application.CreateForm(TListaArticoliForm, ListaArticoliForm);
end;

procedure TDocumentoForm.acSalvaExecute(Sender: TObject);
begin
  MainDM.FDConnection1.StartTransaction;
  try
    // Documento
    if (QryDocumento.State in [dsEdit, dsInsert]) then
      QryDocumento.Post;
    if QryDocumento.UpdatesPending then
      QryDocumento.ApplyUpdates;
    // Righe
    if (QryRighe.State in [dsEdit, dsInsert]) then
      QryRighe.Post;
    if QryRighe.UpdatesPending then
      QryRighe.ApplyUpdates;

    MainDM.FDConnection1.Commit;

    QryDocumento.CommitUpdates;
    QryRighe.CommitUpdates;
  except
    MainDM.FDConnection1.Rollback;
    raise;
  end;
end;

procedure TDocumentoForm.acSalvaUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (QryDocumento.UpdatesPending
  or (QryDocumento.State in [dsEdit, dsInsert])
  or QryRighe.UpdatesPending
  or (QryRighe.State in [dsEdit, dsInsert]));
end;

procedure TDocumentoForm.Calculate;
var
  LTotaleRighe: Currency;
  LBookmark: TBookmark;
begin
  // Check if calculating
  if FCalculating then
    Exit
  else
    FCalculating := True;

  LBookmark := QryRighe.GetBookmark;
  QryRighe.DisableControls;
  try
    LTotaleRighe := 0;
    QryRighe.First;
    while not QryRighe.Eof do
    begin
      LTotaleRighe := LTotaleRighe + QryRighe.FieldByName('IMPORTO').AsCurrency;
      QryRighe.Next;
    end;
    if not (QryDocumento.State in [dsInsert, dsEdit]) then
      QryDocumento.Edit;
    QryDocumento.FieldByName('TOTALEIMPONIBILE').AsCurrency := LTotaleRighe;
    QryDocumento.FieldByName('TOTALEIVA').AsCurrency := LTotaleRighe * 0.22;
    QryDocumento.FieldByName('TOTALEDOCUMENTO').AsCurrency := LTotaleRighe * 1.22;
    QryDocumento.Post;
  finally
    QryRighe.GotoBookmark(LBookmark);
    QryRighe.EnableControls;
    FCalculating := False;
  end;
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

procedure TDocumentoForm.QryDocumentoBeforePost(DataSet: TDataSet);
begin
  Validate;
  Calculate;
end;

procedure TDocumentoForm.QryRigheAfterPost(DataSet: TDataSet);
begin
  Calculate;
end;

procedure TDocumentoForm.QryRigheBeforePost(DataSet: TDataSet);
var
  LTemp: Currency;
begin
  // Validate
  if QryRighe.FieldByName('QTA').AsFloat <= 0 then
     raise Exception.Create('La quantità deve essere maggiore di zero.');
  if QryRighe.FieldByName('PREZZO').AsCurrency <= 0 then
     raise Exception.Create('Il prezzo uintario deve essere maggiore di zero.');
  // Calcolo importi riga
  LTemp := QryRighe.FieldByName('PREZZO').AsCurrency * QryRighe.FieldByName('QTA').AsFloat;
  QryRighe.FieldByName('IMPORTO').AsCurrency := LTemp * (100 - QryRighe.FieldByName('SCONTO').AsFloat) / 100;
end;

procedure TDocumentoForm.Validate;
begin
  if QryDocumento.FieldByName('CLIENTE').AsString.Trim.IsEmpty then
     raise Exception.Create('Cliente non specificato.');
end;

end.
