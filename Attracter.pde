class Attracter{
  PVector pos=new PVector();
  int mass;
  int size;
  
  public Attracter(int x, int y,int mass,int size){
    pos=new PVector(x,y);
    this.mass=mass;
    this.size=size;
  }
   float x(){
  return pos.x;
  }
   float y(){
  return pos.y;
  }
  void show(){
    ellipse(pos.x,pos.y,size,size); }
}
