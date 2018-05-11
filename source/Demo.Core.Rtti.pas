unit Demo.Core.Rtti;

interface

uses
  System.Rtti;

type
  AliasAttribute = class(TCustomAttribute)
  private
    FAlias: string;
  public
    property Alias: string read FAlias write FAlias;
    constructor Create(const AAlias: string);
  end;

  FrameTitleAttribute = class(TCustomAttribute)
  private
    FTitle: string;
  public
    property Title: string read FTitle write FTitle;
    constructor Create(const ATitle: string);
  end;

  TRttiUtils = class
  private
    class var FContext: TRttiContext;
  public
    class function FindAttribute<T: TCustomAttribute>(AType: TRttiObject): T;  overload; static;
    class function FindAttribute<T: TCustomAttribute>(AType: TClass): T; overload; static;

    class property Context: TRttiContext read FContext;
  end;

implementation

{ AliasAttribute }

constructor AliasAttribute.Create(const AAlias: string);
begin
  inherited Create;
  FAlias := AAlias;
end;

{ FrameTitleAttribute }

constructor FrameTitleAttribute.Create(const ATitle: string);
begin
  inherited Create;
  FTitle := ATitle;
end;

{ TRttiUtils }

class function TRttiUtils.FindAttribute<T>(AType: TRttiObject): T;
var
  LAttribute: TCustomAttribute;
begin
  Result := nil;
  for LAttribute in AType.GetAttributes do
  begin
    if LAttribute.InheritsFrom(TClass(T)) then
    begin
      Result := LAttribute as T;

      Break;
    end;
  end;
end;

class function TRttiUtils.FindAttribute<T>(AType: TClass): T;
begin
  Result := FindAttribute<T>(FContext.GetType(AType));
end;

end.
