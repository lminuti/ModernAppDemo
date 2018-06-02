program MicroGest5;

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
  UI.Factory in 'UI.Factory.pas',
  UI.Interfaces in 'UI.Interfaces.pas',
  Model.Articoli.Lista in 'Model.Articoli.Lista.pas',
  UI.Articoli.Lista in 'UI.Articoli.Lista.pas' {ListaArticoliForm},
  Persistence.dbx.Firebird in 'Persistence.dbx.Firebird.pas' {PersistanceDbxFirebirdFactory: TDataModule},
  Model.Documento.CalcolaIC in 'Model.Documento.CalcolaIC.pas',
  UI.Documento.Preventivo in 'UI.Documento.Preventivo.pas' {PreventivoForm},
  UI.Documento.Fattura in 'UI.Documento.Fattura.pas' {FatturaForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
