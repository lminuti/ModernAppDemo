unit Anon.Generators.LastName;

interface

uses
  SysUtils, Anon.Interfaces, Demo.Core.ServiceLocator, Demo.Core.Rtti;

type
  [Alias('LastName')]
  TLastNameGenerator = class(TInterfacedObject, IGenerator)
  public
    function GenerateValue: Variant;
    procedure SetParams(const Params: System.TArray<System.string>);
  end;

implementation

{$region 'Random data for last names'}

const
  LastNames: array [0..99] of string = (
    'Rossi',
    'Russo',
    'Ferrari',
    'Esposito',
    'Bianchi',
    'Romano',
    'Colombo',
    'Ricci',
    'Marino',
    'Greco',
    'Bruno',
    'Gallo',
    'Conti',
    'De Luca',
    'Mancini',
    'Costa',
    'Giordano',
    'Rizzo',
    'Lombardi',
    'Moretti',
    'Barbieri',
    'Fontana',
    'Santoro',
    'Mariani',
    'Rinaldi',
    'Caruso',
    'Ferrara',
    'Galli',
    'Martini',
    'Leone',
    'Longo',
    'Gentile',
    'Martinelli',
    'Vitale',
    'Lombardo',
    'Serra',
    'Coppola',
    'De Santis',
    'D''angelo',
    'Marchetti',
    'Parisi',
    'Villa',
    'Conte',
    'Ferraro',
    'Ferri',
    'Fabbri',
    'Bianco',
    'Marini',
    'Grasso',
    'Valentini',
    'Messina',
    'Sala',
    'De Angelis',
    'Gatti',
    'Pellegrini',
    'Palumbo',
    'Sanna',
    'Farina',
    'Rizzi',
    'Monti',
    'Cattaneo',
    'Morelli',
    'Amato',
    'Silvestri',
    'Mazza',
    'Testa',
    'Grassi',
    'Pellegrino',
    'Carbone',
    'Giuliani',
    'Benedetti',
    'Barone',
    'Rossetti',
    'Caputo',
    'Montanari',
    'Guerra',
    'Palmieri',
    'Bernardi',
    'Martino',
    'Fiore',
    'De Rosa',
    'Ferretti',
    'Bellini',
    'Basile',
    'Riva',
    'Donati',
    'Piras',
    'Vitali',
    'Battaglia',
    'Sartori',
    'Neri',
    'Costantini',
    'Milani',
    'Pagano',
    'Ruggiero',
    'Sorrentino',
    'D''amico',
    'Orlando',
    'Damico',
    'Negri'
  );

{$endregion}

{ TLastNameGenerator }

function TLastNameGenerator.GenerateValue: Variant;
var
  Index: Integer;
begin
  Index := Random(Length(LastNames));
  Result := LastNames[Index];
end;

procedure TLastNameGenerator.SetParams(
  const Params: System.TArray<System.string>);
begin

end;

initialization
  ServiceLocator.RegisterClass(TLastNameGenerator);

end.
