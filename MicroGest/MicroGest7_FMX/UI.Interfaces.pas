unit UI.Interfaces;

interface

uses
  Model.Interfaces;

type

  IUIDocumento = interface
    ['{2CC62E32-77A5-46F5-B057-A7E1AA84311E}']
    procedure SetDocumento(const ADocumento: IModelDocumento);
  end;

  IUILayerFactory = interface
    ['{FA9F43B4-5F8A-45F8-BD84-966990E231BA}']
    function GetUIDocumento(const ATipo: String; const AID: Integer = 0): IUIDocumento;
    procedure GetUIListaArticoli(const ASelectionMethod: TSelectionMethod);
  end;

implementation

end.
