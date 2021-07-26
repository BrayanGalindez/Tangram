abstract class Shape {
  float _rotation;                                       // Rotacion de la pieza
  PVector _position;                                     // Posicion de la pieza
  color _hue;                                            // Color de la pieza
  boolean _use = false;                                  // Interruptor de uso
  boolean state = false;                                 // Interruptor de reflexion
  
  float[] grades = {0, PI/4, PI/2, 3/4*PI, PI, 5/4*PI, 3/2*PI, 7/4*PI, 2*PI };

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////*/

  Shape() {
    _position = new PVector(random(200, width-200), random(200, height-200));
    _rotation = grades[(int) random(grades.length)];
    _hue = color(random(0, 255), random(0, 255), random(0, 255));
  }

  Shape(PVector position, float rotation, color hue) {
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
    else { strokeWeight(2); stroke(0,0,255); }             // Grosor y Color Linea En Uso
    if (!state) { aspect(); }                              // Crea pieza sin reflexion
    else { aspect_r();}                                    // Crea pieza con reflejo (Solo Romboide)
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
  
  boolean use(){                                           // Devuelve el estado del
    return _use;                                           // interruptor de uso
  }

  void changeUse(){                                        // Cambia el estado del
    _use = !_use;                                          // interruptor de uso
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
