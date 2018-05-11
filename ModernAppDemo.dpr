program ModernAppDemo;

uses
  Vcl.Forms,
  Demo.Core.Registry in 'source\Demo.Core.Registry.pas',
  Demo.Forms.GenericDialog in 'source\Demo.Forms.GenericDialog.pas' {FormGenericDialog},
  Demo.Forms.Main in 'source\Demo.Forms.Main.pas' {FormMain},
  Demo.Forms.Test in 'source\Demo.Forms.Test.pas' {FrameTest: TFrame},
  Demo.Modules.DBBuilder in 'source\Demo.Modules.DBBuilder.pas' {DatabaseBuilder: TDataModule},
  Demo.Forms.EmployeeList in 'source\Demo.Forms.EmployeeList.pas' {FrameEmployeeList: TFrame},
  Demo.Interfaces in 'source\Demo.Interfaces.pas',
  Demo.Formula.Test in 'source\Demo.Formula.Test.pas',
  Demo.Core.Rtti in 'source\Demo.Core.Rtti.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
