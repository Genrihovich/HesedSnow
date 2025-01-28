unit uFrameAnalitic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameCustom,
  sFrameAdapter, sPanel, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,
  sMemo,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh, Data.DB, Vcl.Grids, Vcl.DBGrids, acDBGrid,
  DBGridEhImpExp;

type
  TfrmAnalitic = class(TCustomInfoFrame)
    panTop: TsPanel;
    btnExportToExcel: TsBitBtn;
    splitView: TsSplitView;
    roUch: TsRollOutPanel;
    btnUch: TsBitBtn;
    roHousehold: TsRollOutPanel;
    btnDomgosp: TsBitBtn;
    roAdditData: TsRollOutPanel;
    roVibivshie: TsRollOutPanel;
    btnVibivshie: TsBitBtn;
    memVibivshie: TsMemo;
    btnImport: TBitBtn;
    memHousehold: TsMemo;
    btnAdditData: TsBitBtn;
    memAdditData: TsMemo;
    panAll: TsPanel;
    DBGridEh1: TDBGridEh;
    memUch: TsMemo;
    procedure btnImportClick(Sender: TObject);
    // procedure btnCalckClikClick(Sender: TObject);
    procedure btnExportToExcelClick(Sender: TObject);
    procedure btnUchClick(Sender: TObject);
    procedure btnDomgospClick(Sender: TObject);
    procedure btnAdditDataClick(Sender: TObject);
    procedure btnVibivshieClick(Sender: TObject);
    procedure btnCalckClick(Sender: TObject);
    procedure panTopDblClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure AfterCreation; override; // ���������� ����� �������� frame
    procedure BeforeDestruct; virtual;

  end;

implementation

{$R *.dfm}

uses uMyProcedure, uDataModul, sStoreUtils, uMainForm;

procedure TfrmAnalitic.BeforeDestruct;
begin
  DM.qAnaliticAll.Close;
  DM.tAnaliticAll.Close;
end;

procedure TfrmAnalitic.AfterCreation;
var
  s: String;
begin
  inherited;
  myForm.statusBar.Panels[1].Text := '0';

  s := sStoreUtils.ReadIniString('NameRollOut', 'Uchastniky', IniName);
  if s <> '' then
    roUch.Caption := s;
  s := sStoreUtils.ReadIniString('NameRollOut', 'Household', IniName);
  if s <> '' then
    roHousehold.Caption := s;
  s := sStoreUtils.ReadIniString('NameRollOut', 'AdditData', IniName);
  if s <> '' then
    roAdditData.Caption := s;
  s := sStoreUtils.ReadIniString('NameRollOut', 'Vibivshie', IniName);
  if s <> '' then
    roVibivshie.Caption := s;

end;

procedure TfrmAnalitic.btnImportClick(Sender: TObject);
begin // �������� ����� ������� ������
  inherited;
  if splitView.Opened then
    splitView.Opened := false
  else
  begin
    splitView.Opened := True;
    memUch.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + '/Uchastniky.dat');
    memVibivshie.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      '/Vibivshie.dat');
    memHousehold.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      '/Household.dat');
    memAdditData.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) +
      '/AdditData.dat');
  end;
end;

procedure TfrmAnalitic.btnAdditDataClick(Sender: TObject);
begin // �������� ��� ������ ��������
  inherited;
  if ExportExcelToBDTable('AdditionalData', True, DM.tAdditData,
    memAdditData.Lines) = True then
  begin
    roAdditData.Caption := '������ ���������� ��������� ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'AdditData',
      roAdditData.Caption, IniName);
    ShowMessage('������ ���������!');
    memAdditData.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) +
      '/AdditData.dat');
  end
  else
    ShowMessage('�� ����� ������ �������');
end;

procedure TfrmAnalitic.btnCalckClick(Sender: TObject);
var
  sqlText: String;
