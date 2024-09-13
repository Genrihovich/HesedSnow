unit uFrameDavayPodkl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, System.Generics.Collections, Winapi.ShellAPI,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameCustom,
  Vcl.StdCtrls, DateUtils, Data.DB, sComboBox, System.Actions, Vcl.ActnList,
  Vcl.Grids, JvExGrids, JvStringGrid, Vcl.DBGrids, acDBGrid, Vcl.ExtCtrls,
  Vcl.Buttons, sBitBtn, sPanel, sFrameAdapter;

type
  TfrmFrameDavayPodkl = class(TCustomInfoFrame)
    btnDownloadUslugy: TsBitBtn;
    btnOtchet: TsBitBtn;
    sDBGrid1: TsDBGrid;
    sPanel1: TsPanel;
    sPanel2: TsPanel;
    sPanel3: TsPanel;
    Splitter1: TSplitter;
    btnCreateExcel: TsBitBtn;
    ActionList: TActionList;
    abtnCreateExcel: TAction;
    StringGrid: TJvStringGrid;
    btnZahody: TsBitBtn;
    cbMonth: TsComboBox;
    abtnDounloadZvitFile: TAction;
    procedure btnDownloadUslugyClick(Sender: TObject);
    procedure btnOtchetClick(Sender: TObject);
    procedure abtnCreateExcelUpdate(Sender: TObject);
    procedure btnCreateExcelClick(Sender: TObject);
    procedure btnZahodyClick(Sender: TObject);
    procedure abtnDounloadZvitFileUpdate(Sender: TObject);
    procedure cbMonthChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AfterCreation; override;
  end;

var
  begin_date, end_date: String;

implementation

{$R *.dfm}

uses uBDlogic, uDataModul, uMyExcel, uMainForm, uMyProcedure, uFrameSLG;

procedure TfrmFrameDavayPodkl.abtnCreateExcelUpdate(Sender: TObject);
begin
  inherited;
  if (StringGrid.RowCount > 1) then
    btnCreateExcel.Enabled := true
  else
    btnCreateExcel.Enabled := false;
end;

procedure TfrmFrameDavayPodkl.btnCreateExcelClick(Sender: TObject);
var
  Sheets, ExcelApp: variant;
  FileNameS, DirectoryNow: String;
  i, j, k: Integer;
  NumUslugy, JDCID, FIO, DataMeropriatiya: string;
begin
  inherited;

  if uMyExcel.RunExcel(false, false) = true then
    MyExcel.Workbooks.Add; // ��������� ����� �����

  Sheets := MyExcel.Worksheets.Add;
  Sheets.name := 'A1';
  ParametryStr; // �������� ��������
  Sheets.PageSetup.PrintTitleRows := '$2:$2';

  // ��������� ������� ( ����� ����� ������� ) ������ ��������

  ExcelApp := MyExcel.ActiveWorkBook.Worksheets[1].columns;

  ExcelApp.columns[1].columnwidth := 13.5;
  ExcelApp.columns[2].columnwidth := 13.5;
  ExcelApp.columns[2].NumberFormat := '@';
  ExcelApp.columns[3].columnwidth := 40;
  ExcelApp.columns[4].columnwidth := 40;
  ExcelApp.columns[5].columnwidth := 13.5;
  ExcelApp.columns[5].NumberFormat := '@';
  ExcelApp.columns[6].columnwidth := 10;
  ExcelApp.columns[7].columnwidth := 10;
  ExcelApp.columns[8].columnwidth := 10;

  MyExcel.Range['A1'].value := '����� ������';
  MyExcel.Range['B1'].value := 'JDC ID';
  MyExcel.Range['C1'].value := '���';
  MyExcel.Range['D1'].value := '�����������';
  MyExcel.Range['E1'].value := '���� �����������';
  MyExcel.Range['F1'].value := '���������';
  MyExcel.Range['G1'].value := '����������';
  MyExcel.Range['H1'].value := '����������';

  k := 2; // ������� ����� � �������������� ������ c 2 �� 1 - �����

  for i := 1 to StringGrid.RowCount - 1 do // ������
  begin
    JDCID := Trim(StringGrid.Cells[1, i]);
    FIO := StringGrid.Cells[2, i];

    for j := 3 to StringGrid.ColCount - 1 do // �������
    begin
      if StringGrid.Cells[j, i] = '1' then // 4-q �������
      begin

        MyExcel.Cells[k, 2] := JDCID; // jgcid
        MyExcel.Cells[k, 3] := FIO; // fio

        DataMeropriatiya := StringGrid.Cells[j, 0];
        MyExcel.Cells[k, 5] := DataMeropriatiya; // ����
        MyExcel.Cells[k, 4] := SearchPoziciyString('TemaDavayPodkl', 'Data',
          DataMeropriatiya, 'Tema'); // �����������

        // NumUslugy := SearchPoziciyString('Uslugy', 'JDCID', JDCID, 'RITM');
        NumUslugy := SearchPoziciyString('Vidomist', 'JDCID', JDCID,
          'Num_Uslugy');
        MyExcel.Cells[k, 1] := NumUslugy; // num usluga

        AutoStringGridWidth(StringGrid);

        Inc(k);
      end;

    end;
  end;

  DirectoryNow := ExtractFilePath(ParamStr(0)) + '������\����\';
  if not DirectoryExists('DirectoryNow') then
    ForceDirectories(DirectoryNow);

  FileNameS := DirectoryNow + '������� �����������_' +
    FormatDateTime('dd.mm.yyyy', Now) + '.xlsx';

  uMyExcel.SaveWorkBook(FileNameS, 1);

  Sheets := unassigned;
  ExcelApp := unassigned;
  uMyExcel.StopExcel;

  ShowMessage('������ �������������� � ��������� � ����');

  // ��������� ����� � �����������
  ShellExecute(Handle, 'open', PWideChar(DirectoryNow), nil, nil,
    SW_SHOWNORMAL);
