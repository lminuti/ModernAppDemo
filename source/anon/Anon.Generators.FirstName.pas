unit Anon.Generators.FirstName;

interface

uses
  SysUtils, Anon.Interfaces, Demo.Core.Registry, Demo.Core.Rtti;

type
  [Alias('FirstName')]
  TFirstNameGenerator = class(TInterfacedObject, IGenerator)
  public
    function GenerateValue: Variant;
    procedure SetParams(const Params: System.TArray<System.string>);
  end;

implementation

const
  FirstNames: array [0..58] of string = (
    'Sofia',
    'Giulia',
    'Aurora',
    'Giorgia',
    'Martina',
    'Emma',
    'Greta',
    'Chiara',
    'Sara',
    'Alice',
    'Gaia',
    'Anna',
    'Francesca',
    'Ginevra',
    'Noemi',
    'Alessia',
    'Matilde',
    'Vittoria',
    'Viola',
    'Beatrice',
    'Nicole',
    'Giada',
    'Elisa',
    'Rebecca',
    'Elena',
    'Arianna',
    'Mia',
    'Camilla',
    'Ludovica',
    'Maria',
    'Francesco',
    'Alessandro',
    'Lorenzo',
    'Andrea',
    'Leonardo',
    'Mattia',
    'Matteo',
    'Gabriele',
    'Riccardo',
    'Tommaso',
    'Davide',
    'Giuseppe',
    'Antonio',
    'Federico',
    'Edoardo',
    'Marco',
    'Samuele',
    'Diego',
    'Giovanni',
    'Luca',
    'Christian',
    'Pietro',
    'Simone',
    'Filippo',
    'Alessio',
    'Gabriel',
    'Michele',
    'Emanuele',
    'Jacopo'
);

{ TFirstNameGenerator }

function TFirstNameGenerator.GenerateValue: Variant;
var
  Index: Integer;
begin
  Index := Random(Length(FirstNames));
  Result := FirstNames[Index];
end;

procedure TFirstNameGenerator.SetParams(
  const Params: System.TArray<System.string>);
begin

end;

initialization
  ClassRegistry.RegisterClass(TFirstNameGenerator);

end.
