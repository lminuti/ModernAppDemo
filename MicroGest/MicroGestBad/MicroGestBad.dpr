program MicroGestBad;

uses
  Vcl.Forms,
  F.Main in 'F.Main.pas' {MainForm},
  Form.Documento in 'Form.Documento.pas' {DocumentoForm},
  F.Articoli.Lista in 'F.Articoli.Lista.pas' {ListaArticoliForm},
  DM.Main in 'DM.Main.pas' {MainDM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainDM, MainDM);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