end;

procedure TfrmFrameDavayPodkl.btnDownloadUslugyClick(Sender: TObject);
begin
  inherited;
  DM.tVedomost.Open;
  ImportExcelToBD;
  DM.tVedomost.Active := true;
  // DBGridEhVedomist.DataSource := DM.dsVedomist;
  btnDownloadUslugy.Kind := bkAll;
  btnDownloadUslugy.Caption := '���� � ��������� �����������';
end;

procedure TfrmFrameDavayPodkl.btnOtchetClick(Sender: TObject);
var
  colfix, col, m, n, z, k, l: Integer;
  Data, Tema: string;
  a, b, t,y, c: string;
  d, e: string;
  FileNameS, DirectoryNow: String;
  Zahods: TStringList;
begin
  inherited;
  try

    DM.tTemaDavayPodkl.Active := false;
    DM.tTemaDavayPodkl.Active := true;

    colfix := 100; // ����� �������� ����� ������� ��� JDCID

    if uMyExcel.RunExcel(false, false) = true then
      // �������� �� ������� � ������ Excel
      myForm.OpenDialog.Filter := '����� MS Excel|*.xls;*.xlsx|';
    if not myForm.OpenDialog.Execute then
      Exit;

    // ��������� ����� Excel
    if uMyExcel.OpenWorkBook(myForm.OpenDialog.FileName, false) then

    begin

      // MyExcel.Workbooks[1].Worksheets.Count; //���-�� ������ � ���������
      myForm.ProgressBar.Visible := true;
      MyExcel.ActiveWorkBook.Sheets[1];

      // ��������� ����������� �������
      col := MyExcel.ActiveCell.SpecialCells($000000B).Column;

      m := 10; // �������� ���������� �� 9-� ������, �������� ��������� �������
      // ��������� ����������� ������
      n := MyExcel.ActiveCell.SpecialCells($000000B).Row;

      n := n + 1;
      with DM, myForm do
      begin
        qTemaDP.Active := false;
        CleanOutTable('TemaDavayPodkl'); // �������� �������
        l := 1; // ������� ����� �����(����� ������ ��� �����)

        ProgressBar.Min := 0;
        ProgressBar.Max := n;
        ProgressBar.Position := 1;

        while m <> n do // ����  �� ������� EXCEL
        begin
          for z := 1 to col do // ���� �� ��������
          begin
            a := Trim(MyExcel.Cells[m, z].value);
            b := MyExcel.Cells[m, z + 1].value;
            t:= Trim(MyExcel.Cells[m, z+2].value);
            y:= MyExcel.Cells[m, z + 3].value;

            // ================== 1 =====================
            if (a = '����') then
            begin
              Data := MyExcel.Cells[m, z + 1].value;
              if Data <> '' then
              begin
               // ��������� ��� ������ � �������� �������� ����
                if not isDateBetween(begin_date, end_date, Data) then
                  Data := RecoveryDate(begin_date, Data);

                MyExcel.Cells[m, z + 1].NumberFormat := '@';
                MyExcel.Cells[m, z + 1].value := Data;

              end;


            end;

            if (t = '����') then
              // ��������� �� ������� � ������ ������� ������
              Tema := Trim(ReplaceChar(MyExcel.Cells[m, z + 3].value));



            if (Data <> '') and (Tema <> '') then
            begin
              tTemaDavayPodkl.Insert;
              tTemaDavayPodkl.FieldByName('Data').AsString := Data;
              tTemaDavayPodkl.FieldByName('Tema').AsString := Tema;
              tTemaDavayPodkl.Post;
              Data := '';
              Tema := '';
              Application.ProcessMessages;
