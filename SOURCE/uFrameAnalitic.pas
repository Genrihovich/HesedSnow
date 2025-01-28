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
    procedure AfterCreation; override; // Вызывается после создания frame
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
begin // відкриття панелі імпорта данних
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
begin // Загрузка доп данних учасників
  inherited;
  if ExportExcelToBDTable('AdditionalData', True, DM.tAdditData,
    memAdditData.Lines) = True then
  begin
    roAdditData.Caption := 'Імпорт додаткових параметрів ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'AdditData',
      roAdditData.Caption, IniName);
    ShowMessage('Імпорт завершено!');
    memAdditData.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) +
      '/AdditData.dat');
  end
  else
    ShowMessage('Не вдала спроба імпорту');
end;

procedure TfrmAnalitic.btnCalckClick(Sender: TObject);
var
  sqlText: String;
begin
  inherited;
  // очистить таблицу
  CleanOutTable('analiticAll');
  // DM.qAnaliticAll.Active := false;
  // ----------------------------- регионы ----------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count([Uchastniky].[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"")) ' +
      'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnalitic(sqlText, 'Проанкетовані') = false then
      ShowMessage('Нема данних або невірний запрос для Регіонів');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Регіони');
  end;

  { //   -------------------------------- ЖН ---------------------------------
    try
    sqlText := 'SELECT Uchastniky.Куратор, Count([Uchastniky].[Код организации]) AS [Count-ФИО] ' +
    'FROM Uchastniky ' +
    'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.ЖН)="ВЕРНО")) ' +
    'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'ЖН') = false then
    ShowMessage('Нема данних або невірний запрос для ЖН');
    except on E: Exception do ShowMessage('Помилка на блоці ЖН');
    end; }

  // -------------------------------- ЖН ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count([Uchastniky].[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.ЖН)="ВЕРНО")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'ЖН') = false then
      ShowMessage('Нема данних або невірний запрос для ЖН');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці ЖН');
  end;

  // -------------------------------- НЖН ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count([Uchastniky].[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.ЖН)="НЕВЕРНО")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'НЖН') = false then
      ShowMessage('Нема данних або невірний запрос для НЖН');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці НЖН');
  end;

  // -------------------------------- ВПО ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count([Uchastniky].[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.[Беженец/ВПЛ])="Кризис 2022")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'ВПО') = false then
      ShowMessage('Нема данних або невірний запрос для ВПО');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці ВПО');
  end;

  // -------------------------------- HH ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count([Uchastniky].[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.[Дополнительные параметры]) like"%Новые нуждающиеся%")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'НН') = false then
      ShowMessage('Нема данних або невірний запрос для НН');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці НН');
  end;

  // ------------------------------ КЛІЕНТ ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)]) Like "%Клиент Хеседа%")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'Клієнти') = false then
      ShowMessage('Нема данних або невірний запрос для Клієнти');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Клієнти');
  end;

  // -------------------------------- діти 0-17 ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count([Uchastniky].[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.Возраст) Between 0 And 17)) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'діти 0-17') = false then
      ShowMessage('Нема данних або невірний запрос для діти 0-17');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці діти 0-17');
  end;

  // ------------------------------ CI ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)]) Like "%CI%")) ' +
      'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'CI') = false then
      ShowMessage('Нема данних або невірний запрос для CI');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці CI');
  end;

  // ------------------------------ Інвалідність----------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.Инвалидность)="Да")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'Інвалидность') = false then
      ShowMessage('Нема данних або невірний запрос для Інвалідність');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Інвалідність');
  end;

  // ------------------------------ Національність --------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.[Еврейское происхождение])="Да")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'Єврей') = false then
      ShowMessage('Нема данних або невірний запрос для Національність');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Національність');
  end;

  // ------------------------------ Патронажні ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)]) Like "%Патронажный работник%")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'Патронажні') = false then
      ShowMessage('Нема данних або невірний запрос для Патронажні');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Патронажні');
  end;

  // ------------------------------ Співробітники ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"" ' +
      'And (Uchastniky.[Тип клиента (для поиска)]) Like "%Сотр%" ' +
      'Or (Uchastniky.[Тип клиента (для поиска)]) Like "%Кура%" ' +
      'Or (Uchastniky.[Тип клиента (для поиска)]) Like "%Дирек%" ' +
      'Or (Uchastniky.[Тип клиента (для поиска)]) Like "%кейс%" ' +
      'Or (Uchastniky.[Тип клиента (для поиска)]) Like "%Бухг%")) ' +
      'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'Співробітники') = false then
      ShowMessage('Нема данних або невірний запрос для Співробітники');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Співробітники');
  end;

  // ------------------------------ Чол ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.Пол)="Мужской")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'Чол') = false then
      ShowMessage('Нема данних або невірний запрос для Чол пол');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Чол пол');
  end;

  // ------------------------------ Жін ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.Пол)="Женский")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'Жін') = false then
      ShowMessage('Нема данних або невірний запрос для Жін пол');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Жін пол');
  end;

  // ------------------------------ 66-75 ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.Возраст) Between 66 And 75)) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, '66-75') = false then
      ShowMessage('Нема данних або невірний запрос для 66-75');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці 66-75');
  end;

  // ------------------------------ 76-85 ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.Возраст) Between 76 And 85)) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, '76-85') = false then
      ShowMessage('Нема данних або невірний запрос для 76-85');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці 76-85');
  end;

  // ------------------------------ 86+ ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.Возраст) Between 86 And 185)) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, '86+') = false then
      ShowMessage('Нема данних або невірний запрос для 86+');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці 86+');
  end;

  // ------------------------------ волонтери ------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count(Uchastniky.[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)]) Like "%Волонтер%")) ' +
      'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'волонтери') = false then
      ShowMessage('Нема данних або невірний запрос для волонтери');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці волонтери');
  end;

  // -------------------------------- Получають патронаж ---------------------------------
  try
    sqlText :=
      'SELECT Uchastniky.Куратор, Count([Uchastniky].[Код организации JDC]) AS [Count-ФИО] '
      + 'FROM Uchastniky ' +
      'WHERE (((Uchastniky.[Тип клиента (для поиска)])<>"") AND ((Uchastniky.[Получает патронаж])="верно")) '
      + 'GROUP BY Uchastniky.Куратор;';

    if InsertDataAnaliticAll(sqlText, 'Получають патронаж') = false then
      ShowMessage('Нема данних або невірний запрос для Получають патронаж');
  except
    on E: Exception do
      ShowMessage('Помилка на блоці Получають патронаж');
  end;

  DM.qAnaliticAll.Active := True;
