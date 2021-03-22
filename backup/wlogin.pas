unit wlogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,wVisorExamen,wVisorQr ;

type

  { TForm4 }

  TForm4 = class(TForm)
    EmpezarButton: TButton;
    Button2: TButton;
    AceptoCheckBox: TCheckBox;
    RudeEdit: TEdit;
    CiEdit: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    TerminosYCondicionesText: TStaticText;
    StaticTextTitulo: TStaticText;
    StaticTextTitulo1: TStaticText;
    procedure EmpezarButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AceptoCheckBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HabilitarSiguiente();
    procedure RudeEditChange(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;
  TerminosYCondiciones: String;

implementation

{$R *.lfm}

{ TForm4 }

procedure TForm4.FormCreate(Sender: TObject);
begin
    TerminosYCondiciones:= 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus sed faucibus massa, nec pretium elit. Donec venenatis elit nunc, et tristique mi ultrices eu. Nullam porttitor urna ut elit vehicula egestas. Ut non augue nunc. Curabitur auctor nulla nisl, ac porta metus interdum id. Etiam vitae urna vehicula, ultrices mi id, interdum orci. Etiam porta diam sit amet enim porta cursus. Nulla pulvinar mattis ligula, ac iaculis eros consectetur ut. Nullam est lacus, aliquet vel tincidunt nec, porta nec nisi.';
    TerminosYCondicionesText.Caption:= TerminosYCondiciones;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
Close();
end;

procedure TForm4.AceptoCheckBoxChange(Sender: TObject);
begin
  HabilitarSiguiente();
end;

procedure TForm4.EmpezarButtonClick(Sender: TObject);
begin
Form4.Hide;
Form1.Show;
end;
procedure TForm4.HabilitarSiguiente();
begin
     If(RudeEdit.Caption <> '') AND (CiEdit.Caption <> '') AND (AceptoCheckBox.Checked = TRUE)
      Then
          begin
               EmpezarButton.Enabled:=TRUE;
           end
     else  EmpezarButton.Enabled := FALSE;
end;

procedure TForm4.RudeEditChange(Sender: TObject);
begin
  HabilitarSiguiente();
end;

end.

