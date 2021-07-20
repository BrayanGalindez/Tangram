
//variables globales
int Jugar = 1;
int Repinta = 1;
//Cuadro 1
int x= 100;
int y= 500;
int sz=100;
//Cuadro 2
int x1= 300;
int y1= 500;
int sz1=100;
//Cuadro 3
int x2= 500;
int y2= 500;
int sz2=100;
//Cuadro 4
int x3= 700;
int y3= 500;
int sz3=100;
//Cuadro 5
int x4= 900;
int y4= 500;
int sz4=100;
////Triangulo
////Primer punto
//int x4= 200;
//int y4= 100;
////Segundo punto
//int x5= 100;
//int y5= 300;
////Tercer punto
//int x6= 300;
//int y6= 300;
//Configurar pantalla
void setup()
{
  size(1000,600);
  background(0,0,0);
  cursor(ARROW);
  
}
//Programa principal
void draw()
{
 if ((Jugar == 1) && (Repinta ==1))
  {
    DibujarFormas();
  } 
  
  
}
//FUNCIONES
void DibujarFormas()
{
  background(0, 0, 0);
  //TITULO
  fill(100, 0, 0);
  textSize(30);//textSize(altura del texto en pixeles)
  text("Tangram by Bgalindez@unal.edu.co", 110, 90);
  //objeto
  rectMode(CENTER);  // Set rectMode to CENTER
  fill(204, 102, 0);  // Set fill to gray
  //cuadro 1
  rect(x, y, sz, sz);
  //cuadro 2
  rect(x1, y1, sz1, sz1);
  //cuadro 3
  rect(x2, y2, sz2, sz2);
  //cuadro 4
  rect(x3, y3, sz3, sz3);
  //cuadro 4
  rect(x4, y4, sz4, sz4);
  
  //Nueva pantalla
  //Repinta=0;
//Click con el raton  
  //Cuadro 1
  if(dist(x, y, mouseX, mouseY) < sz/2)
  {
   cursor(HAND);
   //Si ademas hacemos clic
   if(mousePressed)
   {
     x= mouseX;
     y= mouseY;
   }
  }
  //Cuadro 2
 if(dist(x1, y1, mouseX, mouseY) < sz1/2)
  {
   cursor(HAND);
   //Si ademas hacemos clic
   if(mousePressed)
   {
     x1= mouseX;
     y1= mouseY;
   }
  }
  //Cuadro 3
  if(dist(x2, y2, mouseX, mouseY) < sz2/2)
  {
   cursor(HAND);
   //Si ademas hacemos clic
   if(mousePressed)
   {
     x2= mouseX;
     y2= mouseY;
   }
  }
  //Cuadro 4
  if(dist(x3, y3, mouseX, mouseY) < sz3/2)
  {
   cursor(HAND);
   //Si ademas hacemos clic
   if(mousePressed)
   {
     x3= mouseX;
     y3= mouseY;
   }
  }
  //Cuadro 5
  if(dist(x4, y4, mouseX, mouseY) < sz4/2)
  {
   cursor(HAND);
   //Si ademas hacemos clic
   if(mousePressed)
   {
     x4= mouseX;
     y4= mouseY;
   }
  }

}
