object DataModuleMain: TDataModuleMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 208
  Width = 278
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=Win32\Debug\Data.db'
      'DriverID=SQLite')
    ConnectedStoredUsage = []
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDQueryEmployee: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM EMPLOYEE')
    Left = 48
    Top = 88
  end
  object DataSourceEmployee: TDataSource
    DataSet = FDQueryEmployee
    Left = 152
    Top = 88
  end
end
