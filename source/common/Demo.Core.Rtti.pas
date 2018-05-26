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
    class procedure InitializeRtti; static;
  public
    class function FindAttribute<T: TCustomAttribute>(AType: TRttiObject): T;  overload; static;
    class function FindAttribute<T: TCustomAttribute>(AType: TClass): T; overload; static;
    class function HasAttribute<T: TCustomAttribute>(AType: TRttiObject): Boolean;  overload; static;
    class function HasAttribute<T: TCustomAttribute>(AType: TClass): Boolean; overload; static;

    class function CreateInstance(AType: TRttiType): TObject; overload; static;
    class function CreateInstance(AClass: TClass): TObject; overload; static;

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

class function TRttiUtils.HasAttribute<T>(AType: TClass): Boolean;
begin
  Result := HasAttribute<T>(FContext.GetType(AType));
end;

class function TRttiUtils.HasAttribute<T>(AType: TRttiObject): Boolean;
var
  LAttribute: TCustomAttribute;
begin
  Result := False;
  for LAttribute in AType.GetAttributes do
  begin
    if LAttribute.InheritsFrom(TClass(T)) then
    begin
      Exit(True);
    end;
  end;
end;

class function TRttiUtils.CreateInstance(AType: TRttiType): TObject;
var
  LMethod: TRttiMethod;
  LMetaClass: TClass;
begin
  Result := nil;
  if Assigned(AType) then
  begin
    for LMethod in AType.GetMethods do
    begin
      if LMethod.HasExtendedInfo and LMethod.IsConstructor then
      begin
        if Length(LMethod.GetParameters) = 0 then
        begin
          LMetaClass := AType.AsInstance.MetaclassType;
          Exit(LMethod.Invoke(LMetaClass, []).AsObject);
        end;
      end;
    end;
  end;
end;

class function TRttiUtils.CreateInstance(AClass: TClass): TObject;
var
  LType: TRttiType;
begin
  LType := FContext.GetType(AClass);
  Result := CreateInstance(LType);
end;


class procedure TRttiUtils.InitializeRtti;
begin
  FContext := TRttiContext.Create;
end;

initialization

TRttiUtils.InitializeRtti;

end.
