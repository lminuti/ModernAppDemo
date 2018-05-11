object FrameEmployeeList: TFrameEmployeeList
  Left = 0
  Top = 0
  Width = 411
  Height = 349
  TabOrder = 0
  object StringGrid1: TStringGrid
    Left = 40
    Top = 72
    Width = 320
    Height = 120
    TabOrder = 0
  end
  object Button1: TButton
    Left = 128
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Calculate'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 80
    Top = 232
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 2
    Text = '12'
  end
  object Edit2: TEdit
    Left = 240
    Top = 232
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    Text = '21'
  end
  object Edit3: TEdit
    Left = 239
    Top = 266
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 4
    Text = '?'
  end
end
