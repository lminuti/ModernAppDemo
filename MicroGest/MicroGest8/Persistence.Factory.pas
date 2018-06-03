unit Persistence.Factory;

interface

uses
  Persistence.Interfaces, Demo.Core.ServiceLocator;

type
  TPersistanceFactory = class
  public
    class function GetConcreteFactory: IPersistanceLayerFactory;
  end;

implementation

{ TPersistanceFactory }

class function TPersistanceFactory.GetConcreteFactory: IPersistanceLayerFactory;
begin
  Result := ServiceLocator.GetClass<IPersistanceLayerFactory>;
end;

end.
