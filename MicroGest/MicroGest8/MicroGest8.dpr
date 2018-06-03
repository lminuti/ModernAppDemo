program MicroGest8;

uses
  Vcl.Forms,
  UI.Main in 'UI.Main.pas' {MainForm},
  Persistence.Interfaces in 'Persistence.Interfaces.pas',
  Model.Documento.Righe in 'Model.Documento.Righe.pas',
  Model.Documento in 'Model.Documento.pas',
  Model.Factory in 'Model.Factory.pas',
  Model.Documento.Calcola in 'Model.Documento.Calcola.pas',
  Model.Documento.Lista in 'Model.Documento.Lista.pas',
  UI.Documento in 'UI.Documento.pas' {DocumentoForm},
  UI.Interfaces in 'UI.Interfaces.pas',
  Model.Articoli.Lista in 'Model.Articoli.Lista.pas',
  UI.Articoli.Lista in 'UI.Articoli.Lista.pas' {ListaArticoliForm},
  Model.Documento.CalcolaIC in 'Model.Documento.CalcolaIC.pas',
  UI.Documento.Fattura in 'UI.Documento.Fattura.pas' {FatturaForm},
  UI.Documento.Preventivo in 'UI.Documento.Preventivo.pas' {PreventivoForm},
  Model.Documento.Preventivo in 'Model.Documento.Preventivo.pas',
  UI.Factory in 'UI.Factory.pas',
  Persistence.Factory in 'Persistence.Factory.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
