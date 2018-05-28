unit Anon.Core.Utils;

interface

uses
  System.SysUtils, Anon.Interfaces;

type
  TLogger = class
  private
    class var FLogger: ILogger;
  public
    class procedure Log(LogLevel: TLogLevel; const AMessage: string);
  end;

implementation

{ TLogger }

uses
  Demo.Core.Registry;

class procedure TLogger.Log(LogLevel: TLogLevel; const AMessage: string);
begin
  if not Assigned(FLogger) then
    FLogger := ClassRegistry.GetClass<ILogger>;

  FLogger.Log(LogLevel, AMessage);
end;

end.
