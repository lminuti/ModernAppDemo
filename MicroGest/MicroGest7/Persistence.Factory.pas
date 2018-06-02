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
  Persistence.FireDAC.SQLite, Persistence.dbx.Firebird;

{ TPersistanceFactory }

class function TPersistanceFactory.GetConcreteFactory: IPersistanceLayerFactory;
begin
  Result := TPersistanceDbxFirebirdFactory.GetInstance;
//  Result := TPersistanceFireDacSQLiteFactory.GetInstance;
end;

end.
