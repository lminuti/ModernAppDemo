unit Anon.Core.Console;

interface

uses
  System.SysUtils, WinApi.Windows, Anon.Interfaces;

type
  EConsoleError = class(Exception);

  TConsole = class(TInterfacedObject, IUserInterface, ILogger)
  private
    procedure Pause;
    procedure ShowVersion;
    procedure ShowHelp;
    procedure Default;
    procedure Anonymize(const Params: TParameters);
  public
    procedure Run;
    procedure Log(LogLevel: TLogLevel; const AMessage: string);
  end;

implementation

uses
  Demo.Core.ServiceLocator;

const
  ExeName = 'ANONYMIZER';

{ TConsole }

procedure TConsole.Anonymize(const Params: TParameters);
var
  Anonimizer: IAnonimizer;
begin
  if Params.FileName = '' then
    raise EConsoleError.Create('Nome file obbligatorio');
  if not FileExists(Params.FileName) then
    raise EConsoleError.CreateFmt('File [%s] non trovato', [Params.FileName]);

  Anonimizer := ServiceLocator.GetClass<IAnonimizer>;
  Anonimizer.Anonimize(Params);
end;

procedure TConsole.Default;
begin
  ShowHelp;
end;

procedure TConsole.Log(LogLevel: TLogLevel; const AMessage: string);

  function GetConsoleColor(hConsoleOutput: THandle; out AColor: Word): Boolean;
  var
    ConsoleInfo: CONSOLE_SCREEN_BUFFER_INFO;
  begin
    GetConsoleScreenBufferInfo(hConsoleOutput, ConsoleInfo);
    AColor := ConsoleInfo.wAttributes;
    Result := True;
  end;

var
  DefaultColor: Word;
  nStdHandle: DWORD;
const
  Colors: array [TLogLevel] of Word = (
    FOREGROUND_INTENSITY or FOREGROUND_RED,                      // Error
    FOREGROUND_INTENSITY or FOREGROUND_RED or FOREGROUND_GREEN,  // Warning
    FOREGROUND_INTENSITY or FOREGROUND_GREEN,                    // Info
    FOREGROUND_RED or FOREGROUND_GREEN or FOREGROUND_BLUE        // Debug
  );
begin
  if LogLevel = lError then
    nStdHandle := STD_ERROR_HANDLE
  else
    nStdHandle := STD_OUTPUT_HANDLE;

  GetConsoleColor(GetStdHandle(nStdHandle), DefaultColor);
  SetConsoleTextAttribute(GetStdHandle(nStdHandle), Colors[LogLevel]);
  Writeln(AMessage);
  SetConsoleTextAttribute(GetStdHandle(nStdHandle), DefaultColor);
end;

procedure TConsole.Pause;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  {$IFDEF MSWINDOWS}
  if DebugHook > 0 then
  begin
    Writeln('Press any key....');
    Readln;
  end;
  {$ENDIF}
  {$WARN SYMBOL_PLATFORM ON}
end;

procedure TConsole.Run;
var
  Params: TParameters;
begin
  try
    FindCmdLineSwitch('p', Params.Password);

    if FindCmdLineSwitch('v') then
      ShowVersion
    else if FindCmdLineSwitch('h') then
      ShowHelp
    else if FindCmdLineSwitch('f', Params.FileName) then
      Anonymize(Params)
    else
      Default;
  except
    on E: Exception do
    begin
      if not (E is EAbort) then
        Log(lError, E.ClassName + ': ' + E.Message);
    end;
  end;
  Pause;
end;

procedure TConsole.ShowHelp;
begin
  Writeln('Anonimizza una base dati');
  Writeln('');
  Writeln(ExeName + '[/H] [/V] [/A ][/P password] [/F nomefile]');
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

initialization
  ServiceLocator.RegisterClass(TConsole);

end.
