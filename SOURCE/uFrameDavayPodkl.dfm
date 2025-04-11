inherited frmFrameDavayPodkl: TfrmFrameDavayPodkl
  Width = 975
  Height = 582
  ExplicitWidth = 975
  ExplicitHeight = 582
  object sPanel1: TsPanel [0]
    Left = 0
    Top = 0
    Width = 975
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      975
      41)
    object btnDownloadUslugy: TsBitBtn
      Left = 103
      Top = 10
      Width = 225
      Height = 25
      Caption = #1047#1072#1074#1072#1085#1090#1072#1078#1080#1090#1080' '#1092#1072#1081#1083' '#1079' '#1087#1086#1089#1083#1091#1075#1072#1084#1080' '#1044#1055
      Layout = blGlyphRight
      ModalResult = 12
      NumGlyphs = 2
      Spacing = 40
      TabOrder = 0
      OnClick = btnDownloadUslugyClick
      Grayed = True
      TextAlignment = taLeftJustify
    end
    object btnOtchet: TsBitBtn
      Left = 784
      Top = 10
      Width = 177
      Height = 25
      Action = abtnDounloadZvitFile
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1074#1072#1090#1072#1078#1080#1090#1080' '#1079#1074#1110#1090#1085#1080#1081' '#1092#1072#1081#1083'!'
      TabOrder = 1
    end
    object btnZahody: TsBitBtn
      Left = 334
      Top = 11
      Width = 168
      Height = 25
      Caption = #1047#1072#1074#1072#1085#1090#1072#1078#1080#1090#1080' '#1092#1072#1081#1083' '#1047#1072#1093#1086#1076#1110#1074
      TabOrder = 2
      OnClick = btnZahodyClick
    end
    object cbMonth: TsComboBox
      Left = 8
      Top = 11
      Width = 89
      Height = 21
      ItemIndex = -1
      TabOrder = 3
      Text = 'cbMonth'
      OnChange = cbMonthChange
    end
    object chbAllDownloadZvFile: TsCheckBox
      Left = 696
      Top = 14
      Width = 87
      Height = 15
      Caption = #1059#1089#1110' '#1074#1082#1083#1072#1076#1082#1080
      TabOrder = 4
    end
    object sBitBtn1: TsBitBtn
      Left = 564
      Top = 10
      Width = 75
      Height = 25
      Caption = 'sBitBtn1'
      TabOrder = 5
      OnClick = sBitBtn1Click
    end
  end
  object sPanel2: TsPanel [1]
    Left = 0
    Top = 41
    Width = 975
    Height = 500
    Align = alClient
    Caption = 'sPanel1'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 163
      Width = 973
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 336
    end
    object sDBGrid1: TsDBGrid
      Left = 1
      Top = 1
      Width = 973
      Height = 162
      Align = alTop
      Color = 15921906
      DataSource = DM.dsTemaDP
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
      Columns = <
        item
          Expanded = False
          FieldName = 'Data'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Tema'
          Width = 600
          Visible = True
        end>
    end
    object StringGrid: TJvStringGrid
      Left = 1
      Top = 166
      Width = 973
      Height = 333
      Align = alClient
      ColCount = 2
      RowCount = 1
      FixedRows = 0
      TabOrder = 1
      Alignment = taLeftJustify
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = []
    end
  end
  object sPanel3: TsPanel [2]
    Left = 0
    Top = 541
    Width = 975
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      975
      41)
    object btnCreateExcel: TsBitBtn
      Left = 736
      Top = 8
      Width = 225
      Height = 25
      Action = abtnCreateExcel
      Anchors = [akTop, akRight]
      Caption = #1057#1090#1074#1086#1088#1080#1090#1080' '#1092#1072#1081#1083's'
      TabOrder = 0
    end
  end
  inherited sFrameAdapter1: TsFrameAdapter
    Left = 24
    Top = 72
  end
  object ActionList: TActionList
    Left = 16
    Top = 128
    object abtnCreateExcel: TAction
      Caption = #1057#1090#1074#1086#1088#1080#1090#1080' '#1092#1072#1081#1083's'
      OnExecute = btnCreateExcelClick
      OnUpdate = abtnCreateExcelUpdate
    end
    object abtnDounloadZvitFile: TAction
      Caption = #1047#1072#1074#1072#1090#1072#1078#1080#1090#1080' '#1079#1074#1110#1090#1085#1080#1081' '#1092#1072#1081#1083'!'
      OnExecute = btnOtchetClick
      OnUpdate = abtnDounloadZvitFileUpdate
    end
  end
end
