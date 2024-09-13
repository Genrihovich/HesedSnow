unit uDohod;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uFrameCustom, uPdfiumIntf,
  sFrameAdapter, Vcl.ComCtrls, sMemo, Vcl.Buttons, sBitBtn, Vcl.Grids,
  JvExGrids, JvStringGrid, Data.DB, Vcl.DBGrids, sRichEdit,
  JvExForms, JvScrollBox, Vcl.Mask, sMaskEdit, sCustomComboEdit,
  sToolEdit, Vcl.ToolWin, System.ImageList, Vcl.ImgList, sListView,
  acShellCtrls,
  JvComponentBase, JvFormPlacement, JvAppStorage, JvAppIniStorage, Vcl.ExtCtrls,
  sPanel, Winapi.ShlObj, cxShellCommon, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters, cxContainer,
  cxEdit, cxListView, cxShellListView, ShellAPI;

type
  TfrmDohod = class(TCustomInfoFrame)
    sBitBtn1: TsBitBtn;
    mInSpisok: TsMemo;
    txtOutput: TsRichEdit;
    ImageList1: TImageList;
    OpenDialog: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PrintDialog: TPrintDialog;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    tbtnOpenFile: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    deInput: TsDirectoryEdit;
    ScrollBox: TJvScrollBox;
    deOutput: TsDirectoryEdit;
    mOutSpisok: TsRichEdit;
    pLeft: TPanel;
    pLeftTop: TPanel;
    pLeftButtom: TPanel;
    pRight: TPanel;
    pRightBottom2: TsPanel;
    btnAnaliz: TButton;
    ToolButton1: TToolButton;
    ToolButton17: TToolButton;
    lvOutput: TcxShellListView;
    lvInput: TcxShellListView;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    btnCreateExcel: TsBitBtn;
    FlowPanel1: TFlowPanel;
    sBitBtn2: TsBitBtn;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    procedure sBitBtn1Click(Sender: TObject);
    procedure tbtnOpenFileClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure deInputChange(Sender: TObject);
    procedure deOutputChange(Sender: TObject);
    procedure btnAnalizClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure lvOutputChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure lvInputChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ToolButton18Click(Sender: TObject);
    procedure btnCreateExcelClick(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    PdfView: TPdfView;
    FileNameTXT: String;
    procedure AddColoredLine(ARichEdit: TRichEdit; AText: string;
      AColor: TColor);

  public
    { Public declarations }
    procedure AfterCreation; override; // Вызывается после создания frame
    procedure BeforeDestruct; override;
  end;

implementation

{$R *.dfm}

uses uMyProcedure, uDataModul, sStoreUtils, uMainForm, uMyExcel;

procedure TfrmDohod.AddColoredLine(ARichEdit: TRichEdit; AText: string;
  AColor: TColor);
begin
  with ARichEdit do
  begin
    SelStart := Length(Text);
    SelAttributes.Color := AColor;
    SelAttributes.Size := 8;
    SelAttributes.Name := 'MS Sans Serif';
    Lines.Add(AText);
  end;
end;

procedure TfrmDohod.AfterCreation;
var
  s: String;
begin
  inherited;
  PdfView := TPdfView.Create(nil);
  PdfView.Parent := ScrollBox;
  ScrollBox.DoubleBuffered := false;

  s := sStoreUtils.ReadIniString('Path', 'InputPath', IniName);
  if s <> '' then
    deInput.Text := s;
  lvInput.root.CustomPath := deInput.Text;

  s := sStoreUtils.ReadIniString('Path', 'OutputPath', IniName);
  if s <> '' then deOutput.Text := s;
    lvOutput.root.CustomPath := deOutput.Text;
end;

procedure TfrmDohod.BeforeDestruct;
begin
  inherited;
  PdfView.ClosePdfFile;
  sStoreUtils.WriteIniStr('Path', 'InputPath', deInput.Text, IniName);
  sStoreUtils.WriteIniStr('Path', 'OutputPath', deOutput.Text, IniName);
end;

procedure TfrmDohod.sBitBtn1Click(Sender: TObject);
var
  i, j: integer;
  str, s, F, N, O, SQLText, txt: String;
  Client: TStringList;

begin
  for i := 0 to mInSpisok.Lines.Count - 1 do
  begin
    s := Trim(mInSpisok.Lines[i]);
    if s <> '' then
    begin
      try
        Client := TStringList.Create;
        // разделяем строку на слова
        Client.Text := StringReplace(s, ' ', #13, [rfReplaceAll]);

        if Client.Count = 1 then
        begin
          F := Client[0]; // Familya

          SQLText := 'Like "%' + F + '%"';

        end;

        if Client.Count = 2 then
        begin
          F := Client[0]; // Familya
          N := Client[1]; // Name
          // проверить второе слово или есть точки или две заглавные точки

          // str := N;
          str := DelSymbolIntoString(N, '.');

          if LastDelimiter('.', str) > 0 then
          begin
            // есть точка
            N := Copy(str, 1, Pos('.', str) - 1);
            O := DelSymbolIntoString(Copy(str, Pos('.', str) + 1), '.');

            SQLText := 'Like "%' + F + ' ' + N + '%"';
          end
          else
          begin
            // если нет точек и длина больше 2 то єто имя
            if str.Length = 2 then
            begin
              O := str[2];
              N := str[1];
            end;
            if str.Length = 1 then
              N := str[1];

            SQLText := 'Like "%' + F + ' ' + N + '%"';
          end;

        end;

        if Client.Count = 3 then
        begin
          F := Client[0]; // Familya
          N := DelSymbolIntoString(Client[1], '.'); // Name
          O := DelSymbolIntoString(Client[2], '.'); // Otchestvo
          // проверить второе и третье слово или есть точки

          SQLText := 'Like "%' + F + ' ' + N + '%"';

        end;

      finally
        Client.Free;
      end;

      // zapros

      begin
        with DM.qQuery do
        begin
          Active := false;
          Close;
          SQL.Clear;
          SQL.Add('SELECT Uchastniky.[JDC ID], Uchastniky.ФИО FROM Uchastniky WHERE (((Uchastniky.ФИО) '
            + SQLText + '));');

          s := SQL.Text;
          Active := true;

          if RecordCount = 1 then
          begin
            // mOutSpisok.Lines.Add(FieldbyName('ФИО').asString);
            mOutSpisok.Lines.Add(FieldbyName('JDC ID').asString);
            mOutSpisok.Lines.Add(FieldbyName('ФИО').asString);
          end;
          // if RecordCount > 1 then
          // begin
          // // mOutSpisok.Font.Color := clRed;
          // // AddColoredLine(ARichEdit: TRichEdit; AText: string;
          // // AddColoredLine(RichEdit1, 'Hallo', clRed);
          // for j := 0 to RecordCount - 1 do
          // begin
          //
          // // txt := FieldbyName('ФИО').asString;
          // txt := FieldbyName('JDC ID').asString + ' ' + FieldbyName('ФИО').asString;
          // AddColoredLine(mOutSpisok, txt, clRed);
          //
          // next;
          //
          // end;
          //
          // // mOutSpisok.Font.Color := clBlack;
          //
          // end;

        end;
      end;

    end;

  end;

end;

procedure TfrmDohod.sBitBtn2Click(Sender: TObject);
begin
  inherited;
  txtOutput.Lines.SaveToFile(FileNameTXT);
end;

procedure TfrmDohod.deInputChange(Sender: TObject);
begin
  inherited;
  sStoreUtils.WriteIniStr('Path', 'InputPath', deInput.Text, IniName);
  lvInput.root.CustomPath := deInput.Text;
end;

procedure TfrmDohod.deOutputChange(Sender: TObject);
begin
  inherited;
  sStoreUtils.WriteIniStr('Path', 'OutputPath', deOutput.Text, IniName);
  lvOutput.root.CustomPath := deOutput.Text;
end;

procedure TfrmDohod.lvInputChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
  var
  s, fntxt: string;
begin
   // открываем PDF файл
 s := Trim(lvInput.SelectedFilePaths.Text);
  PdfView.OpenPdfFile(s);
  PdfView.FitWidth;
  txtOutput.Lines.Clear;

  fntxt := ExtractFileNameEx(s) + '.txt';
  FileNameTXT := lvOutput.Root.CurrentPath + '\'+fntxt;
  txtOutput.Lines.LoadFromFile(FileNameTXT, TEncoding.UTF8);
end;

procedure TfrmDohod.lvOutputChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  inherited;
  FileNameTXT := Trim(lvOutput.SelectedFilePaths.Text);
   txtOutput.Clear;
   txtOutput.Lines.LoadFromFile(FileNameTXT, TEncoding.UTF8);
end;

procedure TfrmDohod.tbtnOpenFileClick(Sender: TObject);
begin
  inherited;
  if OpenDialog.Execute then
  begin
    PdfView.OpenPdfFile(OpenDialog.FileName);
  end;
end;

procedure TfrmDohod.ToolButton11Click(Sender: TObject);
begin
  inherited;
  PdfView.FitWidth;
end;

procedure TfrmDohod.ToolButton12Click(Sender: TObject);
begin
  inherited;
  PdfView.FitHeight;
end;

procedure TfrmDohod.ToolButton13Click(Sender: TObject);
begin
  inherited;
  PdfView.FitPage;
end;

procedure TfrmDohod.ToolButton15Click(Sender: TObject);
begin
  inherited;
  PdfView.RotateLeft;
end;

procedure TfrmDohod.ToolButton16Click(Sender: TObject);
begin
  inherited;
  PdfView.RotateRight;
end;

procedure TfrmDohod.ToolButton18Click(Sender: TObject);
var
  pythonScript: string;
begin
  inherited;
   pythonScript := 'G:\JS\pdftotext\index2.py'; // Замените на путь к вашему Python-скрипту

  if FileExists(pythonScript) then
  begin
    ShellExecute(0, 'open', 'python', PChar(pythonScript), nil, SW_SHOW);
  end
  else
  begin
    ShowMessage('Файл скрипта не найден.');
  end;
end;

procedure TfrmDohod.ToolButton2Click(Sender: TObject);
begin
  inherited;
  if SaveDialog1.Execute then
  begin
    PdfView.SaveAs(SaveDialog1.FileName);
  end;
end;

procedure TfrmDohod.ToolButton6Click(Sender: TObject);
begin
  inherited;
  PdfView.zoomFactor := PdfView.zoomFactor + 10;
end;

procedure TfrmDohod.ToolButton7Click(Sender: TObject);
begin
  inherited;
  PdfView.zoomFactor := PdfView.zoomFactor - 10;
end;

procedure TfrmDohod.ToolButton8Click(Sender: TObject);
begin
  inherited;
  PdfView.PreviousPage;
end;

procedure TfrmDohod.ToolButton9Click(Sender: TObject);
begin
  inherited;
  PdfView.NextPage;
end;

procedure TfrmDohod.btnAnalizClick(Sender: TObject);
var
  s, pib, dohod: String;
  i, onPos: integer;
begin
  inherited; // ------------ АНАЛІЗУВАТИ ------------------
  mInSpisok.Clear;
  // ---- Находим ФИО -----
  for i := 1 to txtOutput.Lines.Count - 1 do
  begin
    pib := ExtractUpperCaseWords(Trim(txtOutput.Lines[i]));
    // mOutSpisok.Lines.Add(pib);
    mInSpisok.Lines.Add(pib);
    sBitBtn1Click(Sender);

    if pib.Length > 15 then
      Break;
  end;
  mInSpisok.Lines.Add(pib);

  Application.ProcessMessages;
  // ------ Находим сумму пенсии ------
  for i := 5 to txtOutput.Lines.Count - 1 do
  begin
    if txtOutput.Lines[i] <> '' then
    begin
      s := CutString(Trim(ANSILowerCase(txtOutput.Lines[i])), 'август');
      if s.Length > 1 then
        mOutSpisok.Lines.Add(FormatCurrentValue(s))
      else
      begin
        s := CutString(Trim(ANSILowerCase(txtOutput.Lines[i])), 'июль');
        if s.Length > 1 then
          mOutSpisok.Lines.Add(FormatCurrentValue(s));
      end;
    end;

  end;
  mOutSpisok.Lines.Add('');

end;



procedure TfrmDohod.ToolButton1Click(Sender: TObject);
var
  i: integer;
begin
  // пробежаться по всем файлам
  for i := 0 to lvOutput.FolderCount - 1 do
  begin
    txtOutput.Lines.LoadFromFile(Trim(lvOutput.Folders[i].PathName), TEncoding.UTF8);
    btnAnalizClick(Sender);
  end;

end;

procedure TfrmDohod.btnCreateExcelClick(Sender: TObject);
var
  Sheets, ExcelApp: variant;
  i, col, row: Integer;
  s, DirectoryNow, FileNameS: String;
begin
  //--------- Файл с доходами ------------
  if uMyExcel.RunExcel(false, false) = true then
    MyExcel.Workbooks.Add; // добавляем новую книгу

  Sheets := MyExcel.Worksheets.Add;
  Sheets.name := 'A1';
  ParametryStr; // Парметры страницы
  Sheets.PageSetup.PrintTitleRows := '$2:$2';

  // Параметры таблицы ( цифра номер столбца ) ширины столбцов

  ExcelApp := MyExcel.ActiveWorkBook.Worksheets[1].columns;

  ExcelApp.columns[1].columnwidth := 10;
  ExcelApp.columns[1].NumberFormat := '@';
  ExcelApp.columns[2].columnwidth := 30;
  ExcelApp.columns[3].columnwidth := 15;
  ExcelApp.columns[4].columnwidth := 10;
  ExcelApp.columns[4].NumberFormat := '@';
  ExcelApp.columns[5].columnwidth := 15;
  ExcelApp.columns[6].columnwidth := 20;
  ExcelApp.columns[7].columnwidth := 20;
  ExcelApp.columns[8].columnwidth := 12;

  MyExcel.Range['A1'].value := 'JDC ID';
  MyExcel.Range['B1'].value := 'ФИО';
  MyExcel.Range['C1'].value := 'Тип дохода';
  MyExcel.Range['D1'].value := 'Сумма';
  MyExcel.Range['E1'].value := 'Дата начала действия';
  MyExcel.Range['F1'].value := 'Документы проверены';
  MyExcel.Range['G1'].value := 'Источник данных';
  MyExcel.Range['H1'].value := 'Примечание';

      row := 2;
      col := 1;
    for I := 0 to mOutSpisok.Lines.Count -1 do
      begin

       s:= mOutSpisok.Lines[i];
       if s <> '' then
       begin
            if col=3 then
            begin
             MyExcel.Cells[row, col+1] := s;
             MyExcel.Cells[row, col] := 'Пенсия';
             MyExcel.Cells[row, col+2] := '13.11.2023';
             MyExcel.Cells[row, col+3] := '1';
             MyExcel.Cells[row, col+4] := 'Документ';
             MyExcel.Cells[row, col+5] := 'из импорта';
             col := 0;
             Inc(row);
            end
            else
            MyExcel.Cells[row, col] := s;

          Inc(col);
       end;

      end;


  DirectoryNow := ExtractFilePath(ParamStr(0)) + 'Данные\Доход\';

  if not DirectoryExists('DirectoryNow') then
    ForceDirectories(DirectoryNow);


  FileNameS := DirectoryNow + 'Доходы_' + FormatDateTime('dd.mm.yyyy hh_mm_ss',
    Now) + '.xlsx';

  uMyExcel.SaveWorkBook(FileNameS, 1);

  Sheets := unassigned;
  ExcelApp := unassigned;
  uMyExcel.StopExcel;

  ShowMessage('Данные экспортированы и сохранены в файл');

  // ShellExecute(Handle, 'open', PWideChar(DirectoryNow), nil, nil,SW_SHOWNORMAL);

  ShellExecute(Handle, 'open', PWideChar(DirectoryNow), nil, nil,
    SW_SHOWNORMAL);
end;

end.
