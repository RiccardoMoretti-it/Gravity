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
      for (Attracter ar : a){
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
      //controllo se vi è un contatto con un altro corpo
      //lo tratto con il metodo delle palle da biliardo: //https://www.real-world-physics-problems.com/physics-of-billiards.html
      if (PVector.dist(pos, ar.pos)<ar.size/2+size/2) {    
        println(acceleration.mag());

        //rimando indietro il corpo compenetrato
        float difference=((ar.size/2+size/2)-PVector.dist(pos, ar.pos));
        pos.sub(acceleration.copy().normalize().mult(difference));  
        
        
        PVector perpendicular= PVector.sub(pos,ar.pos).normalize(); //perpendicolare
        float angle=perpendicular.rotate(-PI/2).heading();//angolo dellatangente
        perpendicular.rotate(-angle); //normalizzo l'angolo
        acceleration.rotate(-angle); //normalizzo l'accellerazione
        
        //la nuova direzione è resa dalla differenza tra l'angolo della 
        //tangente e l'angolo dell'accellerazione(direzione)
        PVector newAcceleration= PVector.fromAngle(perpendicular.heading()-acceleration.heading());
        acceleration=newAcceleration.setMag(acceleration.mag());
        acceleration.rotate(angle); //denormalizzo l'accellerazione
        //mando avanti il corpo
        acceleration.mult(0.9); 
        if(acceleration.mag()>0.6){
        pos.add(acceleration.copy().normalize().mult(difference));
        }
        
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
