unit uMyProcedure;

interface

uses
  ComObj, ActiveX, Variants, Windows, Messages, SysUtils, Classes, Vcl.Dialogs,
  System.UITypes, JvStringGrid, sComboBox, DateUtils, sCheckBox, sScrollBox,
  Vcl.ExtCtrls, mimemess, mimepart, smtpsend, sLabel, Data.Win.ADODB,
  System.Character, DBGridEh,
  System.Generics.Collections;

// ���������� ���������� ��������
procedure MonthComboBox(comboBox: TsComboBox);
// �������� ������� �� �������
procedure CleanOutTable(tabl: String);
// ������� ������� � ��������� �������
procedure CleanOutTableAndIndex(tabl: String; pole: String);
// ������� ������� � ��������� ������� � ��������� � ����� ����� �������� �������
procedure CleanOutTableAndIndex0(tabl, pole, startNumber: String);
// �������� ��� ���� �������� ���������
Function isStringAssign(s: String; combo: TStrings): boolean;
// ��������� '.' ��� ',' � ������������ ���������� ����������� ����� � ������� �����
procedure DecimalChange(s: string);
// ����� ����������� ����� � ������� ����� � �������
function isDesimal(): String;

function ParseStringUpakovka(s: string): String;
// �������� ����� �������
procedure AutoStringGridWidth(StringGrid: TJvStringGrid);

function RazdelenieIO(IO: String; ind: Integer): String;
// ������� ���� � ������
function DCOUNT(str, Delimeter: string): Integer;
// ������� ������ � ������
function DelSymbolIntoString(s, Delimeter: string): string;
// �������� � ������ �������
function ReplaceChar(s: string): String; //
// ������ �� ���� � ���� ����� ��� ������
function isDateBetween(begindate, enddate, checkdate: String): boolean;
// ��������� ����
function RecoveryDate(date_period, error_date: string): string;

// �������� �������� ��� ��������� ��� �������� �� �����
procedure CreateCheckBoxCurators(curator: string; panelParent: TsScrollBox;
  pathFilename: string; xTop: Integer);

// �������� ������ � ������
function SendEmailAndAttach(pHost, pSubject, pTo, pFrom, pTextBody, pHTMLBody,
  pLogin, pPassword, pFilePath: string): boolean;

// ������ ����������� ����� � �������
procedure ImportExcelIntoBD(table: String; adoTable: TADOTable;
  pole, alterCleanProperty: TStringList);

// ��� ����� �� ������� ����
function ExtractFileNameEx(PathName: string): string;
function ExtractExtention(FileName: string): string;
function ExtractFileName(FileName: string): string;

// �������� ���������� ���� � ������:
function CountWords(const Text: string): Integer;
// ����� ���� ���� � ������� ��������
function ExtractUpperCaseWords(inputString: string): string;
// ����� ����� � ������ � ��������� ������� ���
function FindAndExtractWord(inputString, targetWord: string): string;
// �������� �������� ������� �� ������ �� �������
function CutString(const s: string; const Pattern: string): string;
// ������� ��������� �� ������
function myRemoveNum(s: string): string;
// �������������� ����� � ���������� ������
function FormatCurrentValue(s: String): String;
// ������ ������ ������� �� �������� ������
function RemoveNonDigits(const s: string): string;

// ������� ������ � ������ � ���� ������
function ExportExcelToBDTable(tabl: string; cleantabl: boolean;
  MyTable: TADOTable; myFields: TStrings): boolean;

// ��������� � ������ ������ � �����
function SaveExcelFromGrid(grid: TDBGridEh): boolean;

// ������� � ������� �������������� ������ � ��������(���������)
function InsertDataAnalitic(sqlText, fieldValue: String): boolean;
// ������� � ������� ��������� ������������� ������
function InsertDataAnaliticAll(sqlText, fieldValue: String): boolean;

implementation

uses uDataModul, Registry, uFrameVidomist, uBDlogic, uMainForm, uMyExcel;

function myRemoveNum(s: string): string;
var
  i, NumEnd: Integer;
