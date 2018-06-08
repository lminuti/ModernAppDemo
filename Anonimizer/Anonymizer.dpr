program Anonymizer;

{$APPTYPE CONSOLE}

{$R *.res}
{$R 'Anon.Resource.res' 'Anon.Resource.rc'}

uses
  WinApi.Windows,
  System.SysUtils,
  Demo.Core.Rtti in '..\Dynamo\Demo.Core.Rtti.pas',
  Demo.Core.ServiceLocator in '..\Dynamo\Demo.Core.ServiceLocator.pas',
  Anon.Connection.FireDAC in 'Anon.Connection.FireDAC.pas',
  Anon.Core.Anonimizer in 'Anon.Core.Anonimizer.pas',
  Anon.Core.Console in 'Anon.Core.Console.pas',
  Anon.Core.Utils in 'Anon.Core.Utils.pas',
  Anon.Generators.CompanyName in 'Anon.Generators.CompanyName.pas',
  Anon.Generators.Date in 'Anon.Generators.Date.pas',
  Anon.Generators.FirstName in 'Anon.Generators.FirstName.pas',
  Anon.Generators.LastName in 'Anon.Generators.LastName.pas',
  Anon.Generators in 'Anon.Generators.pas',
  Anon.Generators.RandomString in 'Anon.Generators.RandomString.pas',
  Anon.Interfaces in 'Anon.Interfaces.pas';

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    with ServiceLocator.GetClass<IUserInterface> do
      Run;
  except
     on E: Exception do
       ShowException(E, ExceptAddr);
  end;
end.
