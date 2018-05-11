object FormGenericDialog: TFormGenericDialog
  Left = 0
  Top = 0
  Caption = 'FormGenericDialog'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PanelFooter: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 256
    Width = 629
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'PanelFooter'
    ShowCaption = False
    TabOrder = 0
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 40
      Align = alLeft
      Caption = 'Ok'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 40
      Align = alLeft
      Caption = 'Annulla'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
