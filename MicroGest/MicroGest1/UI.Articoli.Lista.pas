unit UI.Articoli.Lista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Model.Interfaces, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls;

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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acIndietroExecute(Sender: TObject);
    procedure acSelezionaExecute(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    FModelListaArticoli: IModelListaArticoli;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AModelListaArticoli: IModelListaArticoli); overload;
  end;

implementation

{$R *.dfm}

{ TTListaArticoliForm }

procedure TListaArticoliForm.acIndietroExecute(Sender: TObject);
begin
  Close;
end;

procedure TListaArticoliForm.acSelezionaExecute(Sender: TObject);
begin
  FModelListaArticoli.Seleziona;
  acIndietro.Execute;
end;

constructor TListaArticoliForm.Create(AOwner: TComponent; AModelListaArticoli: IModelListaArticoli);
begin
  inherited Create(AOwner);
  FModelListaArticoli := AModelListaArticoli;
  DSListaArticoli.DataSet := FModelListaArticoli.GetDataSet;
end;

procedure TListaArticoliForm.DBGrid1DblClick(Sender: TObject);
begin
  acSeleziona.Execute;
end;

procedure TListaArticoliForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
