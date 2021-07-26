
import ddf.minim.*;                                    //Importar libreria de audio

Minim minim; 
AudioPlayer player;                                    //Un AudioPlayer proporciona
                                                       //una forma autónoma de reproducir un archivo de sonido transmitiéndolo desde el disco (o Internet). 
Shape[] shapes;
boolean drawGrid = true, drawBorder = true;            // Dibujar Grilla y Borde
float scale = 20;                                      // Tamaño de Escala
int state ;                                            // Pantalla 
float rotation ;                                       // Rotacion Auxiliar
color comparison;                                      // Comparacion de color
PVector position = new PVector (mouseX, mouseY);       // Posición Actual De Mouse
PImage  bg, successful, controls, start, menu, levels; // Imagenes de Pantalla
PImage newLevel;                                       // Imagen Para Nuevo Nivel
PImage[] level;                                        // Imagenes De Niveles
int level_x = 0;                                       // Nivel Actual En Juego
int figurePixels = 5000 ;                              // Pixeles Negros En Pantalla
boolean complete = false;                              // Nivel Completado

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void setup() {
  size(1280, 700);
  minim = new Minim(this);
  player = minim.loadFile("8_Bit_Retro_Funk.mp3");     //Cargar archivo de audio 
  player.loop();                                       //Reproduce el audio en un bucle infinito
  
  
  shapes = new Shape[7];                                  // Arreglo de Piezas
  level = new PImage[4];                                  // Arreglo de Niveles
  
  smooth(0);                                               // Antialising
  
  creatingForms();                                         // Crear las fichas
  bg = loadImage("Color de fondo.png");                    // Fondo
  start = loadImage("Fondo.png");                          // Pantalla de Inicio 
  menu = loadImage("Menu.png");                            // Pantalla de Menu
  controls = loadImage("Controles.png");                  // pantalla de controles
  levels = loadImage("Niveles.png");                       // Pantalla de Niveles
  successful = loadImage("Completado.png");                // Imagen de Completado
  
  int i;
  for (i=1; i<level.length; i++){
    level[i] = loadImage("level_"+i+".png"); }         // Imagenes de Niveles
  
}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/
                                                       
void drawGrid(float scale) {                           
  push();                                              // Funcion para dibujar una
  strokeWeight(1);                                     // cuadricula.
  int i;                                                
  for (i=0; i<=width/scale; i++) {                     
                                                       
    stroke(0, 0, 0, 20);
    line(i*scale, 0, i*scale, height);
  }
  for (i=0; i<=height/scale; i++) {
    stroke(0, 0, 0, 20);
    line(0, i*scale, width, i*scale);
  }
  pop();
}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void drawBorder(){                                    // Funcion para dibujar el borde
  image(bg,0,0);                                      // del juego.
  stroke(65,70,140);                                  
  strokeWeight(2);
  fill(255);
  rect(50, 50,width-100, height-100, 10);
}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void draw() {                                          //Funcion para dibujar pantalla
  background(255, 255, 255);
  
  menu();  
 
}
 
/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void drawShapes(){
  
  //if (drawBorder) { drawBorder(); }                    // Activa o desactiva el borde   //Comentado porque el
  //if (drawGrid) { drawGrid(10); }                      // Activa o desactiva la grilla  //programa es mas lento
  
  currentLevel(level_x);
  
  for (Shape shape : shapes) { shape.draw(); }         // Dibuja las piezas del Tangram
  
  if (verification()){
    complete = true;                                   // Nivel Completado
  }
  
  if (complete){
    image(successful,0,0);                             // Imagen de Completado
  }
}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void creatingForms(){                                  // Crea las figuras del Tangram
  shapes[0] = new Square(3*sqrt(2)*scale);             // Cuadrado
  shapes[1] = new Rhomboid(6*scale);                   // Romboide 
  shapes[2] = new Triangle(6*sqrt(2)*scale);           // Triangulo Grande 1
  shapes[3] = new Triangle(6*sqrt(2)*scale);           // Triangulo Grande 2
  shapes[4] = new Triangle(6*scale);                   // Triangulo Mediano
  shapes[5] = new Triangle(3*sqrt(2)*scale);           // Triangulo Pequeño 1
  shapes[6] = new Triangle(3*sqrt(2)*scale);           // Triangulo Pequeño 2

}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void menu(){
  if (state == 0){
    image(start,0,0);                                  // Pantalla fondo inicial
  } else if (state == 1) {
    image(menu,0,0);                                   // Pantalla menu
  } else if (state == 2) {
    image(levels,0,0);                                 // Pantalla Niveles
  } else if (state == 3) {
    drawShapes();                                      // Pantalla de juego
  } else if (state == 4) {
    image(controls,0,0);                              // Pantalla de controles
  }
}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void currentLevel(int level_x){
  int i;                                               // Comprueba el nivel que el
  for (i=1; i<level.length; i++){                      // usuario a elegido, en caso de
    if (i == level_x){                                 // no elegirse alguno no mostrará
      image(level[i],0,0);                             // imagen, sino, mostrará la
    }                                                  // imagen correspondiente
  }
}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

