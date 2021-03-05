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
        PVector dir=PVector.sub(ar.pos,pos).normalize();
        //forza gravitazionale (m1*m2)/r^2
        float force=(GRAVITY_COSTANT*(ar.mass*mass))/pow(PVector.dist(pos, ar.pos),2);
        dir.mult(force);
        acceleration.add(dir);
        
      }
  }
  void update(ArrayList<Attracter>a) {
    pos.add(acceleration);
    for (Attracter ar : a)
      if (PVector.dist(pos, ar.pos)<ar.size/2+size/2) {
        PVector tangent=PVector.sub(ar.pos.copy(),pos);
        if(abs(tangent.copy().rotate(PI/2).heading())<PI/2)tangent.copy().rotate(PI/2);
        else tangent.copy().rotate(-PI/2);
        float angle=tangent.heading();
        acceleration.rotate(angle);
        acceleration.mult(0.9);
        //direzione
        PVector dir=ar.pos.copy().sub(pos).normalize();
        //se è molto vicino si ferma
        /*
        if (abs(acceleration.mag())<1)
        {
          av=pos.copy().sub(ar.pos).normalize();
          acceleration.mult(0);
          pos=av.mult(ar.size/2+size/2).add(ar.pos);
        } 
        else {*/
          float difference=((ar.size/2+size/2)-PVector.dist(pos, ar.pos));
          dir.mult(difference);
          pos.sub(dir);
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
