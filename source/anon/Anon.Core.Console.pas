unit Anon.Core.Console;

interface

uses
  System.SysUtils;

type
  EConsoleError = class(Exception);

  TConsole = class(TObject)
  public
    class procedure Run;
  public
    procedure ShowVersion;
    procedure ShowHelp;
    procedure Default;
    procedure Anonymize(const FileName, Password: string);
  end;

implementation

uses Anon.Interfaces, Demo.Core.Registry;

const
  ExeName = 'ANONYMIZER';

{ TConsole }

procedure TConsole.Anonymize(const FileName, Password: string);
var
  Anonimizer: IAnonimizer;
begin
  if FileName = '' then
    raise EConsoleError.Create('Nome file obbligatorio');
  if not FileExists(FileName) then
    raise EConsoleError.CreateFmt('File [%s] non trovato', [FileName]);

  Anonimizer := ClassRegistry.GetClass<IAnonimizer>;
  Anonimizer.Password := Password;
  Anonimizer.Anonimize(FileName);
end;

procedure TConsole.Default;
begin
  ShowHelp;
end;

class procedure TConsole.Run;
var
  Console: TConsole;
  FileName: string;
  Password: string;
begin
  Console := TConsole.Create;
  try
    FindCmdLineSwitch('p', Password);

    if FindCmdLineSwitch('v') then
      Console.ShowVersion
    else if FindCmdLineSwitch('h') then
      Console.ShowHelp
    else if FindCmdLineSwitch('f', FileName) then
      Console.Anonymize(FileName, Password)
    else
      Console.Default;
  finally
    Console.Free;
  end;
end;

procedure TConsole.ShowHelp;
begin
  Writeln('Anonimizza una base dati');
  Writeln('');
  Writeln(ExeName + '[/H] [/V] [/P password] [/F nomefile]');
  Writeln('');
  Writeln('/V        Mostra Versione');
  Writeln('/H        Questo help');
  Writeln('/F        Configurazione del file');
  Writeln('nomefile  Il file di configurazione');
  Writeln('/P        Password');
  Writeln('password  La passoword del database');
end;

procedure TConsole.ShowVersion;
begin
  Writeln(ExeName + ' V1.0');
end;

end.
