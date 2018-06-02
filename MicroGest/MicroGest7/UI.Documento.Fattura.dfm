inherited FatturaForm: TFatturaForm
  Caption = 'FatturaForm'
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel [9]
    Left = 240
    Top = 648
    Width = 74
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Pagamento'
  end
  object DBEditPagamento: TDBEdit [18]
    Left = 320
    Top = 645
    Width = 313
    Height = 21
    DataField = 'PAGAMENTO'
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