begin
  inherited;
  // �������� �������
  CleanOutTable('analiticAll');
  // DM.qAnaliticAll.Active := false;
  // ----------------------------- ������� ----------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count([Uchastniky].[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"")) ' +
      'GROUP BY Uchastniky.�������;';

    if InsertDataAnalitic(sqlText, '������������') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ������');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ������');
  end;

  { //   -------------------------------- �� ---------------------------------
    try
    sqlText := 'SELECT Uchastniky.�������, Count([Uchastniky].[��� �����������]) AS [Count-���] ' +
    'FROM Uchastniky ' +
    'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.��)="�����")) ' +
    'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '��') = false then
    ShowMessage('���� ������ ��� ������� ������ ��� ��');
    except on E: Exception do ShowMessage('������� �� ����� ��');
    end; }

  // -------------------------------- �� ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count([Uchastniky].[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.��)="�����")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '��') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ��');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ��');
  end;

  // -------------------------------- ��� ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count([Uchastniky].[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.��)="�������")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '���') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ���');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ���');
  end;

  // -------------------------------- ��� ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count([Uchastniky].[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.[�������/���])="������ 2022")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '���') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ���');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ���');
  end;

  // -------------------------------- HH ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count([Uchastniky].[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.[�������������� ���������]) like"%����� �����������%")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '��') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ��');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ��');
  end;

  // ------------------------------ �˲��� ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)]) Like "%������ ������%")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '�볺���') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� �볺���');
  except
    on E: Exception do
      ShowMessage('������� �� ����� �볺���');
  end;

  // -------------------------------- ��� 0-17 ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count([Uchastniky].[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.�������) Between 0 And 17)) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '��� 0-17') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ��� 0-17');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ��� 0-17');
  end;

  // ------------------------------ CI ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)]) Like "%CI%")) ' +
      'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, 'CI') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� CI');
  except
    on E: Exception do
      ShowMessage('������� �� ����� CI');
  end;

  // ------------------------------ ����������----------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.������������)="��")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '������������') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ����������');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ����������');
  end;

  // ------------------------------ ������������� --------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.[��������� �������������])="��")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '�����') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� �������������');
  except
    on E: Exception do
      ShowMessage('������� �� ����� �������������');
  end;

  // ------------------------------ ��������� ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)]) Like "%����������� ��������%")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '���������') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ���������');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ���������');
  end;

  // ------------------------------ ����������� ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"" ' +
      'And (Uchastniky.[��� ������� (��� ������)]) Like "%����%" ' +
      'Or (Uchastniky.[��� ������� (��� ������)]) Like "%����%" ' +
      'Or (Uchastniky.[��� ������� (��� ������)]) Like "%�����%" ' +
      'Or (Uchastniky.[��� ������� (��� ������)]) Like "%����%" ' +
      'Or (Uchastniky.[��� ������� (��� ������)]) Like "%����%")) ' +
      'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '�����������') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� �����������');
  except
    on E: Exception do
      ShowMessage('������� �� ����� �����������');
  end;

  // ------------------------------ ��� ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.���)="�������")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '���') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ��� ���');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ��� ���');
  end;

  // ------------------------------ Ƴ� ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.���)="�������")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, 'Ƴ�') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� Ƴ� ���');
  except
    on E: Exception do
      ShowMessage('������� �� ����� Ƴ� ���');
  end;

  // ------------------------------ 66-75 ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.�������) Between 66 And 75)) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '66-75') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� 66-75');
  except
    on E: Exception do
      ShowMessage('������� �� ����� 66-75');
  end;

  // ------------------------------ 76-85 ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.�������) Between 76 And 85)) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '76-85') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� 76-85');
  except
    on E: Exception do
      ShowMessage('������� �� ����� 76-85');
  end;

  // ------------------------------ 86+ ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.�������) Between 86 And 185)) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '86+') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� 86+');
  except
    on E: Exception do
      ShowMessage('������� �� ����� 86+');
  end;

  // ------------------------------ ��������� ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count(Uchastniky.[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)]) Like "%��������%")) ' +
      'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '���������') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ���������');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ���������');
  end;

  // -------------------------------- ��������� �������� ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.�������, Count([Uchastniky].[��� ����������� JDC]) AS [Count-���] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[��� ������� (��� ������)])<>"") AND ((Uchastniky.[�������� ��������])="�����")) '
      + 'GROUP BY Uchastniky.�������;';

    if InsertDataAnaliticAll(sqlText, '��������� ��������') = false then
      ShowMessage('���� ������ ��� ������� ������ ��� ��������� ��������');
  except
    on E: Exception do
      ShowMessage('������� �� ����� ��������� ��������');
  end;

  DM.qAnaliticAll.Active := True;
end;

procedure TfrmAnalitic.btnDomgospClick(Sender: TObject);
begin // �������� ������ ��� ����������������
  inherited;
  if ExportExcelToBDTable('Household', True, DM.tHousehold, memHousehold.Lines)
    = True then
  begin
    roHousehold.Caption := '������ ��������������� ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Household',
      roHousehold.Caption, IniName);
    ShowMessage('������ ���������!');
    memHousehold.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) +
      '/Household.dat');
  end
  else
    ShowMessage('�� ����� ������ �������');
end;

procedure TfrmAnalitic.btnExportToExcelClick(Sender: TObject);
begin
  inherited;
  if SaveExcelFromGrid(DBGridEh1) = True then
    ShowMessage('��� �������� � ����');
  // SaveDBGridEhToExportFile(TDBGridEhExportAsOLEXLS, DBGridEh1, 'C:\1.xls', TRUE);

end;

procedure TfrmAnalitic.btnUchClick(Sender: TObject);
begin // �������� ������ ��� ��������
  inherited;
  if ExportExcelToBDTable('Uchastniky', True, DM.tUchastniky, memUch.Lines) = True
  then
  begin
    roUch.Caption := '������ �������� ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Uchastniky', roUch.Caption,
      IniName);
    ShowMessage('������ ���������!');
    memUch.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + '/Uchastniky.dat');
  end
  else
    ShowMessage('�� ����� ������ �������');
end;

procedure TfrmAnalitic.btnVibivshieClick(Sender: TObject);
begin // �������� ������ ��� �������� �볺���
  inherited;
  if ExportExcelToBDTable('Vibivshie', True, DM.tVibivshie, memVibivshie.Lines)
    = True then
  begin
    roVibivshie.Caption := '������ �������� ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Vibivshie',
      roVibivshie.Caption, IniName);
    ShowMessage('������ ���������!');
    memVibivshie.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) +
      '/Vibivshie.dat');
  end
  else
    ShowMessage('�� ����� ������ �������');
end;

procedure TfrmAnalitic.panTopDblClick(Sender: TObject);
begin
  inherited;
  DM.qAnaliticAll.Active := True;
end;

end.
