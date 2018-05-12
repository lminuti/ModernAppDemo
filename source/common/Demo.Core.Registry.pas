unit Demo.Core.Registry;

interface

uses
  System.Classes, System.SysUtils;

type
  TClassInfo = record
    ClassType: TClass;
    AliasName: string;
  end;

  TClassInfoList = array of TClassInfo;

  TClassRegistry = class(TObject)
  // class variables and methods
  private
    class var FInstance: TClassRegistry;
    class function GetInstance: TClassRegistry; static; inline;
  public
    class property Instance: TClassRegistry read GetInstance;
    class destructor Destroy;
  // instace variables and methods
  private
    FRegistry: TClassInfoList;
    function GetRegistry: TClassInfoList;
    function GetAlias(AClassType: TClass): string;
  public
    function GetClass<T>: T; overload;
    function GetClass<T>(const AClassOrAlias: string): T; overload;
    property Registry: TClassInfoList read GetRegistry;
    procedure RegisterClass(AClassType: TClass);
  end;

implementation

uses
  System.TypInfo, Demo.Core.Rtti;

{ TClassRegistry }

class destructor TClassRegistry.Destroy;
begin
  FInstance.Free;
end;

function TClassRegistry.GetClass<T>: T;
begin
  Result := GetClass<T>('');
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
          Frame := ClassInfo.ClassType.Create;
        Frame.GetInterface(GetTypeData(TypeInfo(T))^.Guid, Result);
        Exit;
      end;
    end;
  end;
  raise Exception.Create('Frame non trovato');
end;

class function TClassRegistry.GetInstance: TClassRegistry;
begin
  if not Assigned(FInstance) then
    FInstance := TClassRegistry.Create;
  Result := FInstance;
end;

function TClassRegistry.GetRegistry: TClassInfoList;
begin
  Result := FRegistry;
end;

procedure TClassRegistry.RegisterClass(AClassType: TClass);
var
  ClassInfo: TClassInfo;
begin
  ClassInfo.ClassType := AClassType;
  ClassInfo.AliasName := GetAlias(AClassType);
  FRegistry := FRegistry + [ClassInfo];
end;

end.