begin
  Result := s;

  // ���� ����� � ������ ������
  NumEnd := Pos('.', s);

  if (NumEnd > 0) and (NumEnd < 5) then
  begin
    // ���� ��������� ������ ������
    if s[NumEnd + 1] = ' ' then
      Result := Copy(s, NumEnd + 2, length(s) - (NumEnd))
    else
      Result := Copy(s, NumEnd + 1, length(s) - NumEnd);
    trim(Result);
  end;
end;

function DelSymbolIntoString(s, Delimeter: string): string;
// ������� ������ � ������
var
  i, j: Integer;
begin
  for i := 0 to s.length - 1 do
  begin
    j := Pos(Delimeter, s);
    Delete(s, j, 1);
  end;
  Result := s;
end;

function ReplaceChar(s: string): String;
// �������� � ������ �������
var
  i, z: Integer;
begin
  Result := s;
  z := 0; // ���������� �������� �������
  for i := 1 to length(s) do
  begin
    if Result[i] = '"' then
    begin
      if z = 0 then
      begin
        Result[i] := '�';
        z := 1;
      end
      else
      begin
        Result[i] := '�';
        z := 0;
      end;
    end;
  end;
end;

function DCOUNT(str, Delimeter: string): Integer;
// ������� ���� � �����
var
  StrL: TStringList;
  ParseStr: string;
