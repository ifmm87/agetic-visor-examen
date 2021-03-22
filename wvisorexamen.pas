unit wVisorExamen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,  fpjson, jsonparser, wVisorQr;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ProgressBar: TProgressBar;
    StaticText1: TStaticText;
    preguntaText: TStaticText;
    contadorText: TStaticText;
    StaticText4: TStaticText;
    totalText: TStaticText;
    StaticTextTitulo: TStaticText;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ConfirmarQR();
  private

  public

  end;

var
  Form1: TForm1;
  jData : TJSONData;
  jObject : TJSONObject;
  jArray : TJSONArray;
  s : String;
  jString: String;
  i: integer;
  totalPreguntas: integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  ConfirmarQR();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  If i < jData.Count - 1
     Then
     begin
       i:= i + 1;
       jArray:= TJSONArray(jData);
       jObject := TJSONObject(jArray.Items[i]);
       preguntaText.Caption := jObject.get('pregunta');
       contadorText.Caption:= (i + 1).ToString();
       ProgressBar.Position := Round(100/totalPreguntas * (i));
     end
  else
      ShowMessage('Esta seguro de terminar la prueba?');


end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  If i > 0
     Then
     begin
        i := i - 1;
        jArray:= TJSONArray(jData);
        jObject := TJSONObject(jArray.Items[i]);
        preguntaText.Caption := jObject.get('pregunta');
        contadorText.Caption:= (i + 1).ToString();
        ProgressBar.Position := Round(100/totalPreguntas * (i));
     end;

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Close();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // create from string
  i := 0;
  jString:= '[' +
            '{'+
            '"pregunta" : "Cual fue el primer presidente de Bolivia?", "tipo" : "ELECCION_SIMPLE",' +
            '"opciones" : [{"label":"a", "opcion": "Eduardo Avaroa"}, {"label": "b", opcion: "Antonio Jose de Sucre"}, {"label": "c", "opcion": "Ninguno"}]'+
            '},'+

            '{'+
            '"pregunta" : "Cuantos municipios tiene Bolivia?", "tipo" : "ELECCION_SIMPLE",' +
            '"opciones" : [{"label":"a", "opcion": "9"}, {"label": "b", opcion: "345"}, {"label": "c", "opcion": "365"}]'+
            '},'+

            '{'+
            '"pregunta" : "Cual fue el año de fundación de Bolivia?", "tipo" : "ELECCION_SIMPLE",' +
            '"opciones" : [{"label":"a", "opcion": "9"}, {"label": "b", opcion: "345"}, {"label": "c", "opcion": "365"}]'+
            '}'+

            ']';
  jData := GetJSON(jString);
  totalPreguntas:=jData.Count;
  totalText.Caption:= totalPreguntas.ToString();
  s := jData.FormatJSON;
  jArray:= TJSONArray(jData);
  jObject := TJSONObject(jArray.Items[i]);
  preguntaText.Caption := jObject.get('pregunta');
  contadorText.Caption:= (i + 1).ToString();
  ProgressBar.Position := Round(100/totalPreguntas * (i));
end;
procedure TForm1.ConfirmarQR();
begin
  if MessageDlg('Confirmación', '¿Esta seguro de enviar el examen?', mtConfirmation,
   [mbYes, mbNo, mbIgnore],0) = mrYes
  then
  begin
     Form3.show();
  end;
end;
end.

