inherited PreventivoForm: TPreventivoForm
  Caption = 'PreventivoForm'
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [9]
    Left = 256
    Top = 648
    Width = 74
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Validit'#224' GG'
  end
  object DBEditValidita: TDBEdit [18]
    Left = 336
    Top = 645
    Width = 73
    Height = 21
    DataField = 'VALIDITA_GG'
    DataSource = DSDocumento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
end
