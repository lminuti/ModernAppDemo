unit Anon.Interfaces;

interface

uses
  System.SysUtils, Data.DB;

type
  TDatabaseConfig = record
    ConnectionString: string;
    UserName: string;
    Password: string;
  end;

  IAnonimizer = interface
  ['{F4535069-590C-40FC-96C0-9F97504EB118}']
    procedure Anonimize(const FileName: string);
    procedure SetPassword(const Value: string);
    function GetPassword: string;

    property Password: string read GetPassword write SetPassword;
  end;

  IConnection = interface
  ['{FACCB00F-98BE-436F-9F25-C969DAE9EB4F}']
    procedure Connect(DatabaseConfig: TDatabaseConfig);
    procedure FetchTable(const TableName: string; AProc: TProc<TDataSet>);
  end;

  IGenerator = interface
  ['{A6F43EAC-2023-4453-87B3-2F4EB8DE34C3}']
    procedure SetParams(const Params: TArray<string>);
    function GenerateValue: Variant;
  end;

  TLogLevel = (lError, lWarning, lInfo, lDebug);

  ILogger = interface
  ['{118A7D52-FFC4-4F11-8215-458A0F4C8CE3}']
    procedure Log(LogLevel: TLogLevel; const AMessage: string);
  end;

implementation

end.
