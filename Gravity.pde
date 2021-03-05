ArrayList<pulled> attracted=new ArrayList<pulled>();
ArrayList<Attracter> attracter=new ArrayList<Attracter>();
PVector a=new PVector(50,100);
boolean press=false;
float angle;
PVector pressed=new PVector(110,110);
PGraphics p;

pulled debug;
void setup(){
  size(2000,2000);
  p=createGraphics(2000,2000);
}
//https://www.real-world-physics-problems.com/physics-of-billiards.html
void draw(){ 
  background(220);
  if(press)
  {
    angle=PVector.sub(new PVector(mouseX,mouseY),pressed).heading();
    line(pressed.x,pressed.y,pressed.x+40*cos(angle),pressed.y+40*sin(angle));
  }
  line(mouseX,mouseY,mouseX+a.x,mouseY+a.y);
  PVector b=a.copy().rotate(PI/2);
  
  line(mouseX,mouseY,mouseX+b.x,mouseY+b.y);
  
  for(pulled ad :attracted){
    ad.show();
    ad.gravity(attracter);
    ad.update(attracter);
  }
  for(Attracter ar :attracter)
    ar.show();
  image(p,0,0);
}
void mousePressed(){
  switch(mouseButton){
    case 39:
      attracter.add(new Attracter(mouseX,mouseY,100,500));
    break;
    case 37:
    pressed=new PVector(mouseX,mouseY);
      println(pressed.x+" "+pressed.y);
    press=true;
    debug=new pulled(mouseX,mouseY,20,20);
    break;
  }
  
}
void mouseReleased(){
  if(press){
  press=false;
    attracted.add(debug);
    debug.acceleration=PVector.fromAngle(angle).mult(PVector.sub(new PVector(mouseX,mouseY),pressed).mag()/50);
  }
}