//            end
//            else // ���� ��� ���� ��� ����
//            begin
//              ShowMessage('�� �������� ���� ��� ��� ������');
//              CleanOutTable('TemaDavayPodkl'); // �������� �������
//              DM.tTemaDavayPodkl.Active := false;
//              StopExcel;
//              ProgressBar.Position := 1;
//              ProgressBar.Visible := false;
//              Exit;
            end;







            c := MyExcel.Cells[m, colfix].value;

            if (MyExcel.Cells[m, colfix].value <> '') then
            begin
              // ���������� ������
              StringGrid.RowCount := StringGrid.RowCount + 1;

              d := MyExcel.Cells[m, colfix].value;
              e := MyExcel.Cells[m, colfix + 1].value;

              StringGrid.Cells[0, l] := l.ToString; // ��/�
              StringGrid.Cells[1, l] := d; // JDCID
              StringGrid.Cells[2, l] := e; // ���

              for k := 0 to DM.qTemaDP.RecordCount - 1 do
              begin
                StringGrid.Cells[k + 3, l] :=
                  MyExcel.Cells[m, k + colfix + 2].value;
                Application.ProcessMessages;
              end;

              AutoStringGridWidth(StringGrid);
              Inc(l); // ��������� ������
              ProgressBar.Position := m;
              Break;
            end;


            // ================= 2 ================

            // ���������� ������ ������� JDC ID
            if (a = 'JDC ID') and (b = '���') then
            begin
              colfix := z;

              // ��������� �����
              StringGrid.RowCount := 1;
              DM.qTemaDP.Active := true;
              StringGrid.ColCount := DM.qTemaDP.RecordCount + 3;

              StringGrid.Cells[0, 0] := '� �/�';
              StringGrid.Cells[1, 0] := 'JDC ID';
              StringGrid.Cells[2, 0] := '���';
              DM.qTemaDP.First;
              for k := 0 to DM.qTemaDP.RecordCount - 1 do
              begin
                StringGrid.Cells[k + 3, 0] :=
                  DM.qTemaDP.FieldByName('Data').AsString;
                DM.qTemaDP.Next;
                Application.ProcessMessages;
              end;
              Break;
            end;
            // ==============================================
            ProgressBar.Position := m;
          end;
          Inc(m);
        end;

        // ============== ������� ������ ����� ����������� =================
        with DM do
        begin
          tTemaDavayPodkl.Active := false;
          tTemaDavayPodkl.Active := true;
          tZahody.Active := true;

          Zahods := TStringList.Create;

          tTemaDavayPodkl.First;
          for z := 0 to tTemaDavayPodkl.RecordCount - 1 do
          begin
            Tema := tTemaDavayPodkl.FieldByName('Tema').AsString;

            qZahody.Active := false;
            qZahody.SQL.Clear;
            qZahody.SQL.Add
              ('select * From Zahody Where  (((Zahody.�����������)="' +
              Tema + '"))');
            FileNameS := qZahody.SQL.Text;

            qZahody.Active := true;
            if qZahody.RecordCount = 0 then
            begin // ���� ��� ����������� �� ������ ��� � ���� � � ����
              Zahods.Add(Tema);
              tZahody.Insert;
              tZahody.FieldByName('�������������').AsString := '�����';
              tZahody.FieldByName('�����������').AsString := Tema;
              tZahody.Post;
            end;
            tTemaDavayPodkl.Next;
          end;

          if Zahods.Count > 0 then
          // ���� ���������� �� ������ �� ��������� � ����
          begin
            DirectoryNow := ExtractFilePath(ParamStr(0)) + '������\����\';
            if not DirectoryExists('DirectoryNow') then
              ForceDirectories(DirectoryNow);
            FileNameS := DirectoryNow + '����� ������� �����������_' +
              FormatDateTime('dd.mm.yyyy', Now) + '.txt';

            Zahods.SaveToFile(FileNameS);
          end;

          Zahods.Free;
          tZahody.Active := false;
        end;

      end;
    end;

    MyExcel.Application.DisplayAlerts := false;
    StopExcel;
    myForm.ProgressBar.Visible := false;
    DM.qTemaDP.Active := true;

  except
    on e: EListError do
    begin
      CleanOutTable('TemaDavayPodkl'); // �������� �������
      DM.tTemaDavayPodkl.Active := false;
      ShowMessage('�� ����� ������ �����, ���� ���������� ����');
      StopExcel;
    end;
  end;
  btnOtchet.Kind := bkAll;
  btnOtchet.Caption := '������ ���� �����������';

