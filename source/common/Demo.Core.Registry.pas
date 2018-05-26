unit Demo.Core.Registry;

interface

uses
  System.Classes, System.SysUtils;

type
  ERegistryError = class(Exception);

  TClassInfo = record
    ClassType: TClass;
    AliasName: string;
  end;

  TClassInfoList = array of TClassInfo;

  TClassRegistry = class(TObject)
  private
    FRegistry: TClassInfoList;
//    function GetRegistry: TClassInfoList;
    function GetAlias(AClassType: TClass): string;
  public
    function GetClass<T>: T; overload;
    function GetClass<T>(const AClassOrAlias: string): T; overload;
    procedure RegisterClass(AClassType: TClass);
    procedure ForEach<T>(AProc: TProc<TClass>);
  end;

function ClassRegistry: TClassRegistry;

implementation

uses
  System.TypInfo, Demo.Core.Rtti;

var
  GlobalClassRegistry: TClassRegistry;

function ClassRegistry: TClassRegistry;
begin
  if not Assigned(GlobalClassRegistry) then
    GlobalClassRegistry := TClassRegistry.Create;
  Result := GlobalClassRegistry;
end;

{ TClassRegistry }

function TClassRegistry.GetClass<T>: T;
begin
  Result := GetClass<T>('');
end;

procedure TClassRegistry.ForEach<T>(AProc: TProc<TClass>);
var
  ClassInfo: TClassInfo;
  Frame: TObject;
begin
  for ClassInfo in FRegistry do
  begin
    if Supports(ClassInfo.ClassType, GetTypeData(TypeInfo(T))^.Guid) then
    begin
      AProc(ClassInfo.ClassType);
    end;
  end;
end;

function TClassRegistry.GetAlias(AClassType: TClass): string;
var
  AliasAttrib: AliasAttribute;
begin
  Result := '';
  AliasAttrib := TRttiUtils.FindAttribute<AliasAttribute>(AClassType);
  if Assigned(AliasAttrib) then
    Result := AliasAttrib.Alias;
end;

function TClassRegistry.GetClass<T>(const AClassOrAlias: string): T;
var
  ClassInfo: TClassInfo;
  Frame: TObject;
begin
  for ClassInfo in FRegistry do
  begin
    if (AClassOrAlias = '') or (ClassInfo.ClassType.ClassName = AClassOrAlias) or (ClassInfo.AliasName = AClassOrAlias) then
    begin
      if Supports(ClassInfo.ClassType, GetTypeData(TypeInfo(T))^.Guid) then
      begin
        if ClassInfo.ClassType.InheritsFrom(TComponent) then
          Frame := TComponentClass(ClassInfo.ClassType).Create(nil)
        else
          //Frame := ClassInfo.ClassType.Create;
          Frame := TRttiUtils.CreateInstance(ClassInfo.ClassType);
        Frame.GetInterface(GetTypeData(TypeInfo(T))^.Guid, Result);
        Exit;
      end;
    end;
  end;
  raise ERegistryError.CreateFmt('Classe [%s] non trovata (Alias: [%s])', [TRttiUtils.Context.GetType(TypeInfo(T)).Name, AClassOrAlias]);
end;

//function TClassRegistry.GetRegistry: TClassInfoList;
//begin
//  Result := FRegistry;
//end;

procedure TClassRegistry.RegisterClass(AClassType: TClass);
var
  ClassInfo: TClassInfo;
begin
  ClassInfo.ClassType := AClassType;
  ClassInfo.AliasName := GetAlias(AClassType);
  FRegistry := FRegistry + [ClassInfo];
end;

initialization
  GlobalClassRegistry := nil;

finalization
  GlobalClassRegistry.Free;

end.
