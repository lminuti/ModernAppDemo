program MicroGest7_FMX;

uses
  System.StartUpCopy,
  FMX.Forms,
  UI.Start in 'UI.Start.pas' {StartForm},
  Model.Articoli.Lista in 'Model.Articoli.Lista.pas',
  Model.Documento.Calcola in 'Model.Documento.Calcola.pas',
  Model.Documento.CalcolaIC in 'Model.Documento.CalcolaIC.pas',
  Model.Documento.Lista in 'Model.Documento.Lista.pas',
  Model.Documento in 'Model.Documento.pas',
  Model.Documento.Preventivo in 'Model.Documento.Preventivo.pas',
  Model.Documento.Righe in 'Model.Documento.Righe.pas',
  Model.Factory in 'Model.Factory.pas',
  Model.Interfaces in 'Model.Interfaces.pas',
  Persistence.Factory in 'Persistence.Factory.pas',
  Persistence.FireDAC.SQLite in 'Persistence.FireDAC.SQLite.pas',
  Persistence.Interfaces in 'Persistence.Interfaces.pas',
  UI.Interfaces in 'UI.Interfaces.pas',
  UI.Base in 'UI.Base.pas' {UIBase: TFrame},
  UI.Factory in 'UI.Factory.pas',
  UI.Factory.FMX in 'UI.Factory.FMX.pas',
  UI.Documento.Lista in 'UI.Documento.Lista.pas' {UIDocumentoLista: TFrame},
  UI.Documento in 'UI.Documento.pas' {UIDocumento: TFrame},
  UI.Articoli.Lista in 'UI.Articoli.Lista.pas' {UIListaArticoli: TFrame},
  UI.Documento.Preventivo in 'UI.Documento.Preventivo.pas' {UIPreventivo: TFrame},
  UI.Documento.Fattura in 'UI.Documento.Fattura.pas' {UIFattura: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TStartForm, StartForm);
  Application.Run;
end.
