unit uFrameAnalitic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameCustom,
  sFrameAdapter, sPanel, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,
  sMemo,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh;

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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AfterCreation; override; // Вызывается после создания frame

  end;

implementation

{$R *.dfm}

uses uMyProcedure, uDataModul, sStoreUtils, uMainForm;

procedure TfrmAnalitic.AfterCreation;
var
  s: String;
begin
  inherited;

  s := sStoreUtils.ReadIniString('NameRollOut', 'Uchastniky', IniName);
  if s <> '' then roUch.Caption := s;
  s := sStoreUtils.ReadIniString('NameRollOut', 'Household', IniName);
  if s <> '' then roHousehold.Caption := s;
  s := sStoreUtils.ReadIniString('NameRollOut', 'AdditData', IniName);
  if s <> '' then roAdditData.Caption := s;
  s := sStoreUtils.ReadIniString('NameRollOut', 'Vibivshie', IniName);
  if s <> '' then roVibivshie.Caption := s;

end;


procedure TfrmAnalitic.btnImportClick(Sender: TObject);
begin // відкриття панелі імпорта данних
  inherited;
  if splitView.Opened then
    splitView.Opened := false
  else
    splitView.Opened := True;
end;


procedure TfrmAnalitic.btnAdditDataClick(Sender: TObject);
begin  //  Загрузка доп данних учасників
  inherited;
    if ExportExcelToBDTable('AdditionalData', True, DM.tAdditData, memAdditData.Lines) = True
  then
  begin
    roAdditData.Caption := 'Імпорт додаткових параметрів ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'AdditData', roAdditData.Caption, IniName);
    ShowMessage('Імпорт завершено!');
  end
  else
    ShowMessage('Не вдала спроба імпорту');
end;

procedure TfrmAnalitic.btnCalckClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmAnalitic.btnDomgospClick(Sender: TObject);
begin // Загрузка данних про домогосподарства
  inherited;
    if ExportExcelToBDTable('Household', True, DM.tHousehold, memHousehold.Lines) = True
  then
  begin
    roHousehold.Caption := 'Імпорт домогосподарств ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Household', roHousehold.Caption, IniName);
    ShowMessage('Імпорт завершено!');
  end
  else
    ShowMessage('Не вдала спроба імпорту');
end;

procedure TfrmAnalitic.btnExportToExcelClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmAnalitic.btnUchClick(Sender: TObject);
begin // Загрузка данних про учасників
  inherited;
  if ExportExcelToBDTable('Uchastniky', True, DM.tUchastniky, memUch.Lines) = True
  then
  begin
    roUch.Caption := 'Імпорт учасників ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Uchastniky', roUch.Caption, IniName);
    ShowMessage('Імпорт завершено!');
  end
  else
    ShowMessage('Не вдала спроба імпорту');
end;

procedure TfrmAnalitic.btnVibivshieClick(Sender: TObject);
begin  //   Загрузка данних про вибивших клієнтів
  inherited;
  if ExportExcelToBDTable('Vibivshie', True, DM.tVibivshie, memVibivshie.Lines) = True
  then
  begin
    roVibivshie.Caption := 'Імпорт вибувших ' + DateToStr(Date);
    sStoreUtils.WriteIniStr('NameRollOut', 'Vibivshie', roVibivshie.Caption, IniName);
    ShowMessage('Імпорт завершено!');
  end
  else
    ShowMessage('Не вдала спроба імпорту');
end;

end.
