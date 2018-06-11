unit UI.Factory;

interface

uses
  UI.Interfaces;

type

  TUIFactory = class
  public
    class function GetConcreteFactory: IUILayerFactory;
  end;

implementation

uses
{$IFDEF mgFMX}
  UI.Factory.FMX;
{$ELSE}
  UI.Factory.VCL;
{$ENDIF}

{ TUIFactory }

class function TUIFactory.GetConcreteFactory: IUILayerFactory;
begin
{$IFDEF mgFMX}
  Result := TUIFactoryFMX.GetInstance;
{$ELSE}
  Result := TUIFactoryVCL.GetInstance;
{$ENDIF}
end;

end.
