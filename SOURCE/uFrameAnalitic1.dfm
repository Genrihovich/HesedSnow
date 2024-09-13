inherited frmAnalitic: TfrmAnalitic
  Width = 944
  Height = 739
  ExplicitWidth = 944
  ExplicitHeight = 739
  object panTop: TsPanel [0]
    Left = 0
    Top = 0
    Width = 944
    Height = 41
    Align = alTop
    Caption = 'panTop'
    TabOrder = 0
    ExplicitLeft = 584
    ExplicitTop = 312
    ExplicitWidth = 185
    object btnCalckClik: TsBitBtn
      Left = 528
      Top = 9
      Width = 153
      Height = 25
      Caption = 'btnCalckClik'
      TabOrder = 0
      OnClick = btnCalckClikClick
    end
    object btnExportToExcel: TsBitBtn
      Left = 704
      Top = 9
      Width = 145
      Height = 25
      Caption = 'btnExportToExcel'
      TabOrder = 1
      OnClick = btnExportToExcelClick
    end
    object BitBtn1: TBitBtn
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'BitBtn1'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object splitView: TsSplitView [1]
    Left = 0
    Top = 41
    Width = 281
    Height = 698
    OpenedSize = 200
    Placement = svpaLeft
    TabOrder = 1
    ExplicitHeight = 480
    object roUch: TsRollOutPanel
      Left = 8
      Top = 6
      Width = 257
      Height = 75
      Caption = 'roUch'
      TabOrder = 0
      object btnUch: TsBitBtn
        Left = 24
        Top = 8
        Width = 75
        Height = 25
        Caption = 'btnUch'
        TabOrder = 0
        OnClick = btnUchClick
      end
      object memUch: TsMemo
        Left = 48
        Top = 39
        Width = 185
        Height = 89
        Lines.Strings = (
          'memUch')
        TabOrder = 1
        Text = 'memUch'
      end
    end
    object roHousehold: TsRollOutPanel
      Left = 8
      Top = 98
      Width = 257
      Height = 95
      Caption = 'roHousehold'
      TabOrder = 1
      object btnDomgosp: TsBitBtn
        Left = 8
        Top = 12
        Width = 75
        Height = 25
        Caption = 'btnDomgosp'
        TabOrder = 0
        OnClick = btnDomgospClick
      end
      object memHousehold: TsMemo
        Left = 64
        Top = 43
        Width = 185
        Height = 89
        Lines.Strings = (
          'memHousehold')
        TabOrder = 1
        Text = 'memHousehold'
      end
    end
    object roAdditData: TsRollOutPanel
      Left = 8
      Top = 215
      Width = 257
      Height = 90
      Caption = 'roAdditData'
      TabOrder = 2
      object btnAdditData: TsBitBtn
        Left = 8
        Top = 3
        Width = 75
        Height = 25
        Caption = 'btnAdditData'
        TabOrder = 0
        OnClick = btnAdditDataClick
      end
      object memAdditData: TsMemo
        Left = 48
        Top = 34
        Width = 185
        Height = 89
        Lines.Strings = (
          'memAdditData')
        TabOrder = 1
        Text = 'memAdditData'
      end
    end
    object roVibivshie: TsRollOutPanel
      Left = 16
      Top = 328
      Width = 249
      Height = 113
      Caption = 'roVibivshie'
      TabOrder = 3
      object btnVibivshie: TsBitBtn
        Left = 8
        Top = 11
        Width = 75
        Height = 25
        Caption = 'btnVibivshie'
        TabOrder = 0
        OnClick = btnVibivshieClick
      end
      object memVibivshie: TsMemo
        Left = 16
        Top = 42
        Width = 185
        Height = 89
        Lines.Strings = (
          'memVibivshie')
        TabOrder = 1
        Text = 'memVibivshie'
      end
    end
  end
  object panAll: TsPanel [2]
    Left = 344
    Top = 77
    Width = 561
    Height = 572
    Caption = 'panAll'
    TabOrder = 2
    object DBGridEh1: TDBGridEh
      Left = 16
      Top = 8
      Width = 537
      Height = 457
      DynProps = <>
      TabOrder = 0
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  inherited sFrameAdapter1: TsFrameAdapter
    Left = 896
    Top = 8
  end
end
