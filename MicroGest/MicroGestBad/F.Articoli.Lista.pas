unit F.Articoli.Lista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.UITypes, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, DM.Main, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TListaArticoliForm = class(TForm)
    PanelTop: TPanel;
    ButtonAnnulla: TSpeedButton;
    ButtonSeleziona: TSpeedButton;
    DBGrid1: TDBGrid;
    DSListaArticoli: TDataSource;
    ActionList1: TActionList;
    acIndietro: TAction;
    acSeleziona: TAction;
    Label1: TLabel;
    QryListaArticoli: TFDQuery;
    QryListaArticoliCODICE: TStringField;
    QryListaArticoliDESCRIZIONE: TStringField;
    QryListaArticoliPREZZO: TFloatField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acIndietroExecute(Sender: TObject);
    procedure acSelezionaExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ListaArticoliForm: TListaArticoliForm;

implementation

uses
  Form.Documento;

{$R *.dfm}

{ TTListaArticoliForm }

procedure TListaArticoliForm.acIndietroExecute(Sender: TObject);
begin
  Close;
end;

procedure TListaArticoliForm.acSelezionaExecute(Sender: TObject);
begin
  with DocumentoForm.QryRighe do
  begin
    Append;
    FieldByName('ID_DOC').Value := DocumentoForm.QryDocumento.FieldByName('ID').AsInteger;
    FieldByName('CODICE').Value := QryListaArticoli.FieldByName('CODICE').AsString;
    FieldByName('DESCRIZIONE').Value := QryListaArticoli.FieldByName('DESCRIZIONE').AsString;
    FieldByName('QTA').Value := 1;
    FieldByName('PREZZO').Value := QryListaArticoli.FieldByName('PREZZO').AsCurrency;
    Post;
  end;
  acIndietro.Execute;
end;

procedure TListaArticoliForm.DBGrid1DblClick(Sender: TObject);
begin
  acSeleziona.Execute;
end;

procedure TListaArticoliForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TListaArticoliForm.FormCreate(Sender: TObject);
begin
  QryListaArticoli.Open;
end;

end.
