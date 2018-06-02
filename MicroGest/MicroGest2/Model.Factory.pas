unit Model.Factory;

interface

uses
  Model.Interfaces, System.SysUtils, System.Classes;

type

  TModelFactory = class
  public
    class function GetModelListaDocumenti: IModelListaDocumenti;
    class function GetModelDocumento(const ATipo: String; const ADocID: Integer = 0): IModelDocumento;
    class function GetModelRigheDocumento(const ADocID: Integer; const ACalcMethod:TProc): IModelRigheDocumento;
    class function GetCalcolatoreDoc(const ATipo: String): ICalcolatoreDoc;
    class function GetModelListaArticoli(const ASelectionMethod: TSelectionMethod): IModelListaArticoli;
    class function GetListaTipiDocumenti: TStrings;
  end;

implementation

uses
  Model.Documento.Righe, Model.Documento, Model.Documento.Calcola,
  Model.Documento.Lista, Model.Articoli.Lista, Model.Documento.CalcolaIC;

{ TModelFactory }

class function TModelFactory.GetCalcolatoreDoc(const ATipo: String): ICalcolatoreDoc;
begin
  if ATipo.EndsWith('I.C.') then
    Result := TCalcolatoreDocIC.Create
  else
    Result := TCalcolatoreDoc.Create;
end;

class function TModelFactory.GetModelDocumento(const ATipo: String; const ADocID: Integer): IModelDocumento;
begin
  Result := TModelDocumento.Create(ATipo, ADocID);
end;

class function TModelFactory.GetModelListaArticoli(const ASelectionMethod: TSelectionMethod): IModelListaArticoli;
begin
  Result := TModelListaArticoli.Create(ASelectionMethod);
end;

class function TModelFactory.GetModelListaDocumenti: IModelListaDocumenti;
begin
  Result := TModelListaDocumenti.Create;
end;

class function TModelFactory.GetModelRigheDocumento(const ADocID: Integer; const ACalcMethod:TProc): IModelRigheDocumento;
begin
  Result := TModelRigheDocumento.Create(ADocID, ACalcMethod);
end;

class function TModelFactory.GetListaTipiDocumenti: TStrings;
begin
  Result := TStringList.Create;
  Result.Add('Preventivo');
  Result.Add('Preventivo I.C.');
end;

end.
