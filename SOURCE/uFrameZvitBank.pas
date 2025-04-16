unit uFrameZvitBank;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameCustom,
  Vcl.ExtCtrls, sPanel, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, sFrameAdapter,
  sButton, Data.DB, Vcl.Grids, Vcl.DBGrids, acDBGrid, sLabel;

type
  TfrmZvitBank = class(TCustomInfoFrame)
    sPanel1: TsPanel;
    btnImportCards: TsBitBtn;
    btnImportZvitBank: TsBitBtn;
    btnImportError: TsBitBtn;
    sPanel2: TsPanel;
    btnDownload: TsButton;
    Splitter1: TSplitter;
    dbGridTemp: TsDBGrid;
    dbGridErrors: TsDBGrid;
    sPanel3: TsPanel;
    dbgQuery: TsDBGrid;
    Splitter2: TSplitter;
    lbCount: TsLabel;
    lbCountError: TsLabel;
    btnEdit: TsBitBtn;
    btnSaveFile: TsBitBtn;
    procedure btnImportCardsClick(Sender: TObject);
    procedure btnImportZvitBankClick(Sender: TObject);
    procedure btnImportErrorClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure dbGridTempDblClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure dbgQueryDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnSaveFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uMyProcedure, uDataModul, uBDlogic, uMainForm;

{ ------------------ ������ ����� � ������� ����������� ----------------------
  ���� ������� BK:
  JDC ID, ��� ��������� �����, INN, ����� �����, ���� ������ ��������, ���� ���������,
  ���� ��������� �������� �����, �������������
}

procedure TfrmZvitBank.btnImportCardsClick(Sender: TObject);
var
  myPole: TStringList;
begin
  myPole := nil;
  try
    begin
      // ������� ������ �����
      myPole := TStringList.Create;

      myPole.CommaText :=
        '"JDC ID", "��� ��������� �����", INN, "����� �����", "���� ������ ��������", "���� ���������", "���� ��������� �������� �����", �������������';

      ImportExcelIntoBD('BK', DM.tBK, myPole, Nil);

    end;
  finally
    begin
      myPole.Free;
    end;

  end;
end;

procedure TfrmZvitBank.btnImportErrorClick(Sender: TObject);
var
  myPole: TStringList;
begin
  // ������� ������ �����
  myPole := TStringList.Create;
  myPole.CommaText := 'p_errors, p_column';
  ImportExcelIntoBD('bank_errors', DM.tBankErrors, myPole, Nil);
  myPole.Free;
end;

procedure TfrmZvitBank.btnImportZvitBankClick(Sender: TObject);
var
  propAlterClean: TStringList;
begin
  propAlterClean := TStringList.Create;
  // Number - ����-�������, 0 - ��������� ����� 2-������ ��� ����� � 1 ������
  propAlterClean.CommaText := 'NumCount, 2';
  ImportExcelIntoBD('bank_statement', DM.tBankStatement, Nil, propAlterClean);
  propAlterClean.Free;
end;

// �������� ������ � �������
procedure TfrmZvitBank.btnDownloadClick(Sender: TObject);
var
  s: string;
  i: Integer;
begin
  with DM do
  begin
    tBankErrors.Open;
    tBankStatementTemp.Open;

    CleanOutTable('bank_statement_Temp');
    s := '';

    tBankErrors.First;
    for i := 0 to tBankErrors.RecordCount - 1 do
    begin
      // ������� ������� � ����� ��� ������� (1,203 = 1203)
      s := DelSymbolIntoString(tBankErrors.FieldByName('p_column')
        .AsString, ',');

      // ��������� �� ��������� ������� ������ � ��������
      InsertCustomRowIntoNewTable(s, 'bank_statement', 'bank_statement_Temp');
      tBankErrors.Next;
    end;
    tBankErrors.First;
    lbCountError.Caption := lbCountError.Caption + ' ' +
      tBankErrors.RecordCount.ToString;
    lbCount.Caption := lbCount.Caption + ' ' +
      tBankStatementTemp.RecordCount.ToString;
    dbGridErrors.DataSource := DM.dsBankErrors;
    qbank_statement_Temp.Active := false;
    qbank_statement_Temp.Active := true;
  end;

end;

procedure TfrmZvitBank.dbGridTempDblClick(Sender: TObject);
var
  val: String;
begin
  val := dbGridTemp.DataSource.DataSet.FieldByName('rep_inn').AsString;

  with DM.qBS do
  begin
    Active := false;
    Close;
    SQL.Clear;
    SQL.Add('SELECT * From BK Where (((BK.[INN]) = "' + val + '"))');
    Active := true;
  end;
  dbgQuery.DataSource := DM.dsBS;
end;

// ����������
procedure TfrmZvitBank.dbgQueryDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.Field.DataSet.FieldByName('�������������').AsString = '�������' Then
  begin
    dbgQuery.Canvas.Brush.Color := clBtnShadow;
    dbgQuery.Canvas.Font.Color := clGrayText;
  end;
  dbgQuery.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

// ��������
procedure TfrmZvitBank.btnEditClick(Sender: TObject);
begin
  inherited;
  //
end;

// ��������� � ����
procedure TfrmZvitBank.btnSaveFileClick(Sender: TObject);
begin
  inherited;
  //
end;

end.
