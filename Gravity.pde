ArrayList<pulled> attracted=new ArrayList<pulled>();
ArrayList<Attracter> attracter=new ArrayList<Attracter>();
//se con il click sinistro si tenta di creare un nuovo elemento
boolean press=false;
float angle;
PVector pressed=new PVector(110,110);

pulled debug;
void setup(){
  size(2000,2000);
  textSize(72);
}
void draw(){ 
  background(220);
  if(press)
  {
    angle=PVector.sub(new PVector(mouseX,mouseY),pressed).heading();
    line(pressed.x,pressed.y,pressed.x+40*cos(angle),pressed.y+40*sin(angle));
  }
  fill(220);
  for(Attracter ar :attracter)
    ar.show();
    fill(0);
  for(pulled ad :attracted){
    ad.gravity(attracter);
    ad.update(attracter);
    ad.show();
  }
  text(frameRate,100,100);
  text(attracted.size(),100,200);
}
void mousePressed(){
  switch(mouseButton){
    case 39:
      attracter.add(new Attracter(mouseX,mouseY,100,500));
    break;
    case 37:
    pressed=new PVector(mouseX,mouseY);
    press=true;
    debug=new pulled(mouseX,mouseY,20,20);
    break;
  }
  
}
void mouseReleased(){
  if(press){
  press=false; 
  float intensity=(PVector.sub(new PVector(mouseX,mouseY),pressed).mag()/50);
    debug.acceleration=PVector.fromAngle(angle).setMag(intensity);
  for(int i=0;i<50;i++){
  
  pulled p=new pulled((int)debug.pos.x,(int)debug.pos.y,debug.mass,debug.size);
  p.acceleration=debug.acceleration.copy().rotate(random(-0.5*PI,0.5*PI));
    attracted.add(p);
  }
    attracted.add(debug);
  }
}
void keyPressed(){
  if(key=='r'||key=='R'){
  attracted.clear();
  attracter.clear();
  }
}
