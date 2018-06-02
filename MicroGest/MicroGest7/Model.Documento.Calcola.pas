unit Model.Documento.Calcola;

interface

uses
  Model.Interfaces, Data.DB;

type

  TCalcolatoreDoc = class(TInterfacedObject, ICalcolatoreDoc)
  private
    FCalculating: Boolean;
  public
    constructor Create;
    procedure Calcola(const ADocDS, ARigheDS: TDataSet);
  end;

implementation

{ TCalcolaDoc }

procedure TCalcolatoreDoc.Calcola(const ADocDS, ARigheDS: TDataSet);
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
    ADocDS.FieldByName('TOTALEIMPONIBILE').AsCurrency := LTotaleRighe;
    ADocDS.FieldByName('TOTALEIVA').AsCurrency := LTotaleRighe * 0.22;
    ADocDS.FieldByName('TOTALEDOCUMENTO').AsCurrency := LTotaleRighe * 1.22;
    ADocDS.Post;
  finally
    ARigheDS.GotoBookmark(LBookmark);
    ARigheDS.EnableControls;
    FCalculating := False;
  end;
end;

constructor TCalcolatoreDoc.Create;
begin
  FCalculating := False;
end;

end.
