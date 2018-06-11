program MicroGestSBS;

uses
  Vcl.Forms,
  UI.Main in 'UI.Main.pas' {MainForm},
  Model.Interfaces in 'Model.Interfaces.pas',
  Persistence.Interfaces in 'Persistence.Interfaces.pas',
  Model.Documento.Righe in 'Model.Documento.Righe.pas',
  Model.Documento in 'Model.Documento.pas',
  Persistence.Factory in 'Persistence.Factory.pas',
  Model.Factory in 'Model.Factory.pas',
  Model.Documento.Calcola in 'Model.Documento.Calcola.pas',
  Model.Documento.Lista in 'Model.Documento.Lista.pas',
  UI.Documento in 'UI.Documento.pas' {DocumentoForm},
  UI.Interfaces in 'UI.Interfaces.pas',
  Model.Articoli.Lista in 'Model.Articoli.Lista.pas',
  UI.Articoli.Lista in 'UI.Articoli.Lista.pas' {ListaArticoliForm},
  UI.Factory in 'UI.Factory.pas',
  Persistence.FireDAC.SQLite in 'Persistence.FireDAC.SQLite.pas',
  UI.Factory.VCL in 'UI.Factory.VCL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