boolean verification(){
  figurePixels = 0;
  loadPixels();
  
  for (int i = 0; i <pixels.length; i++){              // Se recorre el arreglo en busca de  
    if (color(pixels[i]) == color(0)){                 // los pixeles de la figura,
      figurePixels++;}                                 // si los hay se suman a la variable
  }                                                     
  
  if ((figurePixels<=1000)&&(level_x!=0)){
    for (Shape shape : shapes) {                       // Apagar todos los interruptores
      if (shape.use()){ shape.changeUse();}            // de uso de las piezas
    }
    return true;                                       // Hay menos de 1000 pixeles de la figura
  } else { return false; }                             // Hay mas de 1000 pixeles de la figura
}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/
void mouseDragged(){
  position = new PVector (mouseX, mouseY);             // Posicion actual de mouse
   
  for (Shape shape : shapes) {
      if (shape.use()){                                // La figura seleccionada 
        shape.setPosition(position);                   // se mueve a la posicion
        shape.draw();                                  // actual de mouse
      }
    }
}

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void mouseClicked(){
   comparison = get(mouseX, mouseY);                   // Color del pixel bajo el mouse
   for (Shape shape : shapes) {                        // Compara el color bajo el pixel
   shape.contains(comparison);                         // con cada pieza, si es igual
 }                                                     // activa el interruptor de movimiento.
}


/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

void keyPressed() {
  
   if (key == 'z'|| key == 'Z'){                         // Activar y desactivar musica
       if (player.isPlaying())
       {
         player.pause();
       }
       else
       {
         player.loop();                                  
       }
   }
  
  if (key == ' '){
    if (state == 0){
      state = 1;                                             // Pasar Pantalla principal a menu
    }
 
    if (state == 3 && level_x !=0 && complete == true){
      complete = false;                                      // El nuevo nivel no está completado
      creatingForms();                                       // Crea nuevamente las piezas
      if (level_x != 3){
        level_x ++;                                          // Pasa al siguiente nivel
      } else {
        state = 1;                                           // Niveles completados
        level_x = 0;                                         // jugador vuelve a menu.
      }
    }
  }
  
  if (key == 'w' || key == 'W') {
    for (Shape shape : shapes) {                      //  la figura seleccionada
      if (shape.use()){                               // rota 45° a la derecha
        rotation = shape.rotation()+QUARTER_PI;
        shape.setRotation(rotation);
        shape.draw();
      }
    }
  }
  
  if (key == 's' || key == 'S') {
    for (Shape shape : shapes) {                      // la figura seleccionada
      if (shape.use()){                               // rota 45° a la izquierda
        rotation = shape.rotation()-QUARTER_PI;
        shape.setRotation(rotation);
        shape.draw();
      }
    }
  }
  
  if (key == 'q' || key == 'Q') {
    for (Shape shape : shapes) {                      // La figura seleccionada
      if (shape.use()){                               // se refleja
        shape.reflect();
        shape.draw();
      }
    }
  }
  
  if (key == 'm' || key == 'M'){
    if (state != 0){                                  // Regresar al menu principal
      state = 1;
      creatingForms();                                // Recrear las piezas
      drawGrid = true;                                // Volver a dibujar la rejilla
      drawBorder = true;                              // Volver a dibujar el borde
      level_x = 0;
    }
    
  }
  

  if (key == 'n' || key == 'N'){
    if (state != 0){                                  // Regresar a niveles
      state = 2;
      creatingForms();                                // Recrear las piezas
      drawGrid = true;                                // Volver a dibujar la rejilla
      drawBorder = true;                              // Volver a dibujar el borde
      level_x = 0;
    }
   
  }
  if (key == 'p' || key == 'P'){
    if (state != 0){                                  // Regresar a pantalla Principal
      state = 0;
      creatingForms();                                // Recrear las piezas
      drawGrid = true;                                // Volver a dibujar la rejilla
      drawBorder = true;                              // Volver a dibujar el borde
      level_x = 0;
    }
  
  }
  if (key == '1') {
    if (state == 1){                                  // Pasar de pantalla menu a pantalla de modo libre
      state = 3;                   
    }
    if (state == 2){
      state = 3; level_x = 1;                         // Nivel 1
    }
  }
  
  if (key == '2'){
    if (state == 1){                                  // Pasar de pantalla menu a pantalla niveles
      state = 2;
    } else if (state == 2){
      state = 3; level_x = 2;                         // Nivel 2
    }
  }
  
  if (key == '3'){
    if (state == 1){
      state = 4;                                      // Pasar de pantalla menu a pantalla de instrucciones
    }
    if (state == 2){
      state = 3; level_x = 3;                         // Nivel 3
    }
  }
}
