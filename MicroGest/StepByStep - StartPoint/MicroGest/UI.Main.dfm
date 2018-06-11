object MainForm: TMainForm
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'MainForm'
  ClientHeight = 530
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 733
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 16113336
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      733
      41)
    object ButtonExit: TSpeedButton
      Left = 6
      Top = 4
      Width = 81
      Height = 32
      Action = acEsci
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ButtonDelete: TSpeedButton
      Left = 471
      Top = 4
      Width = 81
      Height = 32
      Action = acElimina
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object ButtonNew: TSpeedButton
      Left = 645
      Top = 4
      Width = 81
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'Nuovo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      PopupMenu = PopupMenuNuovo
      OnClick = ButtonNewClick
    end
    object ButtonAdd: TSpeedButton
      Left = 558
      Top = 4
      Width = 81
      Height = 32
      Action = acVisualizza
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ButtonRefresh: TSpeedButton
      Left = 222
      Top = 3
      Width = 81
      Height = 32
      Action = acRefresh
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 733
    Height = 489
    Align = alClient
    DataSource = DSListaDocumenti
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object MainMenu1: TMainMenu
    Left = 88
    Top = 96
    object ManuFile: TMenuItem
      Caption = 'File'
      object MenuEsci: TMenuItem
        Action = acEsci
      end
    end
    object MenuDocumenti: TMenuItem
      Caption = 'Documenti'
      object MenuVisualizza: TMenuItem
        Action = acVisualizza
      end
      object MenuNuovo: TMenuItem
        AutoHotkeys = maManual
        Caption = 'Nuovo'
      end
      object MenuElimina: TMenuItem
        Action = acElimina
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MenuRefresh: TMenuItem
        Action = acRefresh
      end
    end
  end
  object ActionList1: TActionList
    Left = 168
    Top = 96
    object acEsci: TAction
      Caption = 'Esci'
      OnExecute = acEsciExecute
    end
    object acVisualizza: TAction
      Caption = 'Visualizza'
      OnExecute = acVisualizzaExecute
    end
    object acElimina: TAction
      Caption = 'Elimina'
      OnExecute = acEliminaExecute
      OnUpdate = acEliminaUpdate
    end
    object acRefresh: TAction
      Caption = 'Refresh'
      OnExecute = acRefreshExecute
    end
  end
  object DSListaDocumenti: TDataSource
    Left = 312
    Top = 96
  end
  object PopupMenuNuovo: TPopupMenu
    AutoHotkeys = maManual
    Left = 88
    Top = 160
  end
end
