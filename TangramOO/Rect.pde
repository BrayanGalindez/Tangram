class Square extends Shape {
  float _edge;

  Square(float edge) {
    setEdge(edge);
  }

  @Override
  void aspect() {
    rectMode(CENTER);
    rect(0, 0, edge(), edge());
  }
  @Override
  void aspect_r(){
    rectMode(CENTER);
    rect(0, 0, edge(), edge());
  }


  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
