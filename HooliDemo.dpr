program HooliDemo;

uses
  Vcl.Forms,
  Demo.Forms.GenericDialog in 'source\common\Demo.Forms.GenericDialog.pas' {FormGenericDialog},
  Demo.Forms.Main in 'source\common\Demo.Forms.Main.pas' {FormMain},
  Demo.Forms.Test in 'source\common\Demo.Forms.Test.pas' {FrameTest: TFrame},
  Demo.Modules.DBBuilder in 'source\common\Demo.Modules.DBBuilder.pas' {DatabaseBuilder: TDataModule},
  Demo.Forms.EmployeeList in 'source\hooli\Demo.Forms.EmployeeList.pas' {FrameEmployeeList: TFrame},
  Demo.Interfaces in 'source\common\Demo.Interfaces.pas',
  Demo.Formula.Test in 'source\hooli\Demo.Formula.Test.pas',
  Demo.Core.Rtti in 'source\common\Demo.Core.Rtti.pas',
  Demo.Modules.Main in 'source\common\Demo.Modules.Main.pas' {DataModuleMain: TDataModule},
  Demo.Core.ServiceLocator in 'source\common\Demo.Core.ServiceLocator.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
