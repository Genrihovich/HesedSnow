inherited frmImportBD: TfrmImportBD
  Width = 754
  Height = 470
  ExplicitWidth = 754
  ExplicitHeight = 470
  object sPanel1: TsPanel [0]
    Left = 0
    Top = 41
    Width = 754
    Height = 429
    Align = alClient
    Caption = 'sPanel1'
    TabOrder = 0
    object sDBGrid1: TsDBGrid
      Left = 1
      Top = 1
      Width = 752
      Height = 427
      Align = alClient
      Color = 15921906
      DataSource = DM.UniDataSource1
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
    end
  end
  object sPanel2: TsPanel [1]
    Left = 0
    Top = 0
    Width = 754
    Height = 41
    Align = alTop
    TabOrder = 1
    object btnConnect: TsBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Connect'
      TabOrder = 0
      OnClick = btnConnectClick
      ShowFocus = False
    end
    object btnDeleteTable: TsBitBtn
      Left = 144
      Top = 8
      Width = 89
      Height = 25
      Caption = 'ClearTable'
      TabOrder = 1
      OnClick = btnDeleteTableClick
    end
    object sBitBtn1: TsBitBtn
      Left = 264
      Top = 8
      Width = 75
      Height = 25
      Caption = 'sBitBtn1'
      TabOrder = 2
      OnClick = sBitBtn1Click
    end
    object sBitBtn2: TsBitBtn
      Left = 480
      Top = 8
      Width = 75
      Height = 25
      Caption = 'sBitBtn2'
      TabOrder = 3
      OnClick = sBitBtn2Click
    end
  end
  inherited sFrameAdapter1: TsFrameAdapter
    Left = 680
    Top = 120
  end
  object ImageList1: TImageList
    Left = 680
    Top = 73
    Bitmap = {
      494C010102000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0002000000070000000C0000001000000012000000110000000E000000080000
      0002000000000000000000000000000000000000000000000000000000020000
      000C05031A46110852AB190C76E31D0E89FF1C0E89FF190C76E4120852AD0603
      1B4D0000000E0000000300000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000040001
      01120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A533AD20F2F21840001
      011500000005000000010000000000000000000000000000000301010519130A
      55A9211593FF2225AEFF2430C2FF2535CBFF2535CCFF2430C3FF2225AFFF2115
      94FF140B58B20101051E00000004000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000005050F0A351C5B
      40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE80FF258560FF1A56
      3DD405110C3D00000007000000010000000000000002010103151C1270CD2522
      A6FF2D3DCCFF394BD3FF3445D1FF2939CDFF2839CDFF3344D0FF394AD4FF2D3C
      CDFF2523A8FF1C1270D20101051D000000030000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000003040E0A31206548ED299D
      74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C996FF32CA99FF2BA4
      79FF227050F805110C3D00000005000000000000000919125BA72A27AAFF2F41
      D0FF3541C7FF2726ABFF3137BCFF384AD3FF384BD3FF3137BCFF2726ABFF3540
      C7FF2E40D0FF2927ACFF1A115EB10000000D0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000A1A573DD02EA57CFF33CA
      99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB99FF31CB98FF34CC
      9CFF31AD83FF1B5C41D3000101130000000208061C3D3129A2FD2C3CCCFF3842
      C6FF5F5DBDFFEDEDF8FF8B89CEFF3337B9FF3437B9FF8B89CEFFEDEDF8FF5F5D
      BDFF3741C6FF2B3ACDFF3028A4FF0907204A0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000B23185E2E8A66FF3BCD9EFF30CA
      97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3A8FF36CF9FFF33CD
      9BFF3ED0A3FF319470FF0F32237F000000071E185F9F373BBCFF3042D0FF2621
      A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1EDFFF3E9E2FFECE6
      EBFF2621A5FF2E3FCFFF343ABEFF201A66B00000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000184D37B63DB38CFF39CD9FFF4BD5
      A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4A1FF43D5A8FF3ED3
      A4FF3CD1A4FF41BC95FF1B5C43CD0000000B312A92E03542CBFF3446D1FF2C2F
      B5FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9E2FFEADAD1FF7F6F
      ACFF2B2EB5FF3144D0FF3040CBFF312A95E50000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001C6446DF4BCAA4FF44D2A8FF4FB3
      92FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B754FFF60DCB8FF48D8
      ACFF47D6AAFF51D4ACFF247A58F80000000E3E37AEFA3648D0FF374AD3FF3A4E
      D5FF3234B4FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EBE5FF897DB8FF3233
      B4FF384BD3FF3547D2FF3446D1FF3E37AEFA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000217050F266D9B8FF46D3A8FF0B67
      41FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A28BFF46A685FF5EDF
      BAFF4CD9AFFF6BE2C2FF278460FF02060419453FB4FA4557D7FF3B50D5FF4C5F
      DAFF4343B7FF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7EDE8FF9087C5FF4242
      B7FF495DD8FF394CD4FF3F52D4FF443FB3FA0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001E684ADC78D9BEFF52DAB1FF3DBA
      92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EAE7FF4F886CFF5ABB
      9AFF5BDEB9FF7FE2C7FF27835FF80000000C403DA1DC5967DAFF5B6EDDFF4F4D
      BAFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0EAFFFAF5F2FF8F89
      CAFF4E4DB9FF576ADCFF5765D9FF403EA4E10000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000019523BAB77C8B0FF62E0BCFF56DD
      B7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E76FFE6E1DCFF176B
      47FF5FD8B4FF83D5BDFF1E674CC6000000092E2D70987C85DDFF8798E8FF291D
      9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDFD8FFF4ECE7FFE5D9
      DCFF291D9BFF8494E7FF7A81DDFF33317BAC0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000009201747439C7BFF95ECD6FF5ADF
      BAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A17EFF1F6D4AFF288B
      64FF98EFD9FF4DAC8CFF1036286D00000004111125356768D0FC9EACEDFF686F
      CEFF5646A1FFCCB6BCFF7A68A8FF4C4AB6FF4D4BB7FF7A68A8FFCBB5BCFF5646
      A1FF666DCCFF9BAAEEFF696CD0FD1212273F0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000041C5F46B578C6ADFF9AEE
      D9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEAC9FF5ED6B6FF97ED
      D7FF86D3BBFF237759D20102010C00000001000000043B3B79977D84DFFFA5B6
      F1FF6D74D0FF2D219BFF5151B9FF8EA2ECFF8EA1ECFF5252BBFF2D219BFF6B72
      D0FFA2B3F0FF8086E0FF404183A7000000080000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000001030A0718247B5BDA70C1
      A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2DDFFBAF4E7FF78CD
      B3FF2A906DEA0615102E0000000200000000000000010303050C4E509DBC8087
      E2FFAEBDF3FFA3B6F1FF9DAFF0FF95A9EEFF95A8EEFF9BADEFFFA2B3F0FFACBC
      F3FF838AE3FF4F52A0C103030511000000020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001030A07171E69
      4FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8C1FF4BB692FF237F
      60CB05130E270000000300000000000000000000000000000001000000053234
      64797378D9F8929CEAFFA1AEEFFFB0BFF3FFB0BFF4FFA2AEEFFF939DE9FF7479
      DAF83234647D0000000800000002000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000010000
      00030A241B411B60489D258464CF2C9D77EE258867CF1F7156B00E3226560000
      0006000000020000000000000000000000000000000000000000000000000000
      00031213232D40437D935D61B5D07378DFFC7378DFFC5D61B5D040437D951212
      2230000000040000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FC003000000008003800100000000
      8001000000000000000100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000001000000000000
      8003800100000000C007E0030000000000000000000000000000000000000000
      000000000000}
  end
  object OpenDialog: TOpenDialog
    Left = 680
    Top = 177
  end
end
