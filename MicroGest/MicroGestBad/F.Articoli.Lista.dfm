object ListaArticoliForm: TListaArticoliForm
  Left = 0
  Top = 0
  Caption = 'Selezione articolo'
  ClientHeight = 662
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 579
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 16113336
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      579
      41)
    object ButtonAnnulla: TSpeedButton
      Left = 6
      Top = 4
      Width = 81
      Height = 32
      Action = acIndietro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ButtonSeleziona: TSpeedButton
      Left = 456
      Top = 4
      Width = 116
      Height = 32
      Action = acSeleziona
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 128
      Top = 9
      Width = 297
      Height = 22
      Alignment = taCenter
      AutoSize = False
      Caption = 'Selezione articolo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 579
    Height = 621
    Align = alClient
    DataSource = DSListaArticoli
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object DSListaArticoli: TDataSource
    DataSet = QryListaArticoli
    Left = 120
    Top = 248
  end
  object ActionList1: TActionList
    Left = 120
    Top = 112
    object acIndietro: TAction
      Caption = 'Indietro'
      OnExecute = acIndietroExecute
    end
    object acSeleziona: TAction
      Caption = 'Seleziona'
      OnExecute = acSelezionaExecute
    end
  end
  object QryListaArticoli: TFDQuery
    CachedUpdates = True
    Connection = MainDM.FDConnection1
    SQL.Strings = (
      'SELECT * FROM ARTICOLI')
    Left = 120
    Top = 191
    object QryListaArticoliCODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'CODICE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 10
    end
    object QryListaArticoliDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'DESCRIZIONE'
      Size = 40
    end
    object QryListaArticoliPREZZO: TFloatField
      FieldName = 'PREZZO'
      Origin = 'PREZZO'
      currency = True
    end
  end
end
