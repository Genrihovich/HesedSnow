unit uFrameUtils;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uFrameCustom,
  sFrameAdapter, Vcl.ComCtrls, sMemo, Vcl.Buttons, sBitBtn, Vcl.Grids,
  JvExGrids, JvStringGrid, Data.DB, Vcl.DBGrids, sRichEdit, ShellAPI,
  System.Generics.Collections, sListView, sListBox, sCheckListBox, sLabel,
  System.Actions, Vcl.ActnList, sCheckBox;

type
  TfrmUtils = class(TCustomInfoFrame)
    sBitBtn1: TsBitBtn;
    mInSpisok: TsMemo;
    mOutSpisok: TsRichEdit;
    btnKillNumber: TsBitBtn;
    lwColumn: TsListView;
    lbFileName: TsLabel;
    sLabel1: TsLabel;
    lbFirstParam: TsLabel;
    lbSecondParam: TsLabel;
    sLabel4: TsLabel;
    btnPerevPoliv: TsBitBtn;
    acList: TActionList;
    acBtnPerevPoliv: TAction;
    btnDviniky: TsBitBtn;
    lbFirdParam: TsLabel;
    acBtnDviynik: TAction;
    chbCampare: TsCheckBox;
    procedure sBitBtn1Click(Sender: TObject);
    procedure btnKillNumberClick(Sender: TObject);
    procedure lbFirstParamDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbFirstParamDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbSecondParamDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure btnPerevPolivClick(Sender: TObject);
    procedure acBtnPerevPolivUpdate(Sender: TObject);
    procedure lbFirdParamDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure acBtnDviynikUpdate(Sender: TObject);
    procedure btnDvinikyClick(Sender: TObject);
  private
    { Private declarations }

    procedure AddColoredLine(ARichEdit: TRichEdit; AText: string;
      AColor: TColor);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure CampareDropFileInBD(fN: string);

  public
    procedure AfterCreation; override;
    procedure BeforeDestruct; virtual;
    { Public declarations }

  end;

implementation

{$R *.dfm}

uses uMyProcedure, uDataModul, uMyExcel, uMainForm, uBDlogic;

procedure TfrmUtils.AfterCreation;
begin
  inherited;
  DragAcceptFiles(Handle, true);
end;

procedure TfrmUtils.BeforeDestruct;
begin
  DragAcceptFiles(Handle, False);
end;

procedure TfrmUtils.acBtnPerevPolivUpdate(Sender: TObject);
begin
  inherited;
  if (((lbFirstParam.Caption <> '1-� ��������') and (lbSecondParam.Caption <>
    '2-� ��������')) and (lbFirstParam.Caption <> lbSecondParam.Caption)) then
    btnPerevPoliv.Enabled := true
  else
    btnPerevPoliv.Enabled := False;
end;

