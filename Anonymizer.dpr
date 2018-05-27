program Anonymizer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  WinApi.Windows,
  System.SysUtils,
  Anon.Core.Console in 'source\anon\Anon.Core.Console.pas',
  Demo.Core.Registry in 'source\common\Demo.Core.Registry.pas',
  Demo.Core.Rtti in 'source\common\Demo.Core.Rtti.pas',
  Anon.Interfaces in 'source\anon\Anon.Interfaces.pas',
  Anon.Core.Anonimizer in 'source\anon\Anon.Core.Anonimizer.pas',
  Anon.Connection.Firebird in 'source\anon\Anon.Connection.Firebird.pas',
  Anon.Generators in 'source\anon\Anon.Generators.pas',
  Anon.Generators.FirstName in 'source\anon\Anon.Generators.FirstName.pas',
  Anon.Generators.LastName in 'source\anon\Anon.Generators.LastName.pas',
  Anon.Generators.Date in 'source\anon\Anon.Generators.Date.pas',
  Anon.Generators.RandomString in 'source\anon\Anon.Generators.RandomString.pas',
  Anon.Generators.CompanyName in 'source\anon\Anon.Generators.CompanyName.pas',
  Anon.Core.Utils in 'source\anon\Anon.Core.Utils.pas';

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    TConsole.Run;
  except
    on E: Exception do
    begin
      SetConsoleTextAttribute(
        GetStdHandle(STD_OUTPUT_HANDLE),
        FOREGROUND_RED or FOREGROUND_INTENSITY);
      WriteLn(ErrOutput, E.ClassName, ': ', E.Message);
    end;
  end;
end.
