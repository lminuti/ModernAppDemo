object DocumentoForm: TDocumentoForm
  Left = 0
  Top = 0
  Caption = 'DocumentoForm'
  ClientHeight = 729
  ClientWidth = 1008
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
  DesignSize = (
    1008
    729)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 50
    Width = 74
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'ID'
  end
  object Label3: TLabel
    Left = 16
    Top = 80
    Width = 74
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Data'
  end
  object Label4: TLabel
    Left = 16
    Top = 107
    Width = 74
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Cliente'
  end
  object Label5: TLabel
    Left = 16
    Top = 131
    Width = 74
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Righe'
  end
  object Label6: TLabel
    Left = 16
    Top = 648
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Tot. imponibile'
    ExplicitTop = 458
  end
  object Label7: TLabel
    Left = 16
    Top = 675
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Tot. IVA 22%'
    ExplicitTop = 485
  end
  object Label8: TLabel
    Left = 16
    Top = 702
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'Tot. docum.'
    ExplicitTop = 512
  end
  object ButtonCancel: TSpeedButton
    Left = 727
    Top = 688
    Width = 130
    Height = 32
    Action = acAnnulla
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 436
    ExplicitTop = 498
  end
  object ButtonPost: TSpeedButton
    Left = 863
    Top = 688
    Width = 130
    Height = 32
    Action = acSalva
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = 572
    ExplicitTop = 498
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 16113336
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      1008
      41)
    object ButtonExit: TSpeedButton
      Left = 6
      Top = 4
      Width = 81
      Height = 32
      Action = acIndietro
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ButtonDeleteRow: TSpeedButton
      Left = 726
      Top = 4
      Width = 130
      Height = 32
      Action = acEliminaRiga
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 416
    end
    object ButtonAddRow: TSpeedButton
      Left = 862
      Top = 4
      Width = 130
      Height = 32
      Action = acNuovaRiga
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 552
    end
    object DBText1: TDBText
      Left = 118
      Top = 10
      Width = 581
      Height = 19
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Tipo'
      DataSource = DSDocumento
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 291
    end
  end
  object DBGrid1: TDBGrid
    Left = 96
    Top = 131
    Width = 896
    Height = 506
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DSRighe
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyPress = DBGrid1KeyPress
  end
  object DBEdit1: TDBEdit
    Left = 96
    Top = 47
    Width = 121
    Height = 21
    DataField = 'ID'
    DataSource = DSDocumento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object DBEdit3: TDBEdit
    Left = 96
    Top = 77
    Width = 121
    Height = 21
    DataField = 'DATA'
    DataSource = DSDocumento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object DBEdit4: TDBEdit
    Left = 96
    Top = 104
    Width = 313
    Height = 21
    DataField = 'CLIENTE'
    DataSource = DSDocumento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object DBEdit5: TDBEdit
    Left = 96
    Top = 645
    Width = 121
    Height = 21
    Anchors = [akLeft, akBottom]
    DataField = 'TOTALEIMPONIBILE'
    DataSource = DSDocumento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object DBEdit6: TDBEdit
    Left = 96
    Top = 672
    Width = 121
    Height = 21
    Anchors = [akLeft, akBottom]
    DataField = 'TOTALEIVA'
    DataSource = DSDocumento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object DBEdit7: TDBEdit
    Left = 96
    Top = 699
    Width = 121
    Height = 21
    Anchors = [akLeft, akBottom]
    DataField = 'TOTALEDOCUMENTO'
    DataSource = DSDocumento
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object DSDocumento: TDataSource
    DataSet = QryDocumento
    Left = 200
    Top = 296
  end
  object DSRighe: TDataSource
    DataSet = QryRighe
    Left = 392
    Top = 296
  end
  object ActionList1: TActionList
    Left = 208
    Top = 168
    object acIndietro: TAction
      Caption = 'Indietro'
      OnExecute = acIndietroExecute
    end
    object acSalva: TAction
      Caption = 'Salva'
      OnExecute = acSalvaExecute
      OnUpdate = acSalvaUpdate
    end
    object acAnnulla: TAction
      Caption = 'Annulla'
      OnExecute = acAnnullaExecute
      OnUpdate = acSalvaUpdate
    end
    object acNuovaRiga: TAction
      Caption = 'NuovaRiga'
      OnExecute = acNuovaRigaExecute
    end
    object acEliminaRiga: TAction
      Caption = 'EliminaRiga'
      OnExecute = acEliminaRigaExecute
    end
  end
  object QryDocumento: TFDQuery
    BeforePost = QryDocumentoBeforePost
    CachedUpdates = True
    Connection = MainDM.FDConnection1
    SQL.Strings = (
      'SELECT * FROM DOCUMENTI WHERE ID = :P_ID')
    Left = 200
    Top = 247
    ParamData = <
      item
        Name = 'P_ID'
        ParamType = ptInput
      end>
    object QryDocumentoID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object QryDocumentoDATA: TDateField
      FieldName = 'DATA'
      Origin = 'DATA'
      Required = True
    end
    object QryDocumentoTIPO: TStringField
      FieldName = 'TIPO'
      Origin = 'TIPO'
    end
    object QryDocumentoCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Origin = 'CLIENTE'
      Size = 30
    end
    object QryDocumentoTOTALEIMPONIBILE: TFloatField
      FieldName = 'TOTALEIMPONIBILE'
      Origin = 'TOTALEIMPONIBILE'
      currency = True
    end
    object QryDocumentoTOTALEIVA: TFloatField
      FieldName = 'TOTALEIVA'
      Origin = 'TOTALEIVA'
      currency = True
    end
    object QryDocumentoTOTALEDOCUMENTO: TFloatField
      FieldName = 'TOTALEDOCUMENTO'
      Origin = 'TOTALEDOCUMENTO'
      currency = True
    end
    object QryDocumentoVALIDITA_GG: TIntegerField
      FieldName = 'VALIDITA_GG'
      Origin = 'VALIDITA_GG'
    end
    object QryDocumentoPAGAMENTO: TStringField
      FieldName = 'PAGAMENTO'
      Origin = 'PAGAMENTO'
      Size = 30
    end
  end
  object QryRighe: TFDQuery
    BeforePost = QryRigheBeforePost
    AfterPost = QryRigheAfterPost
    CachedUpdates = True
    Connection = MainDM.FDConnection1
    SQL.Strings = (
      'SELECT * FROM RIGHEDOCUMENTI WHERE ID_DOC = :P_ID_DOC'
      '')
    Left = 392
    Top = 247
    ParamData = <
      item
        Name = 'P_ID_DOC'
        ParamType = ptInput
      end>
    object QryRigheID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object QryRigheID_DOC: TIntegerField
      FieldName = 'ID_DOC'
      Origin = 'ID_DOC'
    end
    object QryRigheCODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'CODICE'
      Size = 10
    end
    object QryRigheDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'DESCRIZIONE'
      Size = 40
    end
    object QryRigheQTA: TFloatField
      FieldName = 'QTA'
      Origin = 'QTA'
    end
    object QryRighePREZZO: TFloatField
      FieldName = 'PREZZO'
      Origin = 'PREZZO'
      currency = True
    end
    object QryRigheSCONTO: TFloatField
      FieldName = 'SCONTO'
      Origin = 'SCONTO'
    end
    object QryRigheIMPORTO: TFloatField
      FieldName = 'IMPORTO'
      Origin = 'IMPORTO'
      currency = True
    end
  end
end
