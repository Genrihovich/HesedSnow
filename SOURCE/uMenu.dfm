object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  Width = 197
  Height = 282
  TabOrder = 0
  TabStop = True
  object btnSLG: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 34
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1057#1051#1043
    TabOrder = 0
    OnClick = btnSLGClick
    ShowFocus = False
  end
  object btnNalogy: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 65
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1055#1086#1076#1072#1090#1082#1080' '#1085#1072' '#1087#1086#1089#1083#1091#1075#1080
    Enabled = False
    TabOrder = 1
    OnClick = btnNalogyClick
    ShowFocus = False
  end
  object btnCreateVidom: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1057#1090#1074#1086#1088#1080#1090#1080' '#1074#1110#1076#1086#1084#1110#1089#1090#1100
    ModalResult = 1
    TabOrder = 2
    OnClick = btnVidomistClick
    ShowFocus = False
  end
  object btnDavayPodkl: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 96
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1044#1072#1074#1072#1081' '#1087#1110#1076#1082#1083#1102#1095#1080#1084#1089#1103
    TabOrder = 3
    OnClick = btnDavayPodklClick
    ShowFocus = False
  end
  object btnUtils: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 127
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1059#1090#1110#1083#1110#1090#1080
    TabOrder = 4
    OnClick = btnUtilsClick
    ShowFocus = False
  end
  object btnImportBD: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 158
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1030#1084#1087#1086#1088#1090' '#1074' '#1093#1084#1072#1088#1091
    TabOrder = 5
    OnClick = btnImportBDClick
    ShowFocus = False
  end
  object btnZvitBank: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 189
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1047#1074#1110#1090' '#1079' '#1041#1072#1085#1082#1091
    TabOrder = 6
    OnClick = btnZvitBankClick
    ShowFocus = False
  end
  object btnDohod: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 220
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1057#1087#1088#1072#1074#1082#1080' '#1086' '#1076#1086#1093#1086#1076#1072#1093
    TabOrder = 7
    OnClick = btnDohodClick
  end
  object btnAnalitik: TsBitBtn
    AlignWithMargins = True
    Left = 3
    Top = 251
    Width = 191
    Height = 25
    Align = alTop
    Caption = #1040#1085#1072#1083#1110#1090#1080#1082#1072' '#1079#1072' '#1088#1110#1082
    TabOrder = 8
    OnClick = btnAnalitikClick
    ExplicitLeft = 6
    ExplicitTop = 228
  end
  object sFrameAdapter1: TsFrameAdapter
    Left = 160
    Top = 40
  end
end