end;

procedure TfrmAnalitic.btnDomgospClick(Sender: TObject);
begin // Загрузка данних про домогосподарства
  inherited;
  if ExportExcelToBDTable('Household', True, DM.tHousehold, memHousehold.Lines)
    = True then
  begin
    roHousehold.Caption := 'Імпорт домогосподарств ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Household',
      roHousehold.Caption, IniName);
    ShowMessage('Імпорт завершено!');
    memHousehold.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) +
      '/Household.dat');
  end
  else
    ShowMessage('Не вдала спроба імпорту');
end;

procedure TfrmAnalitic.btnExportToExcelClick(Sender: TObject);
begin
  inherited;
  if SaveExcelFromGrid(DBGridEh1) = True then
    ShowMessage('Дані вигружені у файл');
  // SaveDBGridEhToExportFile(TDBGridEhExportAsOLEXLS, DBGridEh1, 'C:\1.xls', TRUE);

end;

procedure TfrmAnalitic.btnUchClick(Sender: TObject);
begin // Загрузка данних про учасників
  inherited;
  if ExportExcelToBDTable('Uchastniky', True, DM.tUchastniky, memUch.Lines) = True
  then
  begin
    roUch.Caption := 'Імпорт учасників ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Uchastniky', roUch.Caption,
      IniName);
    ShowMessage('Імпорт завершено!');
    memUch.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + '/Uchastniky.dat');
  end
  else
    ShowMessage('Не вдала спроба імпорту');
end;

procedure TfrmAnalitic.btnVibivshieClick(Sender: TObject);
begin // Загрузка данних про вибивших клієнтів
  inherited;
  if ExportExcelToBDTable('Vibivshie', True, DM.tVibivshie, memVibivshie.Lines)
    = True then
  begin
    roVibivshie.Caption := 'Імпорт вибувших ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Vibivshie',
      roVibivshie.Caption, IniName);
    ShowMessage('Імпорт завершено!');
    memVibivshie.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) +
      '/Vibivshie.dat');
  end
  else
    ShowMessage('Не вдала спроба імпорту');
end;

procedure TfrmAnalitic.panTopDblClick(Sender: TObject);
begin
  inherited;
  DM.qAnaliticAll.Active := True;
end;

end.
