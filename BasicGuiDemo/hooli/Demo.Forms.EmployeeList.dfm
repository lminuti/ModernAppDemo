object FrameEmployeeList: TFrameEmployeeList
  Left = 0
  Top = 0
  Width = 825
  Height = 349
  TabOrder = 0
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 825
    Height = 308
    Align = alClient
    DataSource = DataModuleMain.DataSourceEmployee
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'EMP_NO'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FIRST_NAME'
        Width = 105
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LAST_NAME'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PHONE_EXT'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HIRE_DATE'
        Width = 104
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DEPT_NO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JOB_CODE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JOB_GRADE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JOB_COUNTRY'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SALARY'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 825
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitLeft = 80
    ExplicitTop = 40
    ExplicitWidth = 185
  end
end
