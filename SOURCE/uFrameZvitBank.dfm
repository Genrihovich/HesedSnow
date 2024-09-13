inherited frmZvitBank: TfrmZvitBank
  Width = 1028
  Height = 612
  ExplicitWidth = 1028
  ExplicitHeight = 612
  object Splitter2: TSplitter [0]
    Left = 0
    Top = 435
    Width = 1028
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 401
    ExplicitTop = 1
    ExplicitWidth = 341
  end
  object sPanel1: TsPanel [1]
    Left = 0
    Top = 0
    Width = 1028
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnImportCards: TsBitBtn
      Left = 16
      Top = 9
      Width = 153
      Height = 25
      Caption = #1030#1084#1087#1086#1088#1090' '#1041#1050' '#1082#1072#1088#1090' '#1079' SNOW'
      TabOrder = 0
      OnClick = btnImportCardsClick
    end
    object btnImportZvitBank: TsBitBtn
      Left = 184
      Top = 9
      Width = 145
      Height = 25
      Caption = #1030#1084#1087#1086#1088#1090' '#1047#1074#1110#1090#1091' '#1079' '#1041#1072#1085#1082#1091
      TabOrder = 1
      OnClick = btnImportZvitBankClick
    end
    object btnImportError: TsBitBtn
      Left = 344
      Top = 9
      Width = 193
      Height = 25
      Caption = #1030#1084#1087#1086#1088#1090' '#1092#1072#1081#1083#1091' '#1087#1086#1084#1080#1083#1086#1082' '#1079' SNOW'
      TabOrder = 2
      OnClick = btnImportErrorClick
    end
  end
  object sPanel2: TsPanel [2]
    Left = 0
    Top = 41
    Width = 1028
    Height = 32
    Align = alTop
    BevelOuter = bvSpace
    TabOrder = 1
    DesignSize = (
      1028
      32)
    object lbCount: TsLabel
      Left = 168
      Top = 14
      Width = 82
      Height = 13
      Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1087#1080#1089#1077#1081':'
    end
    object lbCountError: TsLabel
      Left = 705
      Top = 13
      Width = 82
      Height = 13
      Anchors = [akTop, akRight, akBottom]
      Caption = #1050#1086#1083'-'#1074#1086' '#1079#1072#1087#1080#1089#1077#1081':'
    end
    object btnDownload: TsButton
      Left = 16
      Top = 6
      Width = 129
      Height = 21
      Caption = #1047#1072#1074#1072#1085#1090#1072#1078#1080#1090#1080' '#1076#1072#1085#1085#1110
      TabOrder = 0
      OnClick = btnDownloadClick
    end
    object btnEdit: TsBitBtn
      Left = 344
      Top = 4
      Width = 193
      Height = 25
      Caption = #1055#1077#1088#1077#1074#1110#1088#1082#1072
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnSaveFile: TsBitBtn
      Left = 832
      Top = 4
      Width = 185
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = #1047#1073#1077#1088#1077#1075#1090#1080' '#1074' '#1092#1072#1081#1083
      TabOrder = 2
      OnClick = btnSaveFileClick
    end
  end
  object TsPanel [3]
    Left = 0
    Top = 73
    Width = 1028
    Height = 362
    Align = alClient
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 589
      Top = 1
      Height = 360
      Align = alRight
      ExplicitLeft = 410
      ExplicitTop = 6
      ExplicitHeight = 338
    end
    object dbGridTemp: TsDBGrid
      Left = 1
      Top = 1
      Width = 588
      Height = 360
      Align = alClient
      Color = 15921906
      DataSource = DM.dsBankStatementTemp
      DrawingStyle = gdsGradient
      GradientEndColor = 13353918
      GradientStartColor = 14539223
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dbGridTempDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'NumCount'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OrgCode'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REP_PAN'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REP_INN'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REP_FIO'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REP_CURRBA'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REP_POST'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'REP_DATE'
          Width = 70
          Visible = True
        end>
    end
    object dbGridErrors: TsDBGrid
      Left = 592
      Top = 1
      Width = 435
      Height = 360
      Align = alRight
      Color = 15921906
      DataSource = DM.dsBankErrors
      DrawingStyle = gdsGradient
      GradientEndColor = 13353918
      GradientStartColor = 14539223
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'p_column'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'p_errors'
          Width = 370
          Visible = True
        end>
    end
  end
  object sPanel3: TsPanel [4]
    Left = 0
    Top = 438
    Width = 1028
    Height = 174
    Align = alBottom
    TabOrder = 3
    object dbgQuery: TsDBGrid
      Left = 1
      Top = 1
      Width = 1026
      Height = 172
      Align = alClient
      Color = 15921906
      DataSource = DM.dsBS
      DrawingStyle = gdsGradient
      GradientEndColor = 13353918
      GradientStartColor = 14539223
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbgQueryDrawColumnCell
      Columns = <
        item
          Expanded = False
          FieldName = 'JDC ID'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1060#1048#1054' '#1074#1083#1072#1076#1077#1083#1100#1094#1072' '#1082#1072#1088#1090#1099
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INN'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099
          Width = 110
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1076#1077#1081#1089#1090#1074#1080#1103
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1044#1072#1090#1072' '#1086#1089#1090#1072#1085#1086#1074#1082#1080
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1076#1077#1081#1089#1090#1074#1080#1103' '#1082#1072#1088#1090#1099
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = #1044#1077#1081#1089#1090#1074#1080#1090#1077#1083#1100#1085#1072
          Width = 64
          Visible = True
        end>
    end
  end
  inherited sFrameAdapter1: TsFrameAdapter
    Left = 728
    Top = 464
  end
end
