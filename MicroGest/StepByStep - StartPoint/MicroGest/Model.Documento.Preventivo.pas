unit Model.Documento.Preventivo;

interface

uses
  Model.Documento;

type

  TModelPreventivo = class(TModelDocumento)
  protected
    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TModelPreventivo }

procedure TModelPreventivo.Validate;
begin
  inherited;
  if GetDataSet.FieldByName('VALIDITA_GG').AsInteger < 30 then
     raise Exception.Create('La validità del preventivo non può essere inferiore a 30 GG.');
end;

end.
