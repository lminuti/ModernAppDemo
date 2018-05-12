object FrameTest: TFrameTest
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object Label1: TLabel
    Left = 24
    Top = 136
    Width = 66
    Height = 13
    Caption = 'Employee No.'
  end
  object ButtonSeachEmpNo: TButton
    Left = 218
    Top = 131
    Width = 34
    Height = 25
    Caption = '...'
    TabOrder = 0
    OnClick = ButtonSeachEmpNoClick
  end
  object Button2: TButton
    Left = 96
    Top = 79
    Width = 156
    Height = 25
    Caption = 'ShowDialog with Alias'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 96
    Top = 48
    Width = 156
    Height = 25
    Caption = 'ShowDialog by Interface'
    TabOrder = 2
    OnClick = Button3Click
  end
  object EditEmpNo: TEdit
    Left = 96
    Top = 133
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object Panel2: TPanel
    Left = 0
    Top = 211
    Width = 320
    Height = 29
    Align = alBottom
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 4
    ExplicitLeft = -505
    ExplicitWidth = 825
    object Button1: TButton
      AlignWithMargins = True
      Left = 114
      Top = 4
      Width = 75
      Height = 21
      Align = alLeft
      Caption = 'Calculate'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 49
      Height = 21
      Align = alLeft
      NumbersOnly = True
      TabOrder = 1
      Text = '12'
    end
    object Edit2: TEdit
      AlignWithMargins = True
      Left = 59
      Top = 4
      Width = 49
      Height = 21
      Align = alLeft
      NumbersOnly = True
      TabOrder = 2
      Text = '21'
    end
    object Edit3: TEdit
      AlignWithMargins = True
      Left = 195
      Top = 4
      Width = 121
      Height = 21
      Align = alLeft
      ReadOnly = True
      TabOrder = 3
      Text = '?'
    end
  end
end
