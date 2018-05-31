program Anonymizer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  WinApi.Windows,
  System.SysUtils,
  Anon.Core.Console in 'source\anon\Anon.Core.Console.pas',
  Anon.Interfaces in 'source\anon\Anon.Interfaces.pas',
  Anon.Core.Anonimizer in 'source\anon\Anon.Core.Anonimizer.pas',
  Anon.Generators in 'source\anon\Anon.Generators.pas',
  Anon.Generators.FirstName in 'source\anon\Anon.Generators.FirstName.pas',
  Anon.Generators.LastName in 'source\anon\Anon.Generators.LastName.pas',
  Anon.Generators.Date in 'source\anon\Anon.Generators.Date.pas',
  Anon.Generators.RandomString in 'source\anon\Anon.Generators.RandomString.pas',
  Anon.Generators.CompanyName in 'source\anon\Anon.Generators.CompanyName.pas',
  Anon.Core.Utils in 'source\anon\Anon.Core.Utils.pas',
  Anon.Connection.FireDAC in 'source\anon\Anon.Connection.FireDAC.pas',
  Demo.Core.Rtti in '..\Dynamo\Demo.Core.Rtti.pas',
  Demo.Core.ServiceLocator in '..\Dynamo\Demo.Core.ServiceLocator.pas';

begin
  // Sarebbe meglio gestire le eccezioni...
  ReportMemoryLeaksOnShutdown := True;
  with ServiceLocator.GetClass<IUserInterface> do
    Run;
end.
