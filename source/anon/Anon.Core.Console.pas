unit Anon.Core.Console;

interface

uses
  System.SysUtils, WinApi.Windows, Anon.Interfaces;

type
  EConsoleError = class(Exception);

  TConsole = class(TInterfacedObject, ILogger)
  public
    class procedure Run;
  public
    procedure ShowVersion;
    procedure ShowHelp;
    procedure Default;
    procedure Anonymize(const FileName, Password: string);
    procedure Log(LogLevel: TLogLevel; const AMessage: string);

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Demo.Core.Registry;

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

constructor TConsole.Create;
begin
  inherited Create;
  // Sarebbe meglio deregistrarla sul destroy...
  ClassRegistry.RegisterClass(TConsole,
    function :TObject
    begin
      Result := Self;
    end
  );
end;

destructor TConsole.Destroy;
begin
  inherited;
end;

procedure TConsole.Default;
begin
  ShowHelp;
end;

procedure TConsole.Log(LogLevel: TLogLevel; const AMessage: string);
const
  Colors: array [TLogLevel] of Word = (
    FOREGROUND_INTENSITY or FOREGROUND_RED,    // Error
    FOREGROUND_INTENSITY or FOREGROUND_RED or FOREGROUND_GREEN,        // Warning
    FOREGROUND_INTENSITY or FOREGROUND_GREEN,  // Info
    FOREGROUND_RED or FOREGROUND_GREEN or FOREGROUND_BLUE  // Debug
  );
begin
  SetConsoleTextAttribute(
    GetStdHandle(STD_OUTPUT_HANDLE),
      Colors[LogLevel] or 0);
  Writeln(AMessage);
end;

class procedure TConsole.Run;
var
  Console: TConsole;
  FileName: string;
  Password: string;
begin
  Console := TConsole.Create;
  try
    // Questo serve perché uso interfacce e classi (shame on me!)
    Console._AddRef;

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
    Console._Release;
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
