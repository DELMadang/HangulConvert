unit uMain;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    eHangul: TEdit;
    btnConvert: TButton;
    eEnglish: TEdit;
    procedure btnConvertClick(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  DM.Hangul;

procedure TForm1.btnConvertClick(Sender: TObject);
begin
  eEnglish.Text := Thangul.ToEnglish(ehangul.Text);
end;

end.
