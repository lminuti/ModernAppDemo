unit Demo.Core.ServiceLocator;

interface

uses
  System.Classes, System.SysUtils;

type
  ERegistryError = class(Exception);

  TClassInfo = record
    ClassType: TClass;
    AliasName: string;
    CtorProc: TFunc<TObject>;
  end;

  TClassEnumerator = class;

  TClassInfoList = array of TClassInfo;

  TServiceLocator = class(TObject)
  private
    FRegistry: TClassInfoList;
    function GetAlias(AClassType: TClass): string;
  public
    function GetClass<T>: T; overload;
    function GetClass<T>(const AClassOrAlias: string): T; overload;
    function GetEnumerator: TClassEnumerator;
    function TryGetClass<T>(out AValue: T): Boolean; overload;
    function TryGetClass<T>(const AClassOrAlias: string; out AValue: T): Boolean; overload;
    procedure RegisterClass(AClassType: TClass; ACtorProc: TFunc<TObject> = nil);
  end;

  TClassEnumerator = class
  private
    FIndex: integer;
    FClassRegistry: TServiceLocator;
    function GetCurrent: TClass;
  public
    constructor Create(AClassRegistry: TServiceLocator);
    function MoveNext: Boolean;
    property Current: TClass read GetCurrent;
  end;

function ServiceLocator: TServiceLocator;

implementation

uses
  System.TypInfo, Demo.Core.Rtti;

var
  GlobalServiceLocator: TServiceLocator;

function ServiceLocator: TServiceLocator;
begin
  if not Assigned(GlobalServiceLocator) then
    GlobalServiceLocator := TServiceLocator.Create;
  Result := GlobalServiceLocator;
end;

{ TServiceLocator }

function TServiceLocator.GetClass<T>: T;
begin
  Result := GetClass<T>('');
end;

function TServiceLocator.GetAlias(AClassType: TClass): string;
var
  AliasAttrib: AliasAttribute;
begin
  Result := '';
  AliasAttrib := TRttiUtils.FindAttribute<AliasAttribute>(AClassType);
  if Assigned(AliasAttrib) then
    Result := AliasAttrib.Alias;
end;

function TServiceLocator.GetClass<T>(const AClassOrAlias: string): T;
begin
  if not TryGetClass<T>(AClassOrAlias, Result) then
    raise ERegistryError.CreateFmt('Classe [%s] non trovata (Alias: [%s])', [TRttiUtils.Context.GetType(TypeInfo(T)).Name, AClassOrAlias]);
end;

function TServiceLocator.GetEnumerator: TClassEnumerator;
begin
  Result := TClassEnumerator.Create(Self);
end;

procedure TServiceLocator.RegisterClass(AClassType: TClass; ACtorProc: TFunc<TObject>);
var
  ClassInfo: TClassInfo;
begin
  ClassInfo.ClassType := AClassType;
  ClassInfo.AliasName := GetAlias(AClassType);
  ClassInfo.CtorProc := ACtorProc;
  FRegistry := FRegistry + [ClassInfo];
end;

function TServiceLocator.TryGetClass<T>(const AClassOrAlias: string;
  out AValue: T): Boolean;
var
  ClassInfo: TClassInfo;
  NewObject: TObject;
begin
  Result := False;
  for ClassInfo in FRegistry do
  begin
    if (AClassOrAlias = '') or (ClassInfo.ClassType.ClassName = AClassOrAlias) or (ClassInfo.AliasName = AClassOrAlias) then
    begin
      if Supports(ClassInfo.ClassType, GetTypeData(TypeInfo(T))^.Guid) then
      begin
        if Assigned(ClassInfo.CtorProc) then
          NewObject := ClassInfo.CtorProc()
        else if ClassInfo.ClassType.InheritsFrom(TComponent) then
          NewObject := TComponentClass(ClassInfo.ClassType).Create(nil)
        else
          //NewObject := ClassInfo.ClassType.Create;
          NewObject := TRttiUtils.CreateInstance(ClassInfo.ClassType);
        NewObject.GetInterface(GetTypeData(TypeInfo(T))^.Guid, AValue);
        Exit(True);
      end;
    end;
  end;
end;

function TServiceLocator.TryGetClass<T>(out AValue: T): Boolean;
begin
  Result := TryGetClass<T>('', AValue);
end;

{ TClassEnumerator }

constructor TClassEnumerator.Create(AClassRegistry: TServiceLocator);
begin
  inherited Create;
  FClassRegistry := AClassRegistry;
  FIndex := -1;
end;

function TClassEnumerator.GetCurrent: TClass;
begin
  Result := FClassRegistry.FRegistry[FIndex].ClassType;
end;

function TClassEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < Length(FClassRegistry.FRegistry) - 1;
  if Result then
  begin
    Inc(FIndex);
  end;
end;

initialization
  GlobalServiceLocator := nil;

finalization
  GlobalServiceLocator.Free;

end.
