unit Anon.Core.Utils;

interface

uses
  System.SysUtils, Anon.Interfaces;

type
  TLogger = class
  public
    class procedure Log(LogLevel: TLogLevel; const AMessage: string);
  end;

implementation

{ TLogger }

uses
  Demo.Core.Registry;

class procedure TLogger.Log(LogLevel: TLogLevel; const AMessage: string);
var
  Logger: ILogger;
begin
  if ClassRegistry.TryGetClass<ILogger>(Logger) then
    Logger.Log(LogLevel, AMessage);
end;

end.
