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
  Demo.Core.ServiceLocator;

class procedure TLogger.Log(LogLevel: TLogLevel; const AMessage: string);
begin
  if not Assigned(FLogger) then
    FLogger := ServiceLocator.GetClass<ILogger>;

  FLogger.Log(LogLevel, AMessage);
end;

end.
