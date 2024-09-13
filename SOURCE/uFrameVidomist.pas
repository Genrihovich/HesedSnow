unit uFrameVidomist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, ShellAPI,
  uFrameCustom, System.Generics.Collections,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, sPanel, Vcl.ExtCtrls, sFrameAdapter, Vcl.StdCtrls,
  sButton, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh,
  EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, sLabel, Vcl.Mask, DBCtrlsEh,
  System.Actions, Vcl.ActnList, Vcl.Buttons, sBitBtn, sCheckBox, JvExExtCtrls,
  JvExtComponent, JvRollOut, sEdit, sScrollBox;
  var
  VedomistFileName: String;
type
  TfrmVidomost = class(TCustomInfoFrame)
    sGradientPanel1: TsGradientPanel;
    sButton1: TsButton;
    OpenDialog: TOpenDialog;
    labInfoStatus: TsLabelFX;
    actionList: TActionList;
    acbtnCreateVidomist: TAction;
    chbPrint: TsCheckBox;
    sbCheckCurators: TsScrollBox;
    sPanel1: TsPanel;
    DBGridEhVedomist: TDBGridEh;
    sPanel2: TsPanel;
    sLabelFX1: TsLabelFX;
    btnCreateVidomist: TsButton;
    cbVidomist: TDBComboBoxEh;
    JvRollOut1: TJvRollOut;
    sLabelFX2: TsLabelFX;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    sLabel4: TsLabel;
    seLogin: TsEdit;
    seHost: TsEdit;
    sePort: TsEdit;
    sePsw: TsEdit;
    sButton2: TsButton;
    sPanel3: TsPanel;
    sPanel4: TsPanel;
    procedure sButton1Click(Sender: TObject);
    procedure btnCreateVidomistClick(Sender: TObject);
    procedure acbtnCreateVidomistUpdate(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AfterCreation; override;
    procedure BeforeDestruct; override;

  end;

implementation

{$R *.dfm}

uses uMyProcedure, uMyExcel, uDataModul, uMainForm, uBDlogic;

procedure TfrmVidomost.acbtnCreateVidomistUpdate(Sender: TObject);
begin
  inherited;
  if cbVidomist.Text.IsEmpty then
    btnCreateVidomist.Enabled := false
  else
    btnCreateVidomist.Enabled := true;
end;

procedure TfrmVidomost.AfterCreation;
begin
  inherited;
  DM.tVedomost.Open; //
  labInfoStatus.Caption := 'Завантажте дані для формування відомості';

  if FileExists(ExtractFilePath(ParamStr(0)) + 'items.dat') Then
  begin // да
    cbVidomist.Items.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'items.dat');
  end;
end;

procedure TfrmVidomost.BeforeDestruct;
begin
  inherited;
  // надо сделать уничтожение фреймов, выгрузку из памяти
  cbVidomist.Items.SaveToFile(ExtractFilePath(ParamStr(0)) + 'items.dat');
end;

procedure TfrmVidomost.btnCreateVidomistClick(Sender: TObject);
var
  i: integer;
  _step: integer;
  Kurators: TStringList;
  DirectoryNow: String;

