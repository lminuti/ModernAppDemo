unit Model.Documento.CalcolaIC;

interface

uses
  Model.Interfaces, Data.DB;

type

  TCalcolatoreDocIC = class(TInterfacedObject, ICalcolatoreDoc)
  private
    FCalculating: Boolean;
  public
    constructor Create;
    procedure Calcola(const ADocDS, ARigheDS: TDataSet);
  end;

implementation

uses
  System.Math;

{ TCalcolatoreDocIC }

procedure TCalcolatoreDocIC.Calcola(const ADocDS, ARigheDS: TDataSet);
var
  LTotaleRighe: Currency;
  LBookmark: TBookmark;
begin
  // Check if calculating
  if FCalculating then
    Exit
  else
    FCalculating := True;

  LBookmark := ARigheDS.GetBookmark;
  ARigheDS.DisableControls;
  try
    LTotaleRighe := 0;
    ARigheDS.First;
    while not ARigheDS.Eof do
    begin
      LTotaleRighe := LTotaleRighe + ARigheDS.FieldByName('IMPORTO').AsCurrency;
      ARigheDS.Next;
    end;
    if not (ADocDS.State in [dsInsert, dsEdit]) then
      ADocDS.Edit;
    ADocDS.FieldByName('TOTALEDOCUMENTO').AsCurrency := LTotaleRighe;
    ADocDS.FieldByName('TOTALEIVA').AsCurrency := SimpleRoundTo(LTotaleRighe * 22 / 122, -2);
    ADocDS.FieldByName('TOTALEIMPONIBILE').AsCurrency := ADocDS.FieldByName('TOTALEDOCUMENTO').AsCurrency - ADocDS.FieldByName('TOTALEIVA').AsCurrency;
  finally
    ARigheDS.GotoBookmark(LBookmark);
    ARigheDS.EnableControls;
    FCalculating := False;
  end;
end;

constructor TCalcolatoreDocIC.Create;
begin
  FCalculating := False;
end;

end.
