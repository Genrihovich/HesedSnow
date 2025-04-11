program HesedSnow;

uses
  Vcl.Forms,
  uMainForm in '..\SOURCE\uMainForm.pas' {myForm},
  uFrameCustom in '..\SOURCE\uFrameCustom.pas' {CustomInfoFrame: TFrame},
  uMenu in '..\SOURCE\uMenu.pas' {frmMenu: TFrame},
  uFrameVidomist in '..\SOURCE\uFrameVidomist.pas' {frmVidomost: TFrame},
  uFrameSLG in '..\SOURCE\uFrameSLG.pas' {frmSLG: TFrame},
  uFrameClubs in '..\SOURCE\uFrameClubs.pas' {frmClubs: TFrame},
  uMyProcedure in '..\SOURCE\uMyProcedure.pas',
  uMyExcel in '..\SOURCE\uMyExcel.pas',
  uDataModul in '..\SOURCE\uDataModul.pas' {DM: TDataModule},
  uBDlogic in '..\SOURCE\uBDlogic.pas',
  MyDBGrid in '..\Component\MyDBGrid.pas',
  uFrameDavayPodkl in '..\SOURCE\uFrameDavayPodkl.pas' {frmFrameDavayPodkl: TFrame},
  uDohod in '..\SOURCE\uDohod.pas' {frmDohod: TFrame},
  uFrameImportBD in '..\SOURCE\uFrameImportBD.pas' {frmImportBD: TFrame},
  uFrameZvitBank in '..\SOURCE\uFrameZvitBank.pas' {frmZvitBank: TFrame},
  uFrameUtils in '..\SOURCE\uFrameUtils.pas' {frmUtils: TFrame},
  uPdfiumDll in '..\SOURCE\pdfium\uPdfiumDll.pas',
  uPdfiumIntf in '..\SOURCE\pdfium\uPdfiumIntf.pas',
  uFrameAnalitic in '..\SOURCE\uFrameAnalitic.pas' {frmAnalitic: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TmyForm, myForm);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
