unit Persistence.Interfaces;

interface

uses
  Data.DB;

type

  IPersistanceLayerFactory = interface
    ['{6538DE57-B76E-4CA9-89F1-55217C428C61}']
    function GetListaDocumentiDS: TDataSet;
    function GetListaArticoliDS: TDataSet;

    function GetDocumentoDS(const ATipoDoc: String; const AID:Integer=0): TDataSet;
    function GetRigheDocumentoDS(const AID:Integer=0): TDataSet;

    procedure ApplyUpdates(const ADataSet:TDataSet);
    procedure CancelUpdates(const ADataSet:TDataSet);
    procedure CommitUpdates(const ADataSet:TDataSet);
    function CanSave(const ADataSet:TDataSet): Boolean;

    procedure StartTransaction;
    procedure CommitTransaction;
    procedure RollbackTransaction;
  end;

implementation

end.