procedure TfrmUtils.AddColoredLine(ARichEdit: TRichEdit; AText: string;
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

procedure TfrmUtils.btnKillNumberClick(Sender: TObject);
var
  i: Integer;
  s, t: String;
  NewSpisok: TStrings;
begin // ������ ��������� �� ������
  inherited;
  NewSpisok := TStrings.Create;

  for i := 0 to mInSpisok.Lines.Count - 1 do
  begin
    s := Trim(mInSpisok.Lines[i]);
    t := myRemoveNum(s);
    // NewSpisok.Insert(i,t);
    mInSpisok.Lines.Strings[i] := t;

  end;

  // mInSpisok.Lines := NewSpisok;
  NewSpisok.Free;
end;

procedure TfrmUtils.sBitBtn1Click(Sender: TObject);
var
  i, j: Integer;
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
        // ��������� ������ �� �����
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
          // ��������� ������ ����� ��� ���� ����� ��� ��� ��������� �����

          // str := N;
          str := DelSymbolIntoString(N, '.');

          if LastDelimiter('.', str) > 0 then
          begin
            // ���� �����
            N := Copy(str, 1, Pos('.', str) - 1);
            O := DelSymbolIntoString(Copy(str, Pos('.', str) + 1), '.');

            SQLText := 'Like "%' + F + ' ' + N + '%"';
          end
          else
          begin
            // ���� ��� ����� � ����� ������ 2 �� ��� ���
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
          // ��������� ������ � ������ ����� ��� ���� �����

          SQLText := 'Like "%' + F + ' ' + N + '%"';

        end;

      finally
        Client.Free;
      end;

      // zapros

      begin
        with DM.qQuery do
        begin
          Active := False;
          Close;
          SQL.Clear;
          SQL.Add('SELECT Uchastniky.[JDC ID], Uchastniky.��� FROM Uchastniky WHERE (((Uchastniky.���) '
            + SQLText + '));');

          s := SQL.Text;
          Active := true;

          if RecordCount = 1 then
          begin
            mOutSpisok.Lines.Add(FieldbyName('���').asString);
            // mOutSpisok.Lines.Add(FieldbyName('JDC ID').asString + ' ' + FieldbyName('���').asString);
          end;
          if RecordCount > 1 then
          begin
            // mOutSpisok.Font.Color := clRed;
            // AddColoredLine(ARichEdit: TRichEdit; AText: string;
            // AddColoredLine(RichEdit1, 'Hallo', clRed);
            for j := 0 to RecordCount - 1 do
            begin

              txt := FieldbyName('���').asString;
              // txt := FieldbyName('JDC ID').asString + ' ' + FieldbyName('���').asString;
              AddColoredLine(mOutSpisok, txt, clRed);

              next;

            end;

            // mOutSpisok.Font.Color := clBlack;

          end;

        end;
      end;

    end;

  end;

end;

procedure TfrmUtils.lbFirdParamDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  inherited;
  if Source = lwColumn then
    lbFirdParam.Caption := lwColumn.Selected.Caption;
end;

procedure TfrmUtils.lbSecondParamDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  inherited;
  if Source = lwColumn then
    lbSecondParam.Caption := lwColumn.Selected.Caption;
end;

procedure TfrmUtils.WMDropFiles(var Msg: TWMDropFiles);
const
  maxlen = 254;
var
  h: THandle;
  pchr: array [0 .. maxlen] of char;
  fname: string;
begin
  h := Msg.Drop;
  DragQueryFile(h, 0, pchr, maxlen);
  fname := string(pchr);

  lbFirstParam.Caption := '1-� ��������';
  lbSecondParam.Caption :='2-� ��������';
  chbCampare.Checked := False;

  if lowercase(extractfileext(fname)) = '.xlsx' then
  begin
    lwColumn.Items.Clear;
    lbFileName.Caption := fname;

    CampareDropFileInBD(fname);
  end;

  DragFinish(h);
end;

procedure TfrmUtils.CampareDropFileInBD(fN: string);
var
  i, z, col, m, N: Integer;

begin
  try
    with myForm, DM do
    begin
      // �������� �� ������� � ������ Excel
      if uMyExcel.RunExcel(False, False) = true then
        // ��������� ����� Excel
        if uMyExcel.OpenWorkBook(fN, False) then
        begin
          MyExcel.ActiveWorkBook.Sheets[1];
          // ��������� ����������� �������
          col := MyExcel.ActiveCell.SpecialCells($000000B).Column;

          for z := 1 to col do
            lwColumn.Items.Add.Caption := (MyExcel.Cells[1, z].value);
        end;

      MyExcel.Application.DisplayAlerts := False;
      StopExcel;

    end;
  except
    on E: Exception do
    begin
      ShowMessage('�� ����� ������ �����, ���� ���������� ����');
      MyExcel.Application.DisplayAlerts := False;
      StopExcel;
    end;
  end;

end;

procedure TfrmUtils.lbFirstParamDragDrop(Sender, Source: TObject;
  X, Y: Integer);
begin
  inherited;
  if Source = lwColumn then
    lbFirstParam.Caption := lwColumn.Selected.Caption;
end;

procedure TfrmUtils.lbFirstParamDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept := Source = lwColumn;
end;

procedure TfrmUtils.btnPerevPolivClick(Sender: TObject);
var
  cols, raws, z, m: Integer;
  CollectionNameExcelColumn: TDictionary<string, Integer>;
  ColumnNameExcel, value1, param1, value2, param2, fioBD, jdcBD: String;
  SumExcel, typeDohod, tDohodBD: String;
begin // ---------- �������� ���� ---------
  try
    with myForm, DM do
    begin
      // �������� �� ������� � ������ Excel
      if uMyExcel.RunExcel(False, False) = true then
        // ��������� ����� Excel
        if uMyExcel.OpenWorkBook(lbFileName.Caption, False) then
        begin
          ProgressBar.Visible := true;
          MyExcel.ActiveWorkBook.Sheets[1];
          // ��������� ����������� �������
          cols := MyExcel.ActiveCell.SpecialCells($000000B).Column;
          // ��������� ����������� ������
          raws := MyExcel.ActiveCell.SpecialCells($000000B).Row;

          // ------------ ���������� ��������� ������� �������� ������ �������� ---------
          CollectionNameExcelColumn := TDictionary<string, Integer>.Create();

          for z := 1 to cols do
          begin
            ColumnNameExcel := MyExcel.Cells[1, z].value;

            if not CollectionNameExcelColumn.ContainsKey
              (MyExcel.Cells[1, z].value) then
              CollectionNameExcelColumn.Add(MyExcel.Cells[1, z].value, z)
            else // ���� ���� ��� ����� ���� �� � ����� ��������� �����
              CollectionNameExcelColumn.Add(MyExcel.Cells[1, z].value +
                inttostr(z), z);
          end;

          m := 2; // �������� ���������� �� 2-� ������, �������� ��������� �������
          raws := raws + 1;

          ProgressBar.Min := 0;
          ProgressBar.Max := raws;
          ProgressBar.Position := 1;

          while m <> raws do // ���� ������� �� ������� EXCEL
          begin
            param1 := lbFirstParam.Caption;
            value1 := MyExcel.Cells
              [m, StrToInt(CollectionNameExcelColumn.Items[param1]
              .ToString)].value;
            param2 := lbSecondParam.Caption;
            value2 := MyExcel.Cells
              [m, StrToInt(CollectionNameExcelColumn.Items[param2]
              .ToString)].value;

            fioBD := SearchPoziciyString('Uchastniky', param1, value1, param2);
            jdcBD := SearchPoziciyString('Uchastniky', param1, value1, param1);

            // ��� � ����� �� ����� ��� � BD
            if value2 <> fioBD then // ��� � ����� �� ����� ��� � BD
            begin
              mOutSpisok.Lines.Add(m.ToString + ':- ' + value1 + ' ' + value2);

              // ���� � ������ ����� ��� ���� ����
              if value1.Length < 10 then
                mOutSpisok.Lines.Add('�������� � JDCID - ' + value1);
              if value1.Length > 10 then
                mOutSpisok.Lines.Add('�������� � �������� JDCID - ' + value2);

              if value1.Length = 10 then
              begin

                if ((jdcBD = 'Error ����� �� ��������') and
                  (fioBD = 'Error ����� �� ��������')) then
                  mOutSpisok.Lines.Add
                    (value2 + ' : ���� ���������� � ����� ����������')
                else if ((fioBD = 'Error ����� �� ��������') and
                  (jdcBD <> 'Error ����� �� ��������')) then
                  mOutSpisok.Lines.Add('�������� � JDCID - ' + value2)
                else if ((fioBD <> 'Error ����� �� ��������') and
                  (jdcBD <> 'Error ����� �� ��������')) then

                  if fioBD.Length <> value2.Length then
                  begin
                    mOutSpisok.Lines.Add('BD  : ' + fioBD + '(' +
                      fioBD.Length.ToString + ') - �������� � �������� � ϲ�');
                    mOutSpisok.Lines.Add('File : ' + value2 + '(' +
                      value2.Length.ToString + ')');
                  end
                  else
                    mOutSpisok.Lines.Add(fioBD + ' <> ' + value2);
              end;

              mOutSpisok.Lines.Add('');
            end;

            // �������� ������� ��������� � ���� ������
            if chbCampare.Checked then
            begin
             // ---- ���� ----
             SumExcel := MyExcel.Cells
              [m, StrToInt(CollectionNameExcelColumn.Items['�����'].ToString)].value;

               if AnsiContainsStr(SumExcel, ',') then
               begin //������� ����!
                SumExcel := SumExcel.Replace(',', '.');
                MyExcel.Cells[m, 4].value := SumExcel;
               end;

             // ��� ������
             typeDohod := MyExcel.Cells
              [m, StrToInt(CollectionNameExcelColumn.Items['��� ������'].ToString)].value;

              // ����� �������� ���� � �������
             tDohodBD := SearchPoziciyString('VidDohod', 'TypeDohod', typeDohod, 'TypeDohod');
             if typeDohod <> tDohodBD then
             begin
               mOutSpisok.Lines.Add(m.ToString + ':- ������� ���� ������: - ' + typeDohod);
               mOutSpisok.Lines.Add('');
             end;
            end;

                MyExcel.Application.DisplayAlerts := False;
                uMyExcel.SaveWorkBook(lbFileName.Caption, 1);

            Inc(m);
            // Application.ProcessMessages;
            Sleep(25);
            ProgressBar.Position := m;
          end;

        end;

      MyExcel.Application.DisplayAlerts := False;
      StopExcel;
      CollectionNameExcelColumn.Clear;
      CollectionNameExcelColumn.Free;
      ProgressBar.Visible := False;
      ProgressBar.Position := 0;
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

procedure TfrmUtils.acBtnDviynikUpdate(Sender: TObject);
begin
  if lbFirdParam.Caption <> '�� ����� ���� ��������' then
    btnDviniky.Enabled := true
  else
    btnDviniky.Enabled := False;
end;

procedure TfrmUtils.btnDvinikyClick(Sender: TObject);
var
  cols, raws, z, m: Integer;
  NameValue: String;
  NameDict, CollectionNameExcelColumn: TDictionary<string, Integer>;
  DuplicatesList: TStringList;
begin // ����� �������
  inherited;
  CollectionNameExcelColumn := nil;
  try
    // ������� ������� ��� �������� ����������
    NameDict := TDictionary<string, Integer>.Create;
    DuplicatesList := TStringList.Create;

    with myForm, DM do
    begin
      // �������� �� ������� � ������ Excel
      if uMyExcel.RunExcel(False, False) = true then
        // ��������� ����� Excel
        if uMyExcel.OpenWorkBook(lbFileName.Caption, False) then
        begin
          ProgressBar.Visible := true;
          MyExcel.ActiveWorkBook.Sheets[1];
          // ��������� ����������� �������
          cols := MyExcel.ActiveCell.SpecialCells($000000B).Column;
          // ��������� ����������� ������
          raws := MyExcel.ActiveCell.SpecialCells($000000B).Row;

          // ------------ ���������� ��������� ������� �������� ������ �������� ---------
          CollectionNameExcelColumn := TDictionary<string, Integer>.Create();

          for z := 1 to cols do
          begin
            // ColumnNameExcel := MyExcel.Cells[1, z].value;

            if not CollectionNameExcelColumn.ContainsKey
              (MyExcel.Cells[1, z].value) then
              CollectionNameExcelColumn.Add(MyExcel.Cells[1, z].value, z)
            else // ���� ���� ��� ����� ���� �� � ����� ��������� �����
              CollectionNameExcelColumn.Add(MyExcel.Cells[1, z].value +
                inttostr(z), z);
          end;

          m := 2; // �������� ���������� �� 2-� ������, �������� ��������� �������
          raws := raws + 1;

          ProgressBar.Min := 0;
          ProgressBar.Max := raws;
          ProgressBar.Position := 1;
          while m <> raws do // ���� ������� �� ������� EXCEL
          begin
            NameValue := MyExcel.Cells
              [m, StrToInt(CollectionNameExcelColumn.Items[lbFirdParam.Caption]
              .ToString)].value;
            // ��������� ��������
            if NameValue <> '' then
            begin
              if NameDict.ContainsKey(NameValue) then
              begin
                // ���� ��� �����������, ��������� � ������ ����������
                DuplicatesList.Add(Format('��������: "%s" (������ %d)',
                  [NameValue, m]));
              end
              else
              begin
                // ���� �� �����������, ��������� � �������
                NameDict.Add(NameValue, m);
              end;
            end;

            Inc(m);
            ProgressBar.Position := m;
          end;

          // ������� ��������� ��������� � Memo
          if DuplicatesList.Count > 0 then
            mOutSpisok.Lines.Assign(DuplicatesList)
          else
            mOutSpisok.Lines.Add('��������� �� �������.');

        end;
      MyExcel.Application.DisplayAlerts := False;
      StopExcel;
      ProgressBar.Visible := False;
      ProgressBar.Position := 0;
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

end.