end;

procedure TfrmFrameDavayPodkl.btnZahodyClick(Sender: TObject);
var
  col, m, n, z: Integer;
  CollectionNameTable: TDictionary<string, Integer>;
begin
  inherited;

  DM.tZahody.Active := false;
  DM.tZahody.Active := true;
  if uMyExcel.RunExcel(false, false) = true then
    // �������� �� ������� � ������ Excel
    myForm.OpenDialog.Filter := '����� MS Excel|*.xls;*.xlsx|';
  if not myForm.OpenDialog.Execute then
    Exit;

  // ��������� ����� Excel
  if uMyExcel.OpenWorkBook(myForm.OpenDialog.FileName, false) then
  begin
    // MyExcel.Workbooks[1].Worksheets.Count; //���-�� ������ � ���������
    myForm.ProgressBar.Visible := true;
    MyExcel.ActiveWorkBook.Sheets[1];

    // ��������� ����������� �������
    col := MyExcel.ActiveCell.SpecialCells($000000B).Column;

    // ------------ ���������� ��������� ������� �������� �������� -------------

    CollectionNameTable := TDictionary<string, Integer>.Create();
    for z := 1 to col do
    begin
      if not CollectionNameTable.ContainsKey(MyExcel.Cells[1, z].value) then
        CollectionNameTable.Add(MyExcel.Cells[1, z].value, z)
      else
        CollectionNameTable.Add(MyExcel.Cells[1, z].value + z.ToString, z);
    end;
    // ------------------------ ����� ������� ���  �������� --------------------

    m := 2; // �������� ���������� �� 2-� ������, �������� ��������� �������
    // ��������� ����������� ������
    n := MyExcel.ActiveCell.SpecialCells($000000B).Row;
    n := n + 1;
    with DM, myForm do
    begin
      CleanOutTable('Zahody'); // �������� �������

      ProgressBar.Min := 0;
      ProgressBar.Max := n;
      ProgressBar.Position := 1;

      while m <> n do // ����  �� ������� EXCEL
      begin
        tZahody.Insert;
        tZahody.FieldByName('�����������').AsString :=
          MyExcel.Cells[m, StrToInt(CollectionNameTable.Items['�����������']
          .ToString)].value;
        tZahody.FieldByName('�������������').AsString :=
          MyExcel.Cells[m, StrToInt(CollectionNameTable.Items['�������������']
          .ToString)].value;

        tZahody.Post;
        Inc(m);
        ProgressBar.Position := m;
      end;
      ShowMessage('������������ ����� ��ϲ���!!!');

    end;
    MyExcel.Application.DisplayAlerts := false;
    StopExcel;
    CollectionNameTable.Clear;
    CollectionNameTable.Free;
    DM.tVedomost.Active := false;
    myForm.ProgressBar.Visible := false;
  end;

end;

procedure TfrmFrameDavayPodkl.cbMonthChange(Sender: TObject);
begin
  begin_date := DateTimeToStr(EncodeDateTime(YearOf(Now),
    (cbMonth.ItemIndex + 1), 1, 0, 0, 0, 0));
  end_date := DateToStr(EndOfTheMonth(StrToDateTime(begin_date)));
end;

procedure TfrmFrameDavayPodkl.abtnDounloadZvitFileUpdate(Sender: TObject);
begin
  inherited;
  if (cbMonth.Text = '') then
  begin
    btnOtchet.Enabled := false;
    btnZahody.Enabled := false;
    btnDownloadUslugy.Enabled := false;
  end
  else
  begin
    btnOtchet.Enabled := true;
    btnZahody.Enabled := true;
    btnDownloadUslugy.Enabled := true;
  end;
end;

procedure TfrmFrameDavayPodkl.AfterCreation;
begin
  inherited;
  MonthComboBox(cbMonth);
  cbMonth.Text := '';
end;

end.
