unit Persistence.Factory;

interface

uses
  Persistence.Interfaces;

type

  TPersistanceFactory = class
  public
    class function GetConcreteFactory: IPersistanceLayerFactory;
  end;

implementation

uses
  Persistence.FireDAC.SQLite;

{ TPersistanceFactory }

class function TPersistanceFactory.GetConcreteFactory: IPersistanceLayerFactory;
begin
  Result := TPersistanceFireDacSQLiteFactory.GetInstance;
end;

end.
