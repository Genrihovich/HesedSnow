object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 642
  Width = 847
  object tVedomost: TADOTable
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'Vidomist'
    Left = 16
    Top = 64
  end
  object myConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=G:\GitCopy\HesedSno' +
      'w\BIN\Win32\Debug\Snow.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 8
  end
  object dsVedomist: TDataSource
    DataSet = tVedomost
    Left = 16
    Top = 112
  end
  object qQuery: TADOQuery
    Connection = myConnection
    Parameters = <>
    Left = 16
    Top = 168
  end
  object tPodopechnie: TADOTable
    Connection = myConnection
    TableName = 'nal_Podopechnie'
    Left = 192
    Top = 64
  end
  object DataSource1: TDataSource
    Left = 568
    Top = 256
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 568
    Top = 208
  end
  object tUslugy: TADOTable
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'Uslugy'
    Left = 80
    Top = 64
  end
  object dsUslugy: TDataSource
    DataSet = qUslugy
    Left = 80
    Top = 168
  end
  object qUslugy: TADOQuery
    Connection = myConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select Uslugy.[FIO], Uslugy.[JDCID],Uslugy.[RITM],Uslugy.[Number' +
        '],Uslugy.[SABA],Uslugy.[City] from Uslugy ORDER BY Uslugy.[FIO]')
    Left = 80
    Top = 120
  end
  object dsQslg: TDataSource
    DataSet = qQslg
    Left = 128
    Top = 168
  end
  object qQslg: TADOQuery
    Connection = myConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from slg_items')
    Left = 128
    Top = 120
    object qQslgPrice_inch: TBCDField
      DisplayWidth = 8
      FieldName = 'Price_inch'
      Precision = 19
    end
    object qQslgName_SLG: TWideStringField
      FieldName = 'Name_SLG'
      Size = 255
    end
    object qQslgActive: TBooleanField
      FieldName = 'Active'
    end
    object qQslgupakovka: TIntegerField
      FieldName = 'upakovka'
    end
    object qQslgKategorya: TWideStringField
      FieldName = 'Kategorya'
      Size = 255
    end
  end
  object tSLG: TADOTable
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'slg_items'
    Left = 128
    Top = 64
    object tSLGPrice_inch: TBCDField
      FieldName = 'Price_inch'
      Precision = 19
    end
    object tSLGName_SLG: TWideStringField
      FieldName = 'Name_SLG'
      Size = 120
    end
    object tSLGActive: TBooleanField
      FieldName = 'Active'
    end
    object tSLGupakovka: TIntegerField
      FieldName = 'upakovka'
    end
    object tSLGKategorya: TWideStringField
      FieldName = 'Kategorya'
      Size = 255
    end
  end
  object tUslusgyDavayPodkl: TADOTable
    Connection = myConnection
    TableName = 'UslusgyDavayPodkl'
    Left = 120
    Top = 296
  end
  object tTemaDavayPodkl: TADOTable
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'TemaDavayPodkl'
    Left = 24
    Top = 288
    object tTemaDavayPodklData: TWideStringField
      FieldName = 'Data'
      Size = 10
    end
    object tTemaDavayPodklTema: TWideStringField
      FieldName = 'Tema'
      Size = 255
    end
  end
  object dsTemaDP: TDataSource
    DataSet = qTemaDP
    Left = 24
    Top = 392
  end
  object qTemaDP: TADOQuery
    Connection = myConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from TemaDavayPodkl order by data')
    Left = 24
    Top = 336
  end
  object UniTable1: TUniTable
    TableName = 'Uchastniky'
    Left = 424
    Top = 248
  end
  object tZahody: TADOTable
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'Zahody'
    Left = 112
    Top = 344
  end
  object qZahody: TADOQuery
    Connection = myConnection
    Parameters = <>
    SQL.Strings = (
      'select * zahody')
    Left = 112
    Top = 400
  end
  object tCurators: TADOTable
    Active = True
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'Curators'
    Left = 264
    Top = 64
  end
  object tBK: TADOTable
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'BK'
    Left = 8
    Top = 472
  end
  object tBankStatement: TADOTable
    Connection = myConnection
    TableName = 'bank_statement'
    Left = 72
    Top = 472
  end
  object tBankErrors: TADOTable
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'bank_errors'
    Left = 288
    Top = 472
  end
  object dsBankErrors: TDataSource
    DataSet = tBankErrors
    Left = 288
    Top = 568
  end
  object dsBankStatementTemp: TDataSource
    DataSet = qbank_statement_Temp
    Left = 176
    Top = 568
  end
  object qBS: TADOQuery
    Connection = myConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * From BK Where (BK.[INN]) = "1466102258"')
    Left = 72
    Top = 528
  end
  object tBankStatementTemp: TADOTable
    Connection = myConnection
    CursorType = ctStatic
    TableName = 'bank_statement_Temp'
    Left = 176
    Top = 472
  end
  object dsBS: TDataSource
    DataSet = qBS
    Left = 72
    Top = 584
  end
  object qbank_statement_Temp: TADOQuery
    Connection = myConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM bank_statement_Temp'
      
        'ORDER BY  bank_statement_Temp.REP_FIO, bank_statement_Temp.NumCo' +
        'unt ASC')
    Left = 176
    Top = 528
  end
  object tUchastniky: TADOTable
    Connection = myConnection
    TableName = 'Uchastniky'
    Left = 496
    Top = 24
  end
  object qUchastniky: TADOQuery
    Active = True
    Connection = myConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT Uchastniky.'#1050#1091#1088#1072#1090#1086#1088', Count(Uchastniky.['#1050#1086#1076' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080']) A' +
        'S [Count-'#1060#1048#1054']'
      'FROM Uchastniky'
      
        'WHERE (((Uchastniky.['#1058#1080#1087' '#1082#1083#1080#1077#1085#1090#1072' ('#1076#1083#1103' '#1087#1086#1080#1089#1082#1072')])<>"") AND ((Uchas' +
        'tniky.'#1048#1085#1074#1072#1083#1080#1076#1085#1086#1089#1090#1100')="'#1044#1072'"))'
      'GROUP BY Uchastniky.'#1050#1091#1088#1072#1090#1086#1088';')
    Left = 496
    Top = 72
  end
  object dsUchastniky: TDataSource
    AutoEdit = False
    DataSet = qUchastniky
    Left = 496
    Top = 120
  end
  object OpenDialog: TOpenDialog
    Left = 104
    Top = 8
  end
  object tHousehold: TADOTable
    Connection = myConnection
    TableName = 'Household'
    Left = 568
    Top = 24
  end
  object tAdditData: TADOTable
    Connection = myConnection
    TableName = 'AdditionalData'
    Left = 568
    Top = 72
  end
  object tVibivshie: TADOTable
    Connection = myConnection
    TableName = 'Vibivshie'
    Left = 568
    Top = 120
  end
  object qAnaliticAll: TADOQuery
    Connection = myConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from AnaliticAll')
    Left = 424
    Top = 432
  end
  object tAnaliticAll: TADOTable
    Connection = myConnection
    TableName = 'analiticAll'
    Left = 424
    Top = 368
  end
  object dsAnaliticAll: TDataSource
    DataSet = qAnaliticAll
    Left = 424
    Top = 304
  end
  object MySQLUniProvider: TMySQLUniProvider
    Left = 424
    Top = 16
  end
  object UniConnection: TUniConnection
    ProviderName = 'MySQL'
    Port = 3306
    Database = 'hesed_test'
    Username = 'hesed_test'
    Server = 'hesed.mysql.ukraine.com.ua'
    Left = 424
    Top = 72
    EncryptedPassword = 'D4FFCFFF9EFFA7FFCCFF85FFDAFFCCFF90FFBAFF'
  end
  object UniQuery1: TUniQuery
    SQLInsert.Strings = (
      
        'INSERT INTO `hesed_test`.`Uchastniky` (`JDC ID`, `'#1060#1048#1054'`, `'#1058#1080#1087' '#1091#1095#1072 +
        #1089#1090#1085#1080#1082#1072'`, `'#1042#1086#1079#1088#1072#1089#1090'`, `'#1055#1077#1085#1089#1080#1103'`, `'#1050#1091#1088#1072#1090#1086#1088'`, `'#1043#1086#1088#1086#1076'`, `'#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '#1091 +
        #1095#1072#1089#1090#1085#1080#1082#1072'`, `'#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099'`, `'#1057#1088'. '#1076#1086#1093#1086#1076' '#1076#1083#1103' '#1052#1055' ('#1061#1077#1089#1077#1076')' +
        '`, `'#1057#1088'. '#1076#1086#1093#1086#1076' '#1076#1083#1103' '#1052#1055' ('#1076#1077#1090#1089#1082#1080#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099')`, `'#1040#1076#1088#1077#1089' '#1073#1077#1079' '#1075#1086#1088#1086#1076#1072'`, `' +
        #1046#1053'`, `'#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1087#1072#1090#1088#1086#1085#1072#1078#1072'`, `'#1044#1086#1084#1072#1096#1085#1080#1081' '#1090#1077#1083#1077#1092#1086#1085'`, `'#1052#1086#1073#1080#1083#1100#1085#1099#1081' '#1090#1077#1083 +
        #1077#1092#1086#1085'`, `'#1050#1086#1076' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080'`, `'#1055#1086#1083#1091#1095#1072#1077#1090' '#1084#1072#1090#1077#1088#1080#1072#1083#1100#1085#1091#1102' '#1087#1086#1076#1076#1077#1088#1078#1082#1091'`, `'#1058#1080 +
        #1087' '#1082#1083#1080#1077#1085#1090#1072' ('#1076#1083#1103' '#1087#1086#1080#1089#1082#1072')`, `'#1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1094#1080#1086#1085#1085#1072#1103' '#1082#1072#1088#1090#1072'`, `'#1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076 +
        #1085#1077#1075#1086' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103'`, `'#1048#1084#1077#1077#1090' '#1076#1077#1090#1077#1081' '#1090#1088#1091#1076#1086#1089#1087#1086#1089#1086#1073#1085#1086#1075#1086' '#1074#1086#1079#1088#1072#1089#1090#1072'`, `'#1050#1086#1088#1086#1085 +
        #1072#1074#1080#1088#1091#1089'`, `'#1053#1077' '#1084#1086#1078#1077#1090' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100#1089#1103' '#1082#1072#1088#1090#1086#1081'`, `'#1053#1077' '#1088#1072#1089#1087#1080#1089#1099#1074#1072#1077#1090#1089#1103'`, `'#1054#1094 +
        #1077#1085#1082#1072' '#1092#1091#1085#1082#1094#1080#1086#1085#1080#1088#1086#1074#1072#1085#1080#1103'`, `'#1042#1055#1051'`, `'#1057' '#1082#1077#1084' '#1087#1088#1086#1078#1080#1074#1072#1077#1090'`, `'#1050#1083#1080#1077#1085#1090'?`, `IN' +
        'N`, `'#1048#1085#1074#1072#1083#1080#1076#1085#1086#1089#1090#1100'`, `BIE`, `'#1045#1074#1088#1077#1081#1089#1082#1086#1077' '#1087#1088#1086#1080#1089#1093#1086#1078#1076#1077#1085#1080#1077'`, `'#1050#1091#1088#1072#1090#1086#1088' C' +
        'I/'#1050#1077#1081#1089'-'#1084#1077#1085#1077#1076#1078#1077#1088'`, `'#1055#1086#1083'`, `'#1055#1086#1083#1091#1095#1072#1077#1090' '#1087#1072#1090#1088#1086#1085#1072#1078'`, `'#1050#1083#1080#1077#1085#1090' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083 +
        #1100#1085#1072#1103' '#1080#1085#1092'`, `'#1059#1079#1085#1080#1082'`, `'#1044#1086#1093#1086#1076' '#1085#1077' '#1087#1088#1077#1076#1086#1089#1090#1072#1074#1083#1077#1085'`, `'#1055#1088#1080#1095#1080#1085#1072' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1103 +
        ' '#1076#1072#1085#1085#1099#1093' '#1086' '#1076#1086#1093#1086#1076#1077'`) VALUES ('#39'0002477265'#39', '#39'Arkadiy Piven'#39', '#39#1057#1091#1087#1077#1088 +
        #1074#1080#1079#1086#1088' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' \"'#1059#1093#1086#1076' '#1085#1072' '#1076#1086#1084#1091'\" ('#1044#1078#1086#1081#1085#1090'), '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080 +
        #1086#1085#1085#1099#1093' '#1089#1080#1089#1090#1077#1084' ('#1044#1078#1086#1081#1085#1090')'#39', 0, '#39'0.00'#39', NULL, NULL, '#39#1041#1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1099 +
        #1081' '#1092#1086#1085#1076' '#1044#1078#1086#1081#1085#1090' '#1074' '#1041#1077#1083#1072#1088#1091#1089#1080','#1041#1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' \"'#1061#1072#1088#1100#1082#1086#1074 +
        #1089#1082#1080#1081' '#1077#1074#1088#1077#1081#1089#1082#1080#1081' '#1073#1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1092#1086#1085#1076' '#1061#1077#1089#1077#1076'-'#1064#1072#1072#1088#1077' '#1058#1080#1082#1074#1072'\",'#1054#1054' '#1045#1074#1088 +
        #1077#1081#1089#1082#1080#1081' '#1086#1073#1097#1080#1085#1085#1099#1081' '#1073#1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1086'-'#1082#1091#1083#1100#1090#1091#1088#1085#1099#1081' '#1094#1077#1085#1090#1088' \"'#1061#1101#1089#1101#1076'\" '#1075'.'#1058#1080 +
        #1088#1072#1089#1087#1086#1083#1103','#1061#1077#1089#1077#1076' '#1052#1080#1093#1072#1101#1083#1100' - '#1047#1072#1087#1086#1088#1086#1078#1100#1077','#1061#1077#1089#1077#1076' '#1052#1086#1088#1080#1072' - '#1050#1088#1072#1084#1072#1090#1086#1088#1089#1082','#1061#1077#1089#1077#1076 +
        ' '#1069#1084#1091#1085#1072' - '#1042#1080#1085#1085#1080#1094#1072','#1061#1077#1089#1077#1076' '#1041#1077#1096#1090' - '#1061#1084#1077#1083#1100#1085#1080#1094#1082#1080#1081','#1050#1080#1077#1074' X'#1101#1089#1101#1076' \"'#1041#1085#1101#1081' '#1040#1079#1088#1080 +
        #1101#1083#1100'\",'#1054#1076#1077#1089#1089#1072' '#1061#1077#1089#1077#1076' '#1064#1072#1072#1088#1077#1081' '#1062#1080#1086#1085','#1053#1077#1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' '#1041#1083#1072#1075#1086#1090 +
        #1074#1086#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1060#1086#1085#1076' '#1089#1086#1094#1080#1072#1083#1100#1085#1086#1081' '#1087#1086#1076#1076#1077#1088#1078#1082#1080' \"'#1057#1077#1084#1077#1081#1085#1099#1081' '#1094#1077#1085#1090#1088'\",'#1060#1086#1085#1076' '#171#1045 +
        #1074#1088#1077#1081#1089#1082#1080#1081' '#1041#1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1062#1077#1085#1090#1088' \"'#1061#1101#1089#1101#1076' '#1048#1077#1075#1091#1076#1072'\"'#187','#1058#1073#1080#1083#1080#1089#1080' \"'#1061#1101#1089 +
        #1101#1076' '#1069#1083#1080#1072#1091'\",'#1061#1077#1089#1077#1076' '#1053#1077#1088' - '#1051#1091#1075#1072#1085#1089#1082','#1045#1074#1088#1077#1081#1089#1082#1080#1081' '#1086#1073#1097#1077#1089#1090#1074#1077#1085#1085#1099#1081' '#1094#1077#1085#1090#1088' \"'#1052#1072 +
        #1079#1072#1083#1100' '#1058#1086#1074'\",'#1061#1077#1089#1077#1076' '#1043#1077#1088#1096#1086#1085' - '#1041#1072#1082#1091','#1041#1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' \"'#1041 +
        #1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1092#1086#1085#1076' \"'#1061#1101#1089#1101#1076' '#1061#1072#1085#1072'\",'#1061#1077#1089#1077#1076' '#1062#1076#1072#1082#1072' - '#1044#1086#1085#1077#1094#1082#39', NULL' +
        ', '#39'0.00'#39', '#39'0.00'#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, NULL, '#39'+972.52.3958894'#39 +
        ', '#39'1374,502,724,1934,875,2061,1495,1292,1500,1258,1492,1705,2237' +
        ',2036,2211,2088,2541,3069,2851,90003,3035,3084,3034,66,905,1261,' +
        '2317,1415,2968,1226,130,1214,1398,2319,604,2210,2781,483,1251,12' +
        '35,2063,2314,1256,1254,1233,1392,602'#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39#1057#1091#1087#1077#1088#1074#1080#1079#1086#1088' '#1087#1088 +
        #1086#1075#1088#1072#1084#1084#1099' \"'#1059#1093#1086#1076' '#1085#1072' '#1076#1086#1084#1091'\" ('#1044#1078#1086#1081#1085#1090'), '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1099#1093' '#1089#1080 +
        #1089#1090#1077#1084' ('#1044#1078#1086#1081#1085#1090')'#39', NULL, NULL, NULL, NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', NU' +
        'LL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39'--'#1053#1077' '#1091#1082#1072#1079#1072#1085#1086'--'#39', '#39#1053#1045#1042#1045#1056#1053#1054 +
        #39', '#39#1044#1072#39', NULL, '#39#1052#1091#1078#1089#1082#1086#1081#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39'Arkadiy Piven'#39', '#39#1053#1045#1042#1045#1056#1053#1054#39',' +
        ' '#39#1042#1045#1056#1053#1054#39', NULL), ('#39'0000004143'#39', '#39'Nina Gorodetskaya'#39', '#39#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086 +
        #1088' '#1074#1086#1083#1086#1085#1090#1077#1088#1086#1074', '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1099#1093' '#1089#1080#1089#1090#1077#1084' ('#1044#1078#1086#1081#1085#1090'), '#1054#1087#1077#1088#1072#1090 +
        #1086#1088#39', 0, '#39'0.00'#39', NULL, '#39#1050#1080#1077#1074#39', '#39#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1050#1080#1077#1074#1077 +
        ','#1061#1077#1089#1077#1076' '#1069#1089#1090#1077#1088' - '#1063#1077#1088#1085#1080#1075#1086#1074','#1061#1077#1089#1077#1076' '#1040#1088#1100#1077' - '#1051#1100#1074#1086#1074','#1061#1077#1089#1077#1076' '#1069#1084#1091#1085#1072' - '#1042#1080#1085#1085#1080#1094#1072 +
        ','#1061#1077#1089#1077#1076' '#1041#1077#1096#1090' - '#1061#1084#1077#1083#1100#1085#1080#1094#1082#1080#1081','#1050#1080#1077#1074' X'#1101#1089#1101#1076' \"'#1041#1085#1101#1081' '#1040#1079#1088#1080#1101#1083#1100'\",'#1061#1077#1089#1077#1076' '#1044#1086#1088#1086 +
        #1090' - '#1063#1077#1088#1082#1072#1089#1089#1099','#1054#1073#1097#1077#1089#1090#1074#1077#1085#1085#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' \"'#1061#1040#1051#1054#1052'\"'#39', NULL, '#39'0.00'#39', ' +
        #39'0.00'#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, NULL, NULL, '#39'1155,1362,2952,1304,' +
        '2542,2207,2545,2540,2088,2541,3084,1680,1054,2909,3103,90002'#39', '#39 +
        #1053#1045#1042#1045#1056#1053#1054#39', '#39#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1074#1086#1083#1086#1085#1090#1077#1088#1086#1074', '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1099#1093' '#1089#1080 +
        #1089#1090#1077#1084' ('#1044#1078#1086#1081#1085#1090'), '#1054#1087#1077#1088#1072#1090#1086#1088#39', NULL, NULL, NULL, NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39#1053#1045 +
        #1042#1045#1056#1053#1054#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39'--'#1053#1077' '#1091#1082#1072#1079#1072#1085#1086'--'#39 +
        ', '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, NULL, '#39#1046#1077#1085#1089#1082#1080#1081#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39'Nina Gorodetskay' +
        'a'#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39#1042#1045#1056#1053#1054#39', NULL), ('#39'0000177865'#39', '#39'Olga Shpakovskaya' +
        #39', '#39#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1089#1086#1094#1080#1072#1083#1100#1085#1099#1093' '#1087#1088#1086#1075#1088#1072#1084#1084' ('#1044#1078#1086#1081#1085#1090'), '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1087#1072#1090#1088#1086#1085 +
        #1072#1078#1072', '#1054#1087#1077#1088#1072#1090#1086#1088', '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1099#1093' '#1089#1080#1089#1090#1077#1084' ('#1044#1078#1086#1081#1085#1090')'#39', 43, ' +
        #39'0.00'#39', NULL, '#39#1057#1072#1085#1082#1090'-'#1055#1077#1090#1077#1088#1073#1091#1088#1075#39', '#39#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1054#1076 +
        #1077#1089#1089#1077','#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1058#1073#1080#1083#1080#1089#1080','#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085 +
        #1090#1072' '#1074' '#1041#1072#1082#1091','#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1050#1080#1096#1080#1085#1077#1074#1077','#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086 +
        ' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1045#1082#1072#1090#1077#1088#1080#1085#1073#1091#1088#1075#1077','#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1061#1072#1088#1100#1082#1086#1074#1077','#1055#1088 +
        #1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1050#1080#1077#1074#1077','#1041#1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1092#1086#1085#1076' '#1044#1078#1086#1081#1085#1090' '#1074' ' +
        #1041#1077#1083#1072#1088#1091#1089#1080','#1060#1080#1083#1080#1072#1083' '#1041#1083#1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1086#1075#1086' '#1060#1086#1085#1076#1072' '#1056#1072#1089#1087#1088#1077#1076#1077#1083#1080#1090#1077#1083#1100#1085#1099#1081' '#1050#1086#1084#1080#1090 +
        #1077#1090' '#1044#1078#1086#1081#1085#1090' '#1074' '#1075'.'#1056#1086#1089#1090#1086#1074#1077'-'#1085#1072'-'#1044#1086#1085#1091','#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1057'.-'#1055#1077#1090 +
        #1077#1088#1073#1091#1088#1075#1077','#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083#1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1044#1085#1077#1087#1088#1086#1087#1077#1090#1088#1086#1074#1089#1082#1077','#1055#1088#1077#1076#1089#1090#1072#1074#1080#1090#1077#1083 +
        #1100#1089#1090#1074#1086' '#1044#1078#1086#1081#1085#1090#1072' '#1074' '#1040#1083#1084#1072#1090#1099','#1061#1101#1089#1101#1076' \"'#1056#1072#1093#1077#1083#1100'\" - '#1055#1072#1074#1083#1086#1076#1072#1088','#1050#1091#1090#1072#1080#1089#1080' '#1061#1101#1089#1101#1076 +
        ' '#1040#1073#1091#1083#1080','#1061#1077#1089#1077#1076' '#1055#1086#1083#1080#1085#1072' - '#1040#1083#1084#1072'-'#1040#1090#1072','#1061#1077#1089#1077#1076' '#1041#1077#1096#1090' - '#1061#1084#1077#1083#1100#1085#1080#1094#1082#1080#1081','#1050#1088#1072#1089#1085#1086#1076#1072 +
        #1088' \"'#1061#1101#1089#1101#1076' '#1058#1080#1082#1074#1072' ('#1053#1072#1076#1077#1078#1076#1072')\",'#1045#1082#1072#1090#1077#1088#1080#1085#1073#1091#1088#1075' \"'#1052#1077#1085#1086#1088#1072'\",'#1045#1074#1088#1077#1081#1089#1082#1080#1081' '#1041#1083 +
        #1072#1075#1086#1090#1074#1086#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1060#1086#1085#1076' '#1061#1077#1089#1077#1076' '#171#1054#1096#1077#1088#187' '#1057#1095#1072#1089#1090#1100#1077','#1044#1078#1086#1081#1085#1090' '#1058#1072#1096#1082#1077#1085#1090#39', NULL,' +
        ' '#39'0.00'#39', '#39'0.00'#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, NULL, NULL, '#39'1040,1311,1' +
        '566,1247,1117,1373,2201,2229,3062,1155,1374,2206,962,1485,2845,5' +
        '02,966,1455,2224,2507,2621,2724,2903,2966,533,2225,2508,2598,262' +
        '4,2739,2905,2921,724,1934,2299,2536,2601,2718,2741,2828,2910,292' +
        '2,875,1362,2061,2538,2613,2723,2841,2952,1274,1344,1495,1292,150' +
        '0,1304,1440,1258,1309,1492,2228,2402,2430,2517,2542,2589,2620,17' +
        '05,2207,2221,2237,2304,2425,2531,2545,2590,2036,2211,2226,2305,2' +
        '426,2509,2540,2088,2215,2267,2428,2510,2541,2587,2619,3069,3056,' +
        '3065,2847,2719,2851,2984,2720,2740,2934,3092,90003,3015,3035,307' +
        '0,3084,3039,3071,3087,2978,3030,3042,3073,3109,2994,3034,3100,66' +
        ',905,1261,2135,2317,1059,1275,1415,1980,2765,2968,3101,712,1226,' +
        '3104,130,1214,1398,2035,2147,2319,2557,604,1075,1680,2210,2781,3' +
        '024,483,1054,1228,1251,3088,1235,1544,2063,2172,2400,2602,769,12' +
        '11,1388,2314,2909,3091,3103,1113,1229,1256,15505,689,1254,2133,2' +
        '308,2409,841,1233,1392,1903,2514,2936,3093,3106,602,1176,1231,14' +
        '17,90002,90001'#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1089#1086#1094#1080#1072#1083#1100#1085#1099#1093' '#1087#1088#1086#1075#1088#1072#1084#1084' ('#1044#1078 +
        #1086#1081#1085#1090'), '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1087#1072#1090#1088#1086#1085#1072#1078#1072', '#1054#1087#1077#1088#1072#1090#1086#1088', '#1050#1086#1086#1088#1076#1080#1085#1072#1090#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085 +
        #1099#1093' '#1089#1080#1089#1090#1077#1084' ('#1044#1078#1086#1081#1085#1090')'#39', NULL, NULL, NULL, NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39#1053#1045#1042#1045#1056#1053#1054 +
        #39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39'--'#1053#1077' '#1091#1082#1072#1079#1072#1085#1086'--'#39', '#39#1053#1045 +
        #1042#1045#1056#1053#1054#39', NULL, NULL, '#39#1046#1077#1085#1089#1082#1080#1081#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39'Olga Shpakovskaya'#39', '#39 +
        #1053#1045#1042#1045#1056#1053#1054#39', '#39#1042#1045#1056#1053#1054#39', NULL), ('#39'0000207282'#39', '#39'Romaniuk Anastasiia'#39', ' +
        #39#1042#1086#1083#1086#1085#1090#1077#1088#39', 31, '#39'0.00'#39', NULL, '#39#1056#1086#1074#1085#1086#39', '#39#1061#1077#1089#1077#1076' '#1041#1077#1096#1090' - '#1061#1084#1077#1083#1100#1085#1080#1094#1082#1080#1081 +
        #39', NULL, '#39'0.00'#39', '#39'0.00'#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, NULL, '#39'097492587' +
        '3'#39', '#39'2541'#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39#1042#1086#1083#1086#1085#1090#1077#1088#39', NULL, NULL, NULL, NULL, '#39#1053#1045#1042#1045 +
        #1056#1053#1054#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, '#39'--'#1053#1077' '#1091 +
        #1082#1072#1079#1072#1085#1086'--'#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', NULL, NULL, '#39#1046#1077#1085#1089#1082#1080#1081#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39'Romaniu' +
        'k Anastasiia'#39', '#39#1053#1045#1042#1045#1056#1053#1054#39', '#39#1042#1045#1056#1053#1054#39', NULL);')
    SQLDelete.Strings = (
      '')
    Connection = UniConnection
    SQL.Strings = (
      'select * from Uchastniky')
    Left = 424
    Top = 128
  end
  object UniDataSource1: TUniDataSource
    DataSet = UniQuery1
    Left = 424
    Top = 184
  end
  object dsCurators: TDataSource
    DataSet = qCurators
    Left = 264
    Top = 168
  end
  object qCurators: TADOQuery
    Connection = myConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Curators'
      'where curActive = true'
      'and'
      'curFIO = '#39#1064#1086#1087#1085#1080#1082' '#1052#1072#1088#1075#1072#1088#1080#1090#1072' '#1040#1088#1086#1085#1086#1074#1085#1072#39)
    Left = 264
    Top = 120
  end
end