begin
  try
    StrL := TStringList.Create;
    ParseStr := StringReplace(str, Delimeter, #13, [rfReplaceAll]);
    StrL.Text := ParseStr;
    Result := StrL.Count;
  finally
    StrL.Free;
  end;
end;

function RazdelenieIO(IO: String; ind: Integer): String;
// ���������� ����� �������� �� ��� �����
begin
  if (ind = 0) or (ind > 2) then
    Result := ''
  else if ind = 1 then
  begin // ���
    Result := Copy(IO, 1, Pos(' ', IO) - 1);
  end
  else
  begin // ��������
    Result := Copy(IO, Pos(' ', IO) + 1);
  end;
end;

procedure CleanOutTable(tabl: String);
begin // �������� ������� �� �������
  with DM.qQuery do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Delete * From ' + tabl);
    ExecSQL;
    Close;
  end;
end;

procedure CleanOutTableAndIndex(tabl: String; pole: String);
var
  s: string;
begin
  with DM.qQuery do
  begin
    Close; // �������� ������ ������� pole - �������� ���� �� �������� �����
    SQL.Clear;
    SQL.Add('Alter Table ' + tabl + '  Alter Column ' + pole + ' Counter(1,1)');
    s := SQL.Text;
    ExecSQL;
    Close;
    CleanOutTable(tabl); // ������� �������
  end;
end;

// ������� ������� � ��������� ������� � ��������� � ����� ����� �������� �������
procedure CleanOutTableAndIndex0(tabl, pole, startNumber: String);
begin
  with DM.qQuery do
  begin
    Close; // �������� ������ ������� pole - �������� ���� �� �������� �����
    SQL.Clear;
    SQL.Add('Alter Table ' + tabl + '  Alter Column ' + pole + ' Counter(' +
      startNumber + ',1)');
    ExecSQL;
    Close;
    CleanOutTable(tabl); // ������� �������
  end;
end;

Function isStringAssign(s: string; combo: TStrings): boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to combo.Count - 1 do
  begin
    if combo.Strings[i] = s then
    begin
      Result := True;
      break;
    end;
  end;
end;

function ParseStringUpakovka(s: string): String;
var
  p: Integer;
begin
  s := trim(Copy(s, 1, Pos('��', s) - 1));
  if not(s = '') then
  begin
    p := LastDelimiter(' ', s);
    Result := Copy(s, p, length(s) - p + 1);
  end
  else
    Result := '0';
end;

procedure DecimalChange(s: string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('Control Panel\International', False);
    Reg.WriteString('sDecimal', s { ����� ����������� } );
    // Reg.WriteString('sDecimal', '.' { ����� ����������� } );
  finally
    Reg.Free;
  end;
end;

function isDesimal(): String;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('Control Panel\International', False);
    // Reg.WriteString('sDecimal', '.' { ����� ����������� } );
    Result := Reg.ReadString('sDecimal');
  finally
    Reg.Free;
  end;
end;

{
  ----- �������� ������ ������� -----
  AutoStringGridWidth(��� JvStringGrid);
}
procedure AutoStringGridWidth(StringGrid: TJvStringGrid);
var
  X, Y, w: Integer;
  MaxWidth: Integer;
begin
  with StringGrid do
    // ClientHeight := DefaultRowHeight * RowCount + 5;
    with StringGrid do
    begin
      for X := 0 to ColCount - 1 do
      begin
        MaxWidth := 0;
        for Y := 0 to RowCount - 1 do
        begin
          w := Canvas.TextWidth(Cells[X, Y]);
          if w > MaxWidth then
            MaxWidth := w;
        end;
        ColWidths[X] := MaxWidth + 5;
      end;
    end;
end;

// ��������� �������� ���������
procedure MonthComboBox(comboBox: TsComboBox);
var
  i: Integer;
begin
  for i := 1 to MonthsPerYear do
  begin
    comboBox.Items.Add(FormatSettings.LongMonthNames[i]);
  end;
  comboBox.ItemIndex := 0;
end;

// ������ �� ���� � ���� ����� ��� ������
function isDateBetween(begindate, enddate, checkdate: String): boolean;
var
  bdate, edate, chdate: TDateTime;
begin
  Result := False;

  if (not TryStrToDate(begindate, bdate)) or
    (not TryStrToDate(checkdate, chdate)) or (not TryStrToDate(enddate, edate))
  then
  begin
    ShowMessage('������� ������ �������� ����');
    Exit;
  end;
  Result := (CompareDateTime(bdate, chdate) <= 0) and
    (CompareDateTime(chdate, edate) <= 0);
end;

// �������� ���� �� ������
function RecoveryDate(date_period, error_date: string): string;
var
  date_period1, error_date1, s: TDateTime;
begin
  if (not TryStrToDate(date_period, date_period1)) or
    (not TryStrToDate(error_date, error_date1)) then
  begin
    ShowMessage('������� ������ �������� ����');
    Exit;
  end;

  s := error_date1;

  if (YearOf(date_period1) <> YearOf(error_date1)) then
    s := RecodeYear(error_date1, YearOf(date_period1)); // �������� ���

  Result := DateToStr(RecodeMonth(s, MonthOf(date_period1)));
end;

// �������� �������� ��� ��������� ��� �������� �� �����
procedure CreateCheckBoxCurators(curator: string; panelParent: TsScrollBox;
  pathFilename: string; xTop: Integer);
var
  Chb: TsCheckBox;
  LbEdit: TLabeledEdit;
  Lb: TsLabel;
  mail: string;
begin
  mail := SearchPoziciyString('Curators', 'curFIO', curator, 'curEMail');
  // ���
  Chb := TsCheckBox.Create(panelParent);
  Chb.parent := panelParent;
  Chb.Caption := curator;
  Chb.Left := 5;
  Chb.Top := 5 + (xTop * 20);
  Chb.Name := 'MyDynCheckBox' + inttostr(xTop);
  Chb.Tag := xTop;
  // ����
  LbEdit := TLabeledEdit.Create(panelParent);
  LbEdit.parent := panelParent;
  LbEdit.Text := mail;
  LbEdit.Width := 160;
  LbEdit.Left := panelParent.Width - LbEdit.Width - 10;
  LbEdit.Top := 5 + (xTop * 20);
  LbEdit.Name := 'MyDynLabelEdit' + inttostr(xTop);

  // pathFilename
  Lb := TsLabel.Create(panelParent);
  Lb.parent := panelParent;
  Lb.Caption := pathFilename;
  Lb.Name := 'MyDynLabel' + inttostr(xTop);
  Lb.Visible := False;
end;

// �������� ������ �� ���������
function SendEmailAndAttach(pHost, pSubject, pTo, pFrom, pTextBody, pHTMLBody,
  pLogin, pPassword, pFilePath: string): boolean;
var
  tmpMsg: TMimeMess; // ��������
  tmpStringList: TStringList; // ���������� ������
  tmpMIMEPart: TMimePart; // ����� ��������� (�� �������)
begin
  tmpMsg := TMimeMess.Create;
  tmpStringList := TStringList.Create;
  Result := False;
  try
    // Headers  ��������� ���������
    tmpMsg.Header.Subject := pSubject; // ���� ���������
    tmpMsg.Header.From := pFrom; // ��� � ����� �����������
    tmpMsg.Header.ToList.Add(pTo); // ��� � ����� ����������

    // MIMe Parts  ������� �������� �������
    tmpMIMEPart := tmpMsg.AddPartMultipart('alternate', nil);

    if length(pTextBody) > 0 then
    begin
      tmpStringList.Text := pTextBody;
      tmpMsg.AddPartText(tmpStringList, tmpMIMEPart);
    end
    else
    begin
      tmpStringList.Text := pHTMLBody;
      tmpMsg.AddPartHTML(tmpStringList, tmpMIMEPart);
    end;

    // ������������ ����
    tmpMsg.AddPartBinaryFromFile(pFilePath, tmpMIMEPart);

    // �������� � ����������
    tmpMsg.EncodeMessage;
    if smtpsend.SendToRaw(pFrom, pTo, pHost, tmpMsg.Lines, pLogin, pPassword)
    then
      Result := True;

  finally
    tmpMsg.Free;
    tmpStringList.Free;
  end;
end;

// ------ ������ ����������� ����� � ������� ---------------
procedure ImportExcelIntoBD(table: String; adoTable: TADOTable;
  pole, alterCleanProperty: TStringList);
var
  z, Y, m, n, col, poleCount: Integer;
  CollectionNameExcelColumn: TDictionary<string, Integer>;
  ColumnNameExcel, PoleNameSpisok: String;
  PoleNumber, IntNumber: String;
  val: string;

begin
  with myForm do
  begin
    OpenDialog.Filter := '����� MS Excel|*.xls;*.xlsx|';
    if not OpenDialog.Execute then
      Exit;
    // �������� �� ������� � ������ Excel
    if uMyExcel.RunExcel(False, False) = True then

      try
        // ��������� ����� Excel
        if uMyExcel.OpenWorkBook(OpenDialog.FileName, False) then
        begin
          ProgressBar.Visible := True;
          MyExcel.ActiveWorkBook.Sheets[1];

          // ��������� ����������� �������
          col := MyExcel.ActiveCell.SpecialCells($000000B).Column;

          // ------------ ���������� ��������� ������� �������� ������ �������� ---------
          CollectionNameExcelColumn := TDictionary<string, Integer>.Create();

          for z := 1 to col do
          begin
            ColumnNameExcel := MyExcel.Cells[1, z].value;
            // ***************************************************************************************
            if pole = nil then
            begin
              // ���� �� ��������� ������, � ����� ��� ����

              if not CollectionNameExcelColumn.ContainsKey
                (MyExcel.Cells[1, z].value) then
                CollectionNameExcelColumn.Add(MyExcel.Cells[1, z].value, z)
              else // ���� ���� ��� ����� ���� �� � ����� ��������� �����
                CollectionNameExcelColumn.Add(MyExcel.Cells[1, z].value +
                  inttostr(z), z);

              // ********************************************************************************************
            end
            else
            begin
              // ���� ����� ������������ ���� ������� ��������� � pole
              poleCount := pole.Count;
              for Y := 0 to pole.Count - 1 do
              begin
                PoleNameSpisok := pole.Strings[Y];

                if ColumnNameExcel = PoleNameSpisok then
                begin
                  if not CollectionNameExcelColumn.ContainsKey
                    (MyExcel.Cells[1, z].value) then
                    CollectionNameExcelColumn.Add(MyExcel.Cells[1, z].value, z)
                  else // ���� ���� ��� ����� ���� �� � ����� ��������� �����
                    CollectionNameExcelColumn.Add(MyExcel.Cells[1, z].value +
                      inttostr(z), z);
                  break;
                end;
              end;
            end;
            // ================= ����� ������� ���  �������� ======================

          end;
          // *******************************************************************************
          if pole = nil then
          begin
            pole := TStringList.Create;
            for val in CollectionNameExcelColumn.keys do
              pole.Add(val);
          end;

          // ***********************************************************************************

          // ��������� ��� ���� � ����� ������ ����
          if not pole.Count = CollectionNameExcelColumn.Count then
          begin // ��� ������-�� ����
            ShowMessage('�� ������� ������� ������� � �����');
          end
          else
          begin // ��� ���� ����
            // ������� ������
            // ���� ���� ������ � ����� � ������� ������ ����� ������, �� ������� �� �������
            if alterCleanProperty = nil then
              CleanOutTable(table)
            else
            begin
              PoleNumber := alterCleanProperty.Strings[0];
              IntNumber := alterCleanProperty.Strings[1];

              CleanOutTableAndIndex0(table, PoleNumber, IntNumber);
            end;

            // ������ ������ � �������
            adoTable.Open;

            m := 2; // �������� ���������� �� 2-� ������, �������� ��������� �������
            // ��������� ����������� ������
            n := MyExcel.ActiveCell.SpecialCells($000000B).Row;
            n := n + 1;

            ProgressBar.Min := 0;
            ProgressBar.Max := n;
            ProgressBar.Position := 1;

            if pole <> nil then
            begin
              // ���� ���� ��������� ����
              while m <> n do // ���� ������� �� ������� EXCEL
              begin
                adoTable.Insert;
                for z := 0 to pole.Count - 1 do
                begin
                  ColumnNameExcel := pole.Strings[z]; // ��� ����

                  adoTable.FieldByName(ColumnNameExcel).AsString :=
                    MyExcel.Cells
                    [m, StrToInt(CollectionNameExcelColumn.Items
                    [ColumnNameExcel].ToString)].value;

                end;
                adoTable.Post;
                Inc(m);
                // Application.ProcessMessages;
                Sleep(25);
                ProgressBar.Position := m;
              end;

            end;

          end;

          MyExcel.Application.DisplayAlerts := False;
          StopExcel;
          CollectionNameExcelColumn.Clear;
          CollectionNameExcelColumn.Free;
        end;

      except
        on E: Exception do
        begin
          MyExcel.Application.DisplayAlerts := False;
          StopExcel;
          CollectionNameExcelColumn.Clear;
          CollectionNameExcelColumn.Free;
        end;
      end;
  end;
  ShowMessage('������ �������!');
  myForm.ProgressBar.Visible := False;
end;

// ��� ����� �� ������� ����  '\'
function ExtractFileNameEx(PathName: string): string;
var
  i: Integer;
begin
  i := length(PathName);
  if i <> 0 then
  begin
    while (PathName[i] <> '\') and (i > 0) do
    begin
      i := i - 1;
      Result := Copy(PathName, i + 1, length(PathName) - i);
    end;
  end;
end;

function ExtractExtention(FileName: string): string;
var
  i: Integer;
begin
  i := length(FileName);
  if i <> 0 then
  begin
    while (FileName[i] <> '.') and (i > 0) do
    begin
      i := i - 1;
      Result := Copy(FileName, i + 1, length(FileName) - i);
    end;
  end;
end;

function ExtractFileName(FileName: string): string;
begin
  Result := Copy(FileName, 1, length(FileName) - 4);
end;

// �������� ���������� ���� � ������:
function CountWords(const Text: string): Integer;
var
  i: Integer;
  Count: Integer;
begin
  Count := 0;
  for i := 1 to length(Text) do
    if Text[i] in [#32, #9, #13, #10] then
      Inc(Count);
  Result := Count + 1;
end;

function ExtractUpperCaseWords(inputString: string): string;
var
  currentWord, extractedWords, bukva: string;
  i, Tag: Integer;
begin
  extractedWords := '';

  currentWord := '';
  Tag := 0;

  for i := 1 to length(inputString) do
  begin
    bukva := inputString[i];

    if TCharacter.IsUpper(inputString[i]) then
    begin
      currentWord := currentWord + inputString[i];
      Inc(Tag);
    end
    else
    begin

      if currentWord <> '' then
      begin
        if extractedWords <> '' then
        begin
          extractedWords := extractedWords + ' ';
        end;

        if Tag = 1 then
        begin
          currentWord := '';
          Tag := 0;
        end
        else
        begin
          extractedWords := extractedWords + currentWord;
          currentWord := '';
        end;

      end;
    end;
  end;

  if currentWord <> '' then
  begin
    if extractedWords <> '' then
      extractedWords := extractedWords + ' ';
    extractedWords := extractedWords + currentWord;
  end;

  Result := extractedWords;
end;

function FindAndExtractWord(inputString, targetWord: string): string;
var
  words: TStringList;
  i: Integer;
  s: string;
begin
  Result := '';

  words := TStringList.Create;
  try
    words.Delimiter := ' ';
    words.StrictDelimiter := True;
    words.DelimitedText := AnsiLowerCase(inputString);

    for i := 0 to words.Count - 1 do
    begin
      if SameText(words[i], targetWord) then
      begin
        if Result <> '' then
          Result := Result + ' ';
        Result := Result + words[i] + words[i + 2];
      end;
    end;
  finally
    words.Free;
  end;
end;

function CutString(const s: string; const Pattern: string): string;
var
  onPos, newPos: Integer;
  p, w: string;
begin
  Result := '';
  if s <> '' then
  begin
    onPos := AnsiPos(Pattern, s);
    // newPos := (s.Length - onPos);
    newPos := s.length;
    if onPos <> 0 then
      Result := Copy(s, onPos, newPos);
  end;
end;

// �������������� ����� � ���������� ������
function FormatCurrentValue(s: String): String;
var
  onPos: Integer;
  inputString, modifiedString: string;
  lastDigitIndex: Integer;
begin
  onPos := AnsiPos('2023', s);
  inputString := Copy(s, onPos + 5, s.length);
  modifiedString := RemoveNonDigits(inputString);

  if modifiedString.length >= 2 then
  begin
    lastDigitIndex := length(modifiedString) - 2;

    Result := Copy(modifiedString, 1, lastDigitIndex) + '.' +
      Copy(modifiedString, lastDigitIndex + 1, length(modifiedString) -
      lastDigitIndex);
  end;

end;

// ������ ������ ������� �� �������� ������
function RemoveNonDigits(const s: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to length(s) do
    if IsDigit(s[i]) then
      Result := Result + s[i];
end;

// ������� ������ � ������ � ���� ������
function ExportExcelToBDTable(tabl: string; cleantabl: boolean;
  MyTable: TADOTable; myFields: TStrings): boolean;
var
  CollectionNameTable: TDictionary<string, Integer>;
  i, z, col, m, n: Integer;
  s, E: string;
begin
  Result := False;

  try

    with myForm, DM do
    begin
      OpenDialog.Filter := '����� MS Excel|*.xls;*.xlsx|';
      if not OpenDialog.Execute then
        Exit;
      // �������� �� ������� � ������ Excel
      if uMyExcel.RunExcel(False, False) = True then
        // ��������� ����� Excel
        if uMyExcel.OpenWorkBook(OpenDialog.FileName, False) then
        begin
          ProgressBar.Visible := True;
          MyExcel.ActiveWorkBook.Sheets[1];

          // ��������� ����������� �������
          col := MyExcel.ActiveCell.SpecialCells($000000B).Column;

          // ---------- ���������� ��������� ������� �������� �������� -----------

          CollectionNameTable := TDictionary<string, Integer>.Create();
          for z := 1 to col do
          begin
            if not CollectionNameTable.ContainsKey(MyExcel.Cells[1, z].value)
            then
              CollectionNameTable.Add(StringReplace(MyExcel.Cells[1, z].value,
                '.', '', [rfReplaceAll]), z)
            else
              CollectionNameTable.Add(MyExcel.Cells[1, z].value +
                z.ToString, z);
          end;
          // ================= ����� ������� ���  �������� ======================

          m := 2; // �������� ���������� �� 2-� ������, �������� ��������� �������
          // ��������� ����������� ������
          n := MyExcel.ActiveCell.SpecialCells($000000B).Row;
          n := n + 1;

          ProgressBar.Min := 0;
          ProgressBar.Max := n;
          ProgressBar.Position := 1;

          // ������� ������� ���� ����
          if cleantabl = True then
            CleanOutTable(tabl);

          MyTable.Open;
          while m <> n do // ���� ������� �� ������� EXCEL
          begin
            MyTable.Insert;

            for i := 0 to myFields.Count - 1 do
            begin
              s := myFields[i];
              E := MyExcel.Cells
                [m, StrToInt(CollectionNameTable.Items[myFields[i]]
                .ToString)].value;

              MyTable.FieldByName(myFields[i]).AsString :=
                MyExcel.Cells
                [m, StrToInt(CollectionNameTable.Items[myFields[i]]
                .ToString)].value;
            end;

            MyTable.Post;
            Inc(m);
            // Application.ProcessMessages;
            Sleep(25);
            ProgressBar.Position := m;
          end;

          Result := True;

        end;

      MyExcel.Application.DisplayAlerts := False;
      StopExcel;
      CollectionNameTable.Clear;
      CollectionNameTable.Free;
      MyTable.Active := False;
      myForm.ProgressBar.Visible := False;
      // DM.qUslugy.Active := false;
      // DM.qUslugy.Active := true;
    end;
  except
    on E: EListError do
    begin
      // CleanOutTable('TemaDavayPodkl'); // �������� �������
      // DM.tTemaDavayPodkl.Active := false;
      ShowMessage('�� ����� ������ �����, ���� ���������� ����');
      MyExcel.Application.DisplayAlerts := False;
      StopExcel;
      CollectionNameTable.Clear;
      CollectionNameTable.Free;
      myForm.ProgressBar.Visible := False;
    end;
  end;
end;

// ������� � ������� �������������� ������ � ��������(���������)
function InsertDataAnalitic(sqlText, fieldValue: String): boolean;
var
  i: Integer;
begin
  Result := False;
  with DM do
  begin
    qUchastniky.Active := False;
    qUchastniky.SQL.Clear;
    qUchastniky.SQL.Add(sqlText);
    qUchastniky.Active := True;

    if qUchastniky.RecordCount <> 0 then
    begin
      Result := True;
      tAnaliticAll.Active := True;
      tAnaliticAll.First;
      qUchastniky.First;
      for i := 0 to qUchastniky.RecordCount - 1 do
      begin
        tAnaliticAll.Insert;
        tAnaliticAll.FieldByName('�����').AsString :=
          qUchastniky.FieldByName('�������').AsString;
        tAnaliticAll.FieldByName(fieldValue).AsString :=
          qUchastniky.FieldByName('Count-���').AsString;
        tAnaliticAll.Post;
        qUchastniky.Next;
      end;
      tAnaliticAll.Active := False;
      tAnaliticAll.Active := True;
    end;

  end;
end;

// ������� � ������� ��������� ������������� ������
function InsertDataAnaliticAll(sqlText, fieldValue: String): boolean;
var
  s, q: string;
  i, j: Integer;
begin
  Result := False;
  with DM do
  begin
    qUchastniky.Active := False;
    qUchastniky.SQL.Clear;
    qUchastniky.SQL.Add(sqlText);
    qUchastniky.Active := True;

    if qUchastniky.RecordCount <> 0 then
    begin
      Result := True;

      tAnaliticAll.First;
      qUchastniky.First;
      for i := 0 to qUchastniky.RecordCount - 1 do
      begin
        s := qUchastniky.FieldByName('�������').AsString;
        for j := 0 to tAnaliticAll.RecordCount - 1 do
        begin
          q := tAnaliticAll.FieldByName('�����').AsString;
          if s = q then
          begin
            tAnaliticAll.Edit;
            tAnaliticAll.FieldByName(fieldValue).AsString :=
              qUchastniky.FieldByName('Count-���').AsString;
            tAnaliticAll.Post;
            break;
          end
          else
            tAnaliticAll.Next;
        end;

        qUchastniky.Next;
      end;
      qAnaliticAll.Active := False;
      qAnaliticAll.Active := True;
    end;
  end;
end;

// ��������� � ������ ������ � �����
function SaveExcelFromGrid(grid: TDBGridEh): boolean;
var
  Sheets, ExcelApp: Variant;
  i, j: Integer;
  val: String;
begin

  try
    if uMyExcel.RunExcel(False, True) = True then
      MyExcel.Workbooks.Add; // ��������� ����� �����
    Sheets := MyExcel.Worksheets.Add;
    Sheets.Name := 'Analitics';
    ParametryStr; // �������� ��������
    Sheets.PageSetup.PrintTitleRows := '$2:$2';

    // ��������� ������� ( ����� ����� ������� ) ������ ��������
    ExcelApp := MyExcel.ActiveWorkBook.Worksheets[1].columns;

    ExcelApp.columns[1].columnwidth := 17.86;
    ExcelApp.columns[2].columnwidth := 17.71;
    ExcelApp.columns[3].columnwidth := 10.71;
    ExcelApp.columns[4].columnwidth := 5.0;
    ExcelApp.columns[5].columnwidth := 5.0;
    ExcelApp.columns[6].columnwidth := 5.0;
    ExcelApp.columns[7].columnwidth := 5.0;
    ExcelApp.columns[8].columnwidth := 8.43;
    ExcelApp.columns[9].columnwidth := 8.43;
    ExcelApp.columns[10].columnwidth := 5.0;
    ExcelApp.columns[11].columnwidth := 5.0;
    ExcelApp.columns[12].columnwidth := 5.0;
    ExcelApp.columns[13].columnwidth := 7.29;
    ExcelApp.columns[14].columnwidth := 7.14;
    ExcelApp.columns[15].columnwidth := 5.0;
    ExcelApp.columns[16].columnwidth := 5.0;
    ExcelApp.columns[17].columnwidth := 5.0;
    ExcelApp.columns[18].columnwidth := 5.0;
    ExcelApp.columns[19].columnwidth := 5.0;
    ExcelApp.columns[20].columnwidth := 8.43;
    ExcelApp.columns[21].columnwidth := 8.29;

    // ------------ 1-� ������ ------------------------
    MyExcel.ActiveWorkBook.Worksheets[1].Range['A1:U1'].Select;
    MyExcel.ActiveWorkBook.Worksheets[1].Range['A1:U1'].Merge;
    MyExcel.Selection.HorizontalAlignment := xlCenter;
    MyExcel.Selection.Font.Name := 'Calibri';
    MyExcel.Selection.Font.Size := 16;
    MyExcel.Selection.Font.Bold := True;
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[1, 1] :=
      '�������� �� ������� ��� "���������" ��  ' + DateTimeToStr(Now);

    // ----------------- ����� ������� --------------------------------------
    ExcelApp := MyExcel.ActiveWorkBook.Worksheets[1].Rows;

    ExcelApp.Rows[3].RowHeight := 31.50;
    ExcelApp.Rows[5].RowHeight := 21.00;
    ExcelApp.Rows[6].RowHeight := 21.00;
    ExcelApp.Rows[7].RowHeight := 21.00;
    ExcelApp.Rows[8].RowHeight := 30.00;
    ExcelApp.Rows[9].RowHeight := 21.00;
    ExcelApp.Rows[10].RowHeight := 21.00;
    ExcelApp.Rows[11].RowHeight := 30.00;

    MyExcel.ActiveWorkBook.Worksheets[1].Range['A3:U15'].Select;
    MyExcel.Selection.HorizontalAlignment := xlCenter;
    MyExcel.Selection.VerticalAlignment := xlCenter;
    MyExcel.Selection.Font.Size := 8;

    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 1] := '���';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 2] := '������';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 3] := '������������';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 3].WrapText := True;
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 4] := '��';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 5] := '���';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 6] := '��O';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 7] := '��';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 8] := '�볺���';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 9] := '��� 0-17';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 10] := 'Ѳ';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 11] := '�����';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 12] := '����';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 13] := '���������';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 13].WrapText := True;
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 14] := '����������';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 14].WrapText := True;
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 15] := '�';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 16] := '�';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 17] := '66-75';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 18] := '76-85';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 19] := '86+';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 20] := '���������';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 20].WrapText := True;
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 21] := '��������� ��������';
    MyExcel.ActiveWorkBook.Worksheets[1].Cells[3, 21].WrapText := True;

    for i := 1 to grid.RowCount - 1 do // ������
    begin

      for j := 1 to grid.col - 1 do
      // ColCount - 1 do // �������
      begin
        // val := grid.;

      end;

    end;

    Sheets := unassigned;
    ExcelApp := unassigned;
    uMyExcel.StopExcel;

  except
    on E: Exception do
    begin
      Sheets := unassigned;
      ExcelApp := unassigned;
      uMyExcel.StopExcel;
      myForm.ProgressBar.Visible := False;
    end;
  end;

end;

end.
