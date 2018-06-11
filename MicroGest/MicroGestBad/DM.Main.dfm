object MainDM: TMainDM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  Height = 252
  Width = 335
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=MicroGestSQLite')
    LoginPrompt = False
    Left = 107
    Top = 50
  end
end