begin
  inherited;
  //Проверить или есть уже созданные чекбоксы кураторов, если есть то удалить
 if sbCheckCurators.ControlCount > 0 then sbCheckCurators.DestroyComponents;

  // если название Ведомости новое то добавить в историю Названий
  if not uMyProcedure.isStringAssign(cbVidomist.Text, cbVidomist.Items) then
  begin
    cbVidomist.Items.Add(cbVidomist.Text);
    cbVidomist.Items.SaveToFile(ExtractFilePath(ParamStr(0)) + 'items.dat');
  end;
  labInfoStatus.Shadow.Color := clBlue;
  labInfoStatus.Caption := 'Створюємо списки кураторів';
  myForm.ProgressBar.Visible := true;
  myForm.ProgressBar.Min := 0;
  myForm.ProgressBar.Max := 100;
  myForm.ProgressBar.Position := 1;

  // 1 делаем список кураторов у данной ведомости
  Kurators := TStringList.Create;
  Kurators := CuratorsList('Vidomist', 'Curator');
  myForm.ProgressBar.Position := 10;

  DirectoryNow := ExtractFilePath(ParamStr(0)) + 'Данные\Ведомости\';
  if not DirectoryExists('DirectoryNow') then
    ForceDirectories(DirectoryNow);

  // 2 создаем папку для данной ведомости
  DirectoryNow := DirectoryNow + cbVidomist.Text + ' ' +
    FormatDateTime('mmmm yyyy', Now);

  if DirectoryExists(DirectoryNow) then
  begin
    DirectoryNow := DirectoryNow + '\';
  end
  else
  begin
    ForceDirectories(DirectoryNow);
    DirectoryNow := DirectoryNow + '\';
  end;

  myForm.ProgressBar.Position := 20;
  _step := Trunc((myForm.ProgressBar.Max - myForm.ProgressBar.Position) /
    Kurators.Count);

  // 3 для каждого куратора создаем файл с данными
  for i := 0 to Kurators.Count - 1 do
  begin
  // проверка  печать ли выбрана
    labInfoStatus.Caption := 'Обробка даних по куратору: ' +
      Kurators.Strings[i];

    ExportExcel(Kurators.Strings[i], DirectoryNow, cbVidomist.Text, chbPrint.Checked);

    myForm.ProgressBar.Position := myForm.ProgressBar.Position + _step;
     // создать куратору и его мылу чекбокс и записать путь к файлу и имя
     CreateCheckBoxCurators(Kurators.Strings[i], sbCheckCurators, VedomistFileName, i);

  end;

  // 4 отправляем файл на почту для каждого куратора
  // 5 или печатаем файл на бумаге

  labInfoStatus.Shadow.Color := clGreen;
  labInfoStatus.Caption := 'Створення відомісті УСПІШНО!!!';
  myForm.ProgressBar.Visible := false;
  Kurators.Free;
  // открываем папку с ведомостями
  ShellExecute(Handle, 'open', PWideChar(DirectoryNow), nil, nil,
    SW_SHOWNORMAL);
end;

procedure TfrmVidomost.sButton1Click(Sender: TObject);
begin
  inherited;
  labInfoStatus.Caption := 'Завантажте дані для формування відомості';
  // ImportExcel;
  ImportExcelToBD;
  DM.tVedomost.Active := true;
  DBGridEhVedomist.DataSource := DM.dsVedomist;
  labInfoStatus.Shadow.Color := clGreen;
  labInfoStatus.Caption := 'Завантаження даних УСПІШНО!!!';
  ShowMessage('Завантаження даних УСПІШНО!!!');
end;

procedure TfrmVidomost.sButton2Click(Sender: TObject);
var
i, j, k, myTag: integer;
nFIO, nMail, nFileNamePath: string;
begin
  inherited;
  // поиск фио куратора
  for i := 0 to sbCheckCurators.ControlCount - 1 do
  begin
    if(sbCheckCurators.Controls[i] is TsCheckBox) then
    begin
      if (sbCheckCurators.Controls[i] as TsCheckBox).Checked then
        begin
         nFIO := (sbCheckCurators.Controls[i] as TsCheckBox).Caption;
         myTag := (sbCheckCurators.Controls[i] as TsCheckBox).Tag;
         // посик мыла
         for j := 0 to sbCheckCurators.ControlCount - 1 do
         begin
          if(sbCheckCurators.Controls[j] is TLabeledEdit) then
           if (sbCheckCurators.Controls[j] as TLabeledEdit).Name = 'MyDynLabelEdit'+inttostr(myTag) then
           begin
             nMail := (sbCheckCurators.Controls[j] as TLabeledEdit).text;
             // поиск пути к файлу
             for k := 0 to sbCheckCurators.ControlCount - 1 do
             begin
              if(sbCheckCurators.Controls[k] is TsLabel) then
               if (sbCheckCurators.Controls[k] as TsLabel).Name = 'MyDynLabel'+inttostr(myTag) then
               begin
                 nFileNamePath := (sbCheckCurators.Controls[k] as TsLabel).Caption;
                 break;
               end;
             end;

             break;
           end;
         end;
        // отправить письмо
        if SendEmailAndAttach(seHost.Text,     // хост
                            cbVidomist.Text, // тема письма
                            '"' + nFIO + '" <' + nMail + '>', //получатель
                            '"Интек" <' + seLogin.Text + '>', //откуда
                            cbVidomist.Text,
                            '',               //Тело письма в HTML
                            seLogin.Text,     //логин
                            sePsw.Text,       //пароль
                            nFileNamePath    // путь к файлу
                            ) then
          begin
           ShowMessage('Відомість для '+nFIO+' Відправлена!!!');
          end
          else
          begin
           ShowMessage('Відомість для '+nFIO+' НЕ відправлена!!!');
          end;
        end;
    end;
  end;
end;

end.
