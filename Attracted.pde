class pulled {
  PVector pos=new PVector();
  PVector acceleration=new PVector(0, 0);
  int mass;
  int size;
  public pulled( int x, int y, int mass,int size) {
    pos=new PVector(x, y);
    this.mass=mass;
    this.size=size;
  }
  void gravity(ArrayList<Attracter>a) {
    if (gravityExists)
      for (Attracter ar : a) {
        //direzione della forza gravitazionale
        PVector av=ar.pos.copy().sub(pos).normalize();
        //forza gravitazionale (m1*m2)/r^2
        float force=(GRAVITY_COSTANT*(ar.mass*mass)/4)/PVector.dist(pos, ar.pos);
        av.mult(force);
        acceleration.add(av);
        acceleration.limit(20);
      }
  }
  void update(ArrayList<Attracter>a) {
    pos.add(acceleration);
    for (Attracter ar : a)
      if (PVector.dist(pos, ar.pos)<ar.size/2+size/2) {
        PVector newv1=ar.pos.copy().sub(pos).rotate(PI/2);
        float angle=newv1.heading();
        acceleration.rotate(angle);
        acceleration.mult(1);
        //direzione
        PVector av=ar.pos.copy().sub(pos).normalize();
        //se è molto vicino si ferma
        /*if (acceleration.mag()<10)
        {
          av=pos.copy().sub(ar.pos).normalize();
          acceleration.mult(0);
          pos=av.mult(ar.size/2+size/2).add(ar.pos);
        } 
        else {*/
          float difference=((ar.size/2+size/2)-PVector.dist(pos, ar.pos));
          av.mult(difference);
          pos.sub(av);
        //}
      }
  }
  float x() {
    return pos.x;
  }
  float y() {
    return pos.y;
  }
  void show() {
    ellipse(pos.x, pos.y, mass, mass);
  }
}
