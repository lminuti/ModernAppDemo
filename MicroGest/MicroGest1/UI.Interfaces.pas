unit UI.Interfaces;

interface

uses
  Model.Interfaces;

type

  IUIDocumento = interface
    ['{2CC62E32-77A5-46F5-B057-A7E1AA84311E}']
    procedure SetDocumento(const ADocumento: IModelDocumento);
  end;

implementation

end.
