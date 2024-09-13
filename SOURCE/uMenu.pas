unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  sBitBtn, sFrameAdapter;

type
  TfrmMenu = class(TFrame)
    btnSLG: TsBitBtn;
    btnNalogy: TsBitBtn;
    sFrameAdapter1: TsFrameAdapter;
    btnCreateVidom: TsBitBtn;
    btnDavayPodkl: TsBitBtn;
    btnUtils: TsBitBtn;
    btnImportBD: TsBitBtn;
    btnZvitBank: TsBitBtn;
    btnDohod: TsBitBtn;
    btnAnalitik: TsBitBtn;
    procedure btnVidomistClick(Sender: TObject);
    procedure btnSLGClick(Sender: TObject);
    procedure btnNalogyClick(Sender: TObject);
    procedure btnDavayPodklClick(Sender: TObject);
    procedure btnUtilsClick(Sender: TObject);
    procedure btnImportBDClick(Sender: TObject);
    procedure btnZvitBankClick(Sender: TObject);
    procedure btnDohodClick(Sender: TObject);
    procedure btnAnalitikClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uFrameVidomist, uMainForm, uFrameSLG, uFrameNalogy, uFrameDavayPodkl,
  uFrameUtils, uFrameImportBD, uFrameZvitBank, uDohod, uFrameAnalitic;

procedure TfrmMenu.btnAnalitikClick(Sender: TObject);
begin
myForm.CreateNewFrame(TfrmAnalitic, Sender);
end;

procedure TfrmMenu.btnDavayPodklClick(Sender: TObject);
begin
  myForm.CreateNewFrame(TfrmFrameDavayPodkl, Sender);
end;

procedure TfrmMenu.btnDohodClick(Sender: TObject);
begin
 myForm.CreateNewFrame(TfrmDohod, Sender);
end;

procedure TfrmMenu.btnImportBDClick(Sender: TObject);
begin
  myForm.CreateNewFrame(TfrmImportBD, Sender);
end;

procedure TfrmMenu.btnNalogyClick(Sender: TObject);
begin
  myForm.CreateNewFrame(TfrmNalogy, Sender);
end;

procedure TfrmMenu.btnSLGClick(Sender: TObject);
begin
  myForm.CreateNewFrame(TfrmSLG, Sender);
end;

procedure TfrmMenu.btnUtilsClick(Sender: TObject);
begin
  myForm.CreateNewFrame(TfrmUtils, Sender);
end;

procedure TfrmMenu.btnVidomistClick(Sender: TObject);
begin
  myForm.CreateNewFrame(TfrmVidomost, Sender);
end;

procedure TfrmMenu.btnZvitBankClick(Sender: TObject);
begin
  myForm.CreateNewFrame(TfrmZvitBank, Sender);
end;

end.
