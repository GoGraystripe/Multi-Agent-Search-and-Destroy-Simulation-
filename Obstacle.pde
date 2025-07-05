class Obstacle{
  PVector position;
  float radius;
  
  public Obstacle(PVector position, float radius){
    this.position = position;
    this.radius = radius;
  }
  
  public boolean contains(PVector point){
    if(PVector.dist(position, point) < radius + 10){
      return true;
    }
    return false;
  }
  
  public void draw(){
    fill(#39FF14);
    stroke(0);
    strokeWeight(1);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}
