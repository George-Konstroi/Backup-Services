unit UnitBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFormBackup = class(TForm)
    GroupBoxBackup: TGroupBox;
    GroupBoxConfiguracao: TGroupBox;
    GroupBoxDestino: TGroupBox;
    LabelLocalizar: TLabel;
    ButtonSelecionarArquivo: TButton;
    ListBoxBackup: TListBox;
    ButtonRemover: TButton;
    ButtonBackupManual: TButton;
    OpenDialogAdicionarArquivo: TOpenDialog;
    CheckBoxCompactacao: TCheckBox;
    RadioGroupTipoCompactacao: TRadioGroup;
    EditDestino: TEdit;
    ButtonSalvarConfiguracoes: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure ButtonSelecionarArquivoClick(Sender: TObject);
    procedure ButtonRemoverClick(Sender: TObject);
    procedure CheckBoxCompactacaoClick(Sender: TObject);
    procedure ButtonSalvarConfiguracoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBackup: TFormBackup;

implementation

{$R *.dfm}

uses
  IniFiles;

procedure TFormBackup.ButtonRemoverClick(Sender: TObject);
begin
  ListBoxBackup.Items.Delete(ListBoxBackup.ItemIndex);
end;

procedure TFormBackup.ButtonSalvarConfiguracoesClick(Sender: TObject);
var
  configuracao: TIniFile;
begin
  configuracao := nil;

  try
    configuracao := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Backup.ini');

    if CheckBoxCompactacao.Checked then
    begin
      configuracao.WriteString('BACKUP','COMPACTAR','S');

      if RadioGroupTipoCompactacao.ItemIndex = 0 then configuracao.WriteString('BACKUP','TIPO','R') //WinRar
      else configuracao.WriteString('BACKUP','TIPO','Z')                                            //WinZip
    end
    else configuracao.WriteString('BACKUP','COMPACTAR','N');

    configuracao.WriteString('BACKUP','DESTINO', EditDestino.Text);
  finally
    configuracao.Free;
  end;

  ListBoxBackup.Items.SaveToFile(ExtractFilePath(Application.ExeName) + 'Lista.ini');
end;

procedure TFormBackup.ButtonSelecionarArquivoClick(Sender: TObject);
var
  arquivo: Integer;
begin
  if OpenDialogAdicionarArquivo.Execute then
    if OpenDialogAdicionarArquivo.FileName <> '' then
      for arquivo := 0 to OpenDialogAdicionarArquivo.Files.Count - 1 do
        ListBoxBackup.Items.Add(OpenDialogAdicionarArquivo.Files[arquivo]);
end;

procedure TFormBackup.CheckBoxCompactacaoClick(Sender: TObject);
begin
  //if CheckBoxCompactacao.Checked then RadioGroupTipoCompactacao.Visible := True
  //else RadioGroupTipoCompactacao.Visible := False;
end;

end.
