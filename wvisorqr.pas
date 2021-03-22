unit wVisorQr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  qrencode;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;
  qrcode: qrencode.TQRCode;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.Button1Click(Sender: TObject);
begin

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  qrcode:=TQRCode.Create();
  // set error correction level:
  qrcode.EcLevel:=QR_ECLEVEL_H;
  // string, which encode:
  qrcode.Text:='Testing QR code';
  // paint on Canvas on coordinates surrounded by rectangle :
  // qrcode.Paint(Printer.Canvas, Rect(10,10,100,100));
  qrcode.Free;
end;

end.

