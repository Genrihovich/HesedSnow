inherited frmVidomost: TfrmVidomost
  Width = 736
  Height = 553
  ExplicitWidth = 736
  ExplicitHeight = 553
  object sGradientPanel1: TsGradientPanel [0]
    Left = 0
    Top = 0
    Width = 736
    Height = 41
    Align = alTop
    Caption = 'sGradientPanel1'
    ShowCaption = False
    TabOrder = 0
    object labInfoStatus: TsLabelFX
      Left = 1
      Top = 1
      Width = 651
      Height = 39
      Align = alClient
      Alignment = taCenter
      Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1074#1110#1076#1086#1084#1110#1089#1090#1110' '#1059#1057#1055#1030#1064#1053#1040'!!!'
      Color = clBtnFace
      ParentColor = False
      Angle = 0
      Shadow.OffsetKeeper.LeftTop = -3
      Shadow.OffsetKeeper.RightBottom = 5
      Shadow.Mode = smCustom
      ExplicitWidth = 163
      ExplicitHeight = 21
    end
    object sButton1: TsButton
      Left = 5
      Top = 8
      Width = 137
      Height = 25
      Caption = #1042#1090#1103#1085#1091#1090#1080' '#1076#1072#1085#1085#1110
      TabOrder = 0
      OnClick = sButton1Click
    end
    object chbPrint: TsCheckBox
      Left = 652
      Top = 1
      Width = 83
      Height = 39
      Caption = #1044#1088#1091#1082#1091#1074#1072#1090#1080
      Align = alRight
      TabOrder = 1
    end
  end
  object sPanel1: TsPanel [1]
    Left = 0
    Top = 41
    Width = 736
    Height = 512
    Align = alClient
    Caption = 'sPanel1'
    TabOrder = 1
    object DBGridEhVedomist: TDBGridEh
      Left = 1
      Top = 1
      Width = 734
      Height = 449
      Align = alClient
      DynProps = <>
      Flat = True
      FooterRowCount = 1
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
      MinAutoFitWidth = 80
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghFitRowHeightToText, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghAutoFitRowHeight, dghExtendVertLines]
      RowHeight = 2
      RowLines = 1
      RowSizingAllowed = True
      SumList.Active = True
      TabOrder = 0
      Columns = <
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Num_Uslugy'
          Footers = <>
          Width = 80
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'JDCID'
          Footers = <>
          Width = 80
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'FIO'
          Footers = <>
          Width = 150
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Count_usl'
          Footer.ValueType = fvtCount
          Footers = <>
          Width = 20
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Cost_usl'
          Footer.ValueType = fvtSum
          Footers = <>
          Width = 60
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Programma'
          Footers = <>
          Width = 100
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Curator'
          Footers = <>
          Width = 150
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Osobie_Proecty'
          Footers = <>
          Width = 20
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Zhertva'
          Footers = <>
          Width = 40
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Mobila'
          Footers = <>
          Width = 100
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Adress'
          Footers = <>
          Width = 200
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'S_Kem'
          Footers = <>
          Width = 80
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'SABA'
          Footers = <>
          Width = 80
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Type_Uchasnika'
          Footers = <>
          Width = 80
        end
        item
          CellButtons = <>
          DynProps = <>
          EditButtons = <>
          FieldName = 'Data_Plan'
          Footers = <>
          Width = 80
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
    object JvRollOut1: TJvRollOut
      Left = 1
      Top = 489
      Width = 734
      Height = 22
      Align = alBottom
      Caption = 'E-Mail '#1088#1086#1079#1089#1080#1083#1082#1072
      Collapsed = True
      TabOrder = 1
      FAWidth = 145
      FAHeight = 143
      FCWidth = 22
      FCHeight = 22
      object sButton2: TsButton
        Left = 606
        Top = 21
        Width = 127
        Height = 0
        Align = alRight
        Caption = #1042#1110#1076#1087#1088#1072#1074#1080#1090#1080
        TabOrder = 0
        OnClick = sButton2Click
        ExplicitHeight = 121
      end
      object sPanel3: TsPanel
        Left = 1
        Top = 21
        Width = 217
        Height = 0
        Align = alLeft
        TabOrder = 1
        ExplicitHeight = 121
        object sLabel1: TsLabel
          Left = 16
          Top = 26
          Width = 23
          Height = 13
          Caption = #1061#1086#1089#1090
        end
        object sLabel2: TsLabel
          Left = 16
          Top = 50
          Width = 25
          Height = 13
          Caption = #1055#1086#1088#1090
        end
        object sLabel3: TsLabel
          Left = 16
          Top = 73
          Width = 26
          Height = 13
          Caption = #1051#1086#1075#1110#1085
        end
        object sLabel4: TsLabel
          Left = 16
          Top = 96
          Width = 37
          Height = 13
          Caption = #1055#1072#1088#1086#1083#1100
        end
        object sLabelFX2: TsLabelFX
          Left = 38
          Top = 1
          Width = 118
          Height = 17
          Caption = #1053#1072#1083#1072#1096#1090#1091#1074#1072#1085#1085#1103' '#1087#1086#1096#1090#1080':'
          Angle = 0
          Shadow.OffsetKeeper.LeftTop = -1
          Shadow.OffsetKeeper.RightBottom = 3
        end
        object seHost: TsEdit
          Left = 59
          Top = 24
          Width = 121
          Height = 21
          TabOrder = 0
          Text = 'mail.ukraine.com.ua'
        end
        object seLogin: TsEdit
          Left = 59
          Top = 70
          Width = 149
          Height = 21
          TabOrder = 1
          Text = 'admin@hesedbesht.org.ua'
        end
        object sePort: TsEdit
          Left = 59
          Top = 47
          Width = 38
          Height = 21
          TabOrder = 2
          Text = '25'
        end
        object sePsw: TsEdit
          Left = 59
          Top = 93
          Width = 120
          Height = 21
          TabOrder = 3
          Text = 'zv238kcu'
        end
      end
      object sPanel4: TsPanel
        Left = 218
        Top = 21
        Width = 388
        Height = 0
        Align = alClient
        TabOrder = 2
        ExplicitHeight = 121
        object sbCheckCurators: TsScrollBox
          Left = 1
          Top = 1
          Width = 386
          Height = 119
          Align = alClient
          TabOrder = 0
        end
      end
    end
    object sPanel2: TsPanel
      Left = 1
      Top = 450
      Width = 734
      Height = 39
      Align = alBottom
      TabOrder = 2
      ExplicitTop = 329
      DesignSize = (
        734
        39)
      object sLabelFX1: TsLabelFX
        Left = 16
        Top = 12
        Width = 87
        Height = 17
        Caption = #1053#1072#1079#1074#1072' '#1074#1110#1076#1086#1084#1086#1089#1090#1110':'
        Angle = 0
        Shadow.OffsetKeeper.LeftTop = -1
        Shadow.OffsetKeeper.RightBottom = 3
      end
      object btnCreateVidomist: TsButton
        Left = 556
        Top = 6
        Width = 171
        Height = 25
        Action = acbtnCreateVidomist
        Anchors = [akTop, akRight, akBottom]
        TabOrder = 0
      end
      object cbVidomist: TDBComboBoxEh
        Left = 104
        Top = 10
        Width = 446
        Height = 21
        Anchors = [akLeft, akTop, akRight, akBottom]
        DynProps = <>
        DropDownBox.AutoDrop = True
        EditButtons = <>
        TabOrder = 1
        Visible = True
      end
    end
  end
  inherited sFrameAdapter1: TsFrameAdapter
    Top = 56
  end
  object OpenDialog: TOpenDialog
    Left = 32
    Top = 105
  end
  object actionList: TActionList
    Left = 32
    Top = 152
    object acbtnCreateVidomist: TAction
      AutoCheck = True
      Caption = #1057#1090#1074#1086#1088#1080#1090#1080' '#1074#1110#1076#1086#1084#1110#1089#1090#1100
      OnExecute = btnCreateVidomistClick
      OnUpdate = acbtnCreateVidomistUpdate
    end
  end
end
