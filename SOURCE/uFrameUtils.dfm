inherited frmUtils: TfrmUtils
  Width = 926
  Height = 627
  ExplicitWidth = 926
  ExplicitHeight = 627
  object lbFileName: TsLabel [0]
    Left = 13
    Top = 522
    Width = 192
    Height = 19
    Caption = #1055#1077#1088#1077#1090#1072#1097#1080' '#1092#1072#1081#1083' '#1085#1072' '#1092#1086#1088#1084#1091
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object sLabel1: TsLabel [1]
    Left = 25
    Top = 303
    Width = 229
    Height = 13
    Alignment = taCenter
    Caption = #1055#1077#1088#1077#1090#1103#1085#1091#1090#1080' '#1087#1086#1083#1103' '#1085#1072' '#1084#1110#1090#1082#1080' '#1076#1083#1103' '#1076#1083#1103' '#1087#1077#1088#1077#1074#1110#1088#1082#1080
  end
  object lbFirstParam: TsLabel [2]
    Left = 3
    Top = 590
    Width = 67
    Height = 13
    Alignment = taCenter
    Caption = '1-'#1081' '#1087#1072#1088#1072#1084#1077#1090#1088
    OnDragDrop = lbFirstParamDragDrop
    OnDragOver = lbFirstParamDragOver
  end
  object lbSecondParam: TsLabel [3]
    Left = 131
    Top = 590
    Width = 67
    Height = 13
    Alignment = taCenter
    Caption = '2-'#1081' '#1087#1072#1088#1072#1084#1077#1090#1088
    OnDragDrop = lbSecondParamDragDrop
    OnDragOver = lbFirstParamDragOver
  end
  object sLabel4: TsLabel [4]
    Left = 105
    Top = 586
    Width = 16
    Height = 19
    Caption = #1090#1072
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object lbFirdParam: TsLabel [5]
    Left = 216
    Top = 591
    Width = 145
    Height = 13
    Alignment = taCenter
    Caption = #1055#1086' '#1103#1082#1086#1084#1091' '#1087#1086#1083#1102' '#1087#1077#1088#1077#1074#1110#1088#1082#1072
    OnDragDrop = lbFirdParamDragDrop
    OnDragOver = lbFirstParamDragOver
  end
  object sBitBtn1: TsBitBtn [6]
    Left = 3
    Top = 271
    Width = 201
    Height = 25
    Caption = #1087#1086#1095#1072#1090#1080' '#1087#1086#1096#1091#1082
    TabOrder = 0
    OnClick = sBitBtn1Click
  end
  object mInSpisok: TsMemo [7]
    Left = 3
    Top = 32
    Width = 257
    Height = 233
    Lines.Strings = (
      #1055#1077#1090#1088#1086#1074#1072' '#1057'.'
      #1044#1077#1085#1077#1075#1072' '#1058'C.'
      #1045#1088#1096#1086#1074#1072' '#1045#1051
      ' '#1044#1077#1085#1077#1075#1072' '#1058'. C.'
      #1044#1077#1085#1077#1075#1072' '#1058'.C.'
      #1043#1077#1088#1074#1080#1094' '#1042#1072#1083#1077#1085#1090#1080#1085#1072
      #1042#1080#1085#1085#1080#1082
      '')
    ScrollBars = ssVertical
    TabOrder = 1
    Text = 
      #1055#1077#1090#1088#1086#1074#1072' '#1057'.'#13#10#1044#1077#1085#1077#1075#1072' '#1058'C.'#13#10#1045#1088#1096#1086#1074#1072' '#1045#1051#13#10' '#1044#1077#1085#1077#1075#1072' '#1058'. C.'#13#10#1044#1077#1085#1077#1075#1072' '#1058'.C.'#13#10#1043 +
      #1077#1088#1074#1080#1094' '#1042#1072#1083#1077#1085#1090#1080#1085#1072#13#10#1042#1080#1085#1085#1080#1082#13#10#13#10
  end
  object mOutSpisok: TsRichEdit [8]
    Left = 266
    Top = 3
    Width = 657
    Height = 513
    Color = 15921906
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    Zoom = 100
  end
  object btnKillNumber: TsBitBtn [9]
    Left = 5
    Top = 3
    Width = 116
    Height = 25
    Caption = #1059#1073#1088#1072#1090#1080' '#1085#1091#1084#1077#1088#1072#1094#1110#1102
    TabOrder = 3
    OnClick = btnKillNumberClick
  end
  object lwColumn: TsListView [10]
    Left = 10
    Top = 322
    Width = 250
    Height = 194
    Columns = <>
    ColumnClick = False
    DragMode = dmAutomatic
    FlatScrollBars = True
    FullDrag = True
    GridLines = True
    TabOrder = 4
    ViewStyle = vsList
  end
  object btnPerevPoliv: TsBitBtn [11]
    Left = 3
    Top = 558
    Width = 201
    Height = 26
    Action = acBtnPerevPoliv
    Caption = #1055#1077#1088#1077#1074#1110#1088#1082#1072' '#1074#1110#1076#1087#1086#1074#1110#1076#1085#1086#1089#1090#1110' '#1087#1086#1083#1110#1074
    TabOrder = 5
  end
  object btnDviniky: TsBitBtn [12]
    Left = 216
    Top = 560
    Width = 145
    Height = 25
    Action = acBtnDviynik
    Caption = #1055#1077#1088#1077#1074#1110#1088#1082#1072' '#1085#1072' '#1076#1074#1110#1081#1085#1080#1082#1110#1074
    TabOrder = 6
  end
  inherited sFrameAdapter1: TsFrameAdapter
    Left = 232
    Top = 8
  end
  object acList: TActionList
    Left = 282
    Top = 451
    object acBtnPerevPoliv: TAction
      AutoCheck = True
      Caption = #1055#1077#1088#1077#1074#1110#1088#1082#1072' '#1074#1110#1076#1087#1086#1074#1110#1076#1085#1086#1089#1090#1110' '#1087#1086#1083#1110#1074
      OnExecute = btnPerevPolivClick
      OnUpdate = acBtnPerevPolivUpdate
    end
    object acBtnDviynik: TAction
      AutoCheck = True
      Caption = #1055#1077#1088#1077#1074#1110#1088#1082#1072' '#1085#1072' '#1076#1074#1110#1081#1085#1080#1082#1110#1074
      OnExecute = btnDvinikyClick
      OnUpdate = acBtnDviynikUpdate
    end
  end
end
