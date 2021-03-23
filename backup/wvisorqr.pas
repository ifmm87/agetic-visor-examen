unit wVisorQr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  qrencode;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    StaticText1: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);

  private
    FContenidoQr: string;
    procedure SetContenidoQr(AValue: string);
  public
       property ContenidoQr: String read FContenidoQr write SetContenidoQr;
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
procedure TForm3.SetContenidoQr(AValue: string);
begin
  if FContenidoQr=AValue then Exit;
  FContenidoQr:=AValue;
  // add custom code here
end;

procedure TForm3.FormCreate(Sender: TObject);
begin

end;

procedure TForm3.FormShow(Sender: TObject);
begin
  qrcode:=TQRCode.Create();
  // set error correction level:
  qrcode.EcLevel:=QR_ECLEVEL_H;
  // string, which encode:
  qrcode.Text:=FContenidoQr;
  // paint on Canvas on coordinates surrounded by rectangle :
  qrcode.Paint(Image1.Canvas, Rect(0,0,600,600));
  //qrcode.Paint(PaintBox1.Canvas, Rect(30,30,600,600));

  // qrcode.Free;
end;

procedure TForm3.Image1Click(Sender: TObject);
begin

end;

procedure TForm3.StaticText1Click(Sender: TObject);
begin

end;

end.

