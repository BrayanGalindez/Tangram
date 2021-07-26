class Triangle extends Shape {
  float _edge;

  Triangle(float edge) {
    setEdge(edge);
  }

  @Override
  void aspect() {
    triangle (0, 0, edge(), 0, edge(), edge());
  }
  
  @Override
  void aspect_r(){
    triangle (edge(), 0, edge(), edge(), 0, edge());
  }

  public float edge() {
    return _edge;
  }

  public void setEdge(float edge) {
    _edge = edge;
  }
}
