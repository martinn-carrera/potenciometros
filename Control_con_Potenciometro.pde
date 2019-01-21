import controlP5.*;
import processing.serial.*; 

ControlP5 cp5;

float adc0;    //variable que almacena el valor del adc0 actual 
float[] xvals; // arreglo que almacena los valores del adc0 de arduino 
float voltaje;//variable que contiene el voltaje actual medido 
float voltaje2;
String dato;
float valor;
int cont;
Serial port; // creamos un objeto serial puerto 

void setup() { 
  size(550, 900); 
  xvals = new float[400];  
  port = new Serial(this, "COM5", 9600); 
  port.bufferUntil('\n');

  cp5 = new ControlP5(this);
  cp5.addSlider("A0")
    .setPosition(220, 400)
    .setSize(100, 400)
    .setRange(0, 10) //rangos del contenedor
    .setValue(0) //condiciones iniciales
    ;
} 

void draw() {  
  //grafica del rectangulo
  background(0); 
  strokeWeight(2);   
  stroke(105, 105, 105);   
  fill(255);   
  rect(120, 60, 300, 150);
  //graficas de los limites de voltajes
  strokeWeight(1);
  stroke(128, 128, 128);
  text("0", 60, 210);
  line (120, 180, 420, 180);
  text("1.00", 60, 180);
  line (120, 150, 420, 150);
  text("2.00", 60, 150);
  line (120, 120, 420, 120);
  text("3.00", 60, 120);
  text("4.00", 60, 90);
  line (120, 90, 420, 90);
  text("5.00", 60, 60);
  //posicion del punbto que grafica el voltaje
  for (int i=1; i<150; i++) {       
    xvals[i-1]=xvals[i];
  }
  for (int i=1; i<150; i++) {      
    strokeWeight(6);       
    stroke(25,25,112);       
    point(i+120, 60+(150 -xvals[i]));
  }
  //texto de TIEMPO
  fill(255);    
  text("TIEMPO", 245, 250);

  cp5.getController("A0").setValue(valor);
  println(voltaje);
}
//encargado de tomar los valores y hacer la grafica de voltaje 
void serialEvent (Serial port) {
  String cadena = port.readStringUntil('\n');
  if (cadena!= null) {       
    cadena = trim(cadena);      
    float senal=float(cadena); 
    if (senal<=10)
      valor=senal;
    else
      // adc0 = senal;      
      adc0 = map(senal, 0, 1033, 0, 150);
  }  
  xvals[150-1]=adc0;
}
