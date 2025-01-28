unit uDataModul;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, DBAccess, Uni,
  UniProvider, MySQLUniProvider, MemDS, Vcl.Dialogs;

  { System.Actions,
  Vcl.ActnList, IDETheme.ActnCtrls, Vcl.ActnMan;}

type
  TDM = class(TDataModule)
    tVedomost: TADOTable;
    myConnection: TADOConnection;
    dsVedomist: TDataSource;
    qQuery: TADOQuery;
    tPodopechnie: TADOTable;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    tUslugy: TADOTable;
    dsUslugy: TDataSource;
    qUslugy: TADOQuery;
    dsQslg: TDataSource;
    qQslg: TADOQuery;
    tSLG: TADOTable;
    tSLGName_SLG: TWideStringField;
    tSLGActive: TBooleanField;
    tSLGPrice_inch: TBCDField;
    tSLGupakovka: TIntegerField;
    tUslusgyDavayPodkl: TADOTable;
    tTemaDavayPodkl: TADOTable;
    dsTemaDP: TDataSource;
    tTemaDavayPodklData: TWideStringField;
    tTemaDavayPodklTema: TWideStringField;
    qTemaDP: TADOQuery;
    UniTable1: TUniTable;
    tSLGKategorya: TWideStringField;
    tZahody: TADOTable;
    qZahody: TADOQuery;
    tCurators: TADOTable;
    tBK: TADOTable;
    tBankStatement: TADOTable;
    tBankErrors: TADOTable;
    dsBankErrors: TDataSource;
    dsBankStatementTemp: TDataSource;
    qBS: TADOQuery;
    tBankStatementTemp: TADOTable;
    dsBS: TDataSource;
    qbank_statement_Temp: TADOQuery;
    qQslgName_SLG: TWideStringField;
    qQslgActive: TBooleanField;
    qQslgPrice_inch: TBCDField;
    qQslgupakovka: TIntegerField;
    qQslgKategorya: TWideStringField;
    tUchastniky: TADOTable;
    qUchastniky: TADOQuery;
    dsUchastniky: TDataSource;
    OpenDialog: TOpenDialog;
    tHousehold: TADOTable;
    tAdditData: TADOTable;
    tVibivshie: TADOTable;
    qAnaliticAll: TADOQuery;
    tAnaliticAll: TADOTable;
    dsAnaliticAll: TDataSource;
    MySQLUniProvider: TMySQLUniProvider;
    UniConnection: TUniConnection;
    UniQuery1: TUniQuery;
    UniDataSource1: TUniDataSource;
    dsCurators: TDataSource;
    qCurators: TADOQuery;
    tVidDohod: TADOTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses  sStoreUtils, uMainForm, uFrameVidomist;

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
w:string;
begin
 w := sStoreUtils.ReadIniString('path', 'ProgramDirectory', myForm.JvAppIniFileStorage1.FileName);
   if w = '' then w := ExtractFilePath(ParamStr(0));

 myConnection.Connected := False;
 myConnection.Provider := 'Microsoft.Jet.OLEDB.4.0';
 myConnection.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ w + '\Snow.mdb;Persist Security Info=False;';
 myConnection.LoginPrompt := False;
 myConnection.Connected;
end;

end.
