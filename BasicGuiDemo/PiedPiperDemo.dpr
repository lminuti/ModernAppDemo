program PiedPiperDemo;

uses
  Vcl.Forms,
  Demo.Forms.GenericDialog in 'common\Demo.Forms.GenericDialog.pas' {FormGenericDialog},
  Demo.Forms.Main in 'common\Demo.Forms.Main.pas' {FormMain},
  Demo.Forms.Test in 'common\Demo.Forms.Test.pas' {FrameTest: TFrame},
  Demo.Interfaces in 'common\Demo.Interfaces.pas',
  Demo.Modules.DBBuilder in 'common\Demo.Modules.DBBuilder.pas' {DatabaseBuilder: TDataModule},
  Demo.Modules.Main in 'common\Demo.Modules.Main.pas' {DataModuleMain: TDataModule},
  Demo.Forms.EmployeeList in 'piedpiper\Demo.Forms.EmployeeList.pas' {FrameEmployeeList: TFrame},
  Demo.Formula.Test in 'piedpiper\Demo.Formula.Test.pas',
  Demo.Core.Rtti in '..\Dynamo\Demo.Core.Rtti.pas',
  Demo.Core.ServiceLocator in '..\Dynamo\Demo.Core.ServiceLocator.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
