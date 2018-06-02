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
{$IFNDEF mgFMX}
  Persistence.dbx.Firebird,
{$ENDIF}
  Persistence.FireDAC.SQLite;

{ TPersistanceFactory }

class function TPersistanceFactory.GetConcreteFactory: IPersistanceLayerFactory;
begin
//  Result := TPersistanceDbxFirebirdFactory.GetInstance;
  Result := TPersistanceFireDacSQLiteFactory.GetInstance;
end;

end.
