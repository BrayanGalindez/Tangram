abstract class Shape {
  float _rotation;                          // Rotacion de la pieza
  PVector _position;                        // Posicion de la pieza
  color _hue;                               // Color de la pieza
  boolean _use = false;                     // Interruptor de uso
  boolean state = false;                    // Interruptor de reflexion
  
  float[] grades = {0, PI/4, PI/2, 3/4*PI, PI, 5/4*PI, 3/2*PI, 7/4*PI, 2*PI };  // Grados que hay en el array.

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

  Shape() {
    _position = new PVector(random(200, width-200), random(200, height-200));       //Posicion random de la pieza en la pantalla
    _rotation = grades[(int) random(grades.length)];                                //Rotacion random de la pieza en la pantalla dentro del parametro del array grades.
    _hue = color(random(0, 255), random(0, 255), random(0, 255));
  }

  Shape(PVector position, float rotation, color hue) {                             //Constructor del shape
    setPosition(position);
    setRotation(rotation);
    setHue(hue);
  }

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

  void draw() {
    push();                                                
    fill(hue());                                           // Rellena la pieza con el color
    translate(position().x, position().y);                 // Mueve la pieza a la posicion
    rotate(rotation());                                    // Rota la figura segun la rotacion
    if (!_use) { strokeWeight(1); stroke(0,5,75); }        // Grosor y Color Linea Sin Uso
    else { strokeWeight(3); stroke(0,0,200); }             // Grosor y Color Linea En Uso
    if (!state) { aspect(); }                              // Crea pieza sin reflexion
    else { aspect_r();}                                    // Crea pieza con reflejo 
    pop();
  }

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

  abstract void aspect();                                  // Crea la pieza sin reflexion
  abstract void aspect_r();                                // Crea la pieza con reflexion

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/
 
  void contains(color comparison) {                        // Compara un color con el de la
    if (comparison == _hue) {                              // pieza, si son iguales activa
      _use = !_use; }                                      // el interruptor de uso
  }
  
  boolean use(){                                           
    return _use;                                           
  }

  void changeUse(){                                        
    _use = !_use;                                          
  }

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

  float rotation() {
    return _rotation;                                      
  }

  void setRotation(float rotation) {
    _rotation = rotation;                                  
  }

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

  PVector position() {
    return _position;                                      
  }

  void setPosition(PVector position) {
    _position = position;                                  
  }

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

  color hue() {
    return _hue;                                           
  }

  void setHue(color hue) {
    _hue = hue;                                            
  }

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

  void reflect(){                                         
    state = !state;                                        
  }
}
