class pulled {
  PVector pos=new PVector();
  PVector acceleration=new PVector(0, 0);
  int mass;
  int size;
  public pulled( int x, int y, int mass, int size) {
    pos=new PVector(x, y);
    this.mass=mass;
    this.size=size;
  }
  void gravity(ArrayList<Attracter>a) {
    if (gravityExists)
      for (Attracter ar : a) {
        //direzione della forza gravitazionale
        PVector dir=PVector.sub(ar.pos, pos).normalize();
        //forza gravitazionale (m1*m2)/r^2
        float force=(GRAVITY_COSTANT*(ar.mass*mass))/pow(PVector.dist(pos, ar.pos), 2);
        dir.mult(force);
        acceleration.add(dir);
      }
  }
  void update(ArrayList<Attracter>a) {
    pos.add(acceleration);
    for (Attracter ar : a)
      if (PVector.dist(pos, ar.pos)<ar.size/2+size/2) {      
        
        //rimando indietro il corpo compenetrato
        float difference=((ar.size/2+size/2)-PVector.dist(pos, ar.pos)+1);
        pos.sub(acceleration.copy().normalize().mult(difference));  
        
        //perpendicolare tra i due corpi
        PVector tangent=PVector.sub(pos,ar.pos).normalize();
        //tangente tra i due corpi
        if(abs(tangent.copy().rotate(PI/2).heading()-acceleration.heading())<PI/2)tangent.rotate(PI/2);
        else tangent.rotate(-PI/2);

        //nuova direzione
        acceleration=tangent.mult(acceleration.mag());

        //mando avanti il corpo
        pos.add(acceleration.copy().normalize().mult(difference));
        acceleration.mult(0.9); 
        
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
