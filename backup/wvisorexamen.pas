unit wVisorExamen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, fpjson, jsonparser, wVisorQr;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    ProgressBar: TProgressBar;
    Shape1: TShape;
    StaticText1: TStaticText;
    preguntaText: TStaticText;
    contadorText: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
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
    procedure crearBoton(texto: String; NroPregunta: integer; panel: TPanel);
    procedure CrearBotones();
    procedure crearPregunta(panel: TPanel);
    procedure crearOpcionUnica(radioGroup: TRadioGroup; objeto: TJSONObject);
    procedure crearSeleccionUnica(panel: TPanel; opciones: TJSONArray);
    procedure Panel2Click(Sender: TObject);
    procedure StaticText3Click(Sender: TObject);
    procedure limpiarPanel(panel: TPanel);
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
       crearPregunta(Panel1);
     end
  else
      ConfirmarQR();


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
        crearPregunta(Panel1);
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
            '"pregunta" : "¿Cual fue el primer presidente de Bolivia?", "tipo" : "ELECCION_SIMPLE",' +
            '"opciones" : [{"label":"a", "opcion": "Eduardo Avaroa"}, {"label": "b", opcion: "Antonio Jose de Sucre"}, {"label": "c", "opcion": "Ninguno"}]'+
            '},'+

            '{'+
            '"pregunta" : "¿Cuantos municipios tiene Bolivia?", "tipo" : "ELECCION_SIMPLE",' +
            '"opciones" : [{"label":"a", "opcion": "9"}, {"label": "b", opcion: "345"}, {"label": "c", "opcion": "365"}]'+
            '},'+

            '{'+
            '"pregunta" : "¿Cuántas provincias tiene el Departamento de La Paz?", "tipo" : "ELECCION_SIMPLE",' +
            '"opciones" : [{"label":"a", "opcion": "16"}, {"label": "b", opcion: "20"}, {"label": "c", "opcion": "4"}]'+
            '},'+
            '{'+
            '"pregunta" : "¿La batalla de la Tablada se llevo a cabo en el departamento de.. ?", "tipo" : "ELECCION_SIMPLE",' +
            '"opciones" : [{"label":"a", "opcion": "La Paz"}, {"label": "b", opcion: "Tarija"}, {"label": "c", "opcion": "Chuquisaca"}]'+
            '},'+
            '{'+
            '"pregunta" : "¿Cual es el municipio cuna de la fundación de La Paz?", "tipo" : "ELECCION_SIMPLE",' +
            '"opciones" : [{"label":"a", "opcion": "Tiwanaku"}, {"label": "b", opcion: "Laja"}, {"label": "c", "opcion": "Chicaloma"}]'+
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
  CrearBotones();
  crearPregunta(Panel1);
end;
procedure TForm1.ConfirmarQR();
begin
  if MessageDlg('Confirmación', '¿Estas seguro de enviar el examen?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  begin
     Form1.Hide;
     // Form3.ContenidoQr:= 'respuestas' ;
     Form3.ContenidoQr:= '{"ci": "123456", "respuestas": [{"respuesta": ["d"]}, {"respuesta": ["b"]}, {"respuesta": ["d"]}, {"respuesta": ["pato", "peta"]}]' ;
     Form3.Show();

  end;
end;
procedure TForm1.crearBoton(texto: String; NroPregunta:integer; panel: TPanel);
var
  StaticText : TStaticText;
begin
          StaticText:=TStaticText.Create(nil);
          StaticText.Caption := texto;
          StaticText.Parent := panel;
          StaticText.Transparent:= false;
          StaticText.Left:= 20 ;
          StaticText.Top:=  ((NroPregunta -1) * 35) + 5 ;
          StaticText.Width:= 150;
          StaticText.Height:= 34;
          StaticText.Alignment:= taCenter;
          // StaticText.Font:=;
          If NroPregunta <= i+1 Then
             begin
                StaticText.Color:=clMoneyGreen;
             end
          else  StaticText.Color:=clDefault;

end;
procedure TForm1.CrearBotones();
var
    j:integer;
begin

     for j := 1 to totalPreguntas do
        begin
           crearBoton(IntToStr(j),j, Panel2 );
        end;

end;
procedure TForm1.crearOpcionUnica(radioGroup: TRadioGroup; objeto: TJSONObject);
var
  radio : TRadioButton;
begin
     radio := TRadioButton.Create(nil);
     radio.Caption := objeto.Get('label') +') '+ objeto.Get('opcion');
     radio.Parent := radioGroup;
     radio.Font.Size := 12;
     radio.Font.Bold:= TRUE;
end;

procedure TForm1.crearSeleccionUnica(panel: TPanel; opciones: TJSONArray);
var
  k : Integer;
  index: Integer;
  radioGroup : TRadioGroup;
begin
     radioGroup := TRadioGroup.Create(nil);
     radioGroup.Caption := 'Selección única';
     radioGroup.Font.Bold:= TRUE;
     radioGroup.Font.size:= 10;
     radioGroup.Width:=400;
     if (opciones <> nil) then
       for k := 1 to opciones.Count do
           begin
                index := k - 1;
                crearOpcionUnica(radioGroup, TJSONObject(opciones[index]));
           end;
     radioGroup.Parent := panel;
end;

procedure TForm1.Panel2Click(Sender: TObject);
begin

end;

procedure TForm1.StaticText3Click(Sender: TObject);
begin

end;

procedure TForm1.crearPregunta(panel: TPanel);
var
  jpregunta : TJSONObject;
  jopciones : TJSONArray;
begin

     // index := pregunta - 1;
     // jpregunta := TJSONObject(jArray[index]);
     // label1.Caption:= 'Pregunta ' + IntToStr(pregunta);
     //ShowMessage(IntToStr(i));
        limpiarPanel(Panel1);
       jpregunta := TJSONObject(jArray.Items[i]);
       jopciones := TJSONArray(jpregunta.Extract('opciones'));
       crearSeleccionUnica(panel, jopciones);
end;
procedure TForm1.limpiarPanel(panel: TPanel);
var
  n: Integer;
  cmp : TComponent;
begin
   for n:= 0 to ComponentCount-1 do
    begin
      cmp := Components[n];
      if cmp.GetParentComponent=panel then
        begin
          cmp.Free;
        end;
    end;
end;
end.

