unit Model.Interfaces;

interface

uses
  Data.DB;

type

  TSelectionMethod = reference to procedure(ACodice, ADescrizione: String; APrezzo: Currency);

  // Base interfaces

  IModelBase = interface
    ['{31A8FA70-BEE1-48EA-BC7C-5C5AD02ED651}']
    function GetDataSet: TDataSet;
  end;

  IModelListaBase = interface(IModelBase)
    ['{E7AEE40B-2CBB-4AF5-B9D9-B901BBBC6CCA}']
  end;

  // Model

  IModelDocumento = interface(IModelBase)
    ['{F8F9AD23-6755-4D42-BE23-DD8C401ADA91}']
    function GetDataSetRighe: TDataSet;
    function CanSave: Boolean;
    procedure Save;
    procedure Cancel;
    procedure AggiungiRiga;
    procedure EliminaRiga;
  end;

  IModelRigheDocumento = interface(IModelBase)
    ['{0263D996-F40C-4E5D-8725-425149356246}']
    procedure Append(const ADocID: Integer; const ACodice, ADescrizione: String; const AQta, APrezzo: Double);
    procedure Delete;
  end;

  ICalcolatoreDoc = interface
    ['{A3E5E2D1-9734-4318-86BD-7AE7AB15FADD}']
    procedure Calcola(const ADocDS, ARigheDS: TDataSet);
  end;

  // List

  IModelListaDocumenti = interface(IModelListaBase)
    ['{ADCC66E0-6F4D-4921-9F1C-8FBD1A991C5C}']
    procedure Refresh;
    procedure Append;
    procedure Delete;
    procedure Edit;
    function CanDelete: Boolean;
  end;

  IModelListaArticoli = interface(IModelListaBase)
    ['{9A098F8F-AB44-4EB8-85C6-51B60BAA97C6}']
    procedure Seleziona;
  end;

implementation

end.
