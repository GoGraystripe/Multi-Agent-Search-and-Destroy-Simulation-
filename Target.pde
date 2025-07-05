class Target{
  PVector position;
  PVector velocity;
  float radius;
  
  public Target(PVector position, PVector velocity, float radius){
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.radius = radius;
  }
  
  public boolean contains(PVector point){
    if(PVector.dist(position, point) < radius + 1){
      return true;
    }
    
    return false;
  }
  
  public void draw(){
    fill(#FF1A1A);
    stroke(0);
    strokeWeight(1);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
  
  public void move(){
    //if(position.x < 0|| position.x > width){
    //  velocity.x *= -1;
    //  position.x = constrain(position.x, 0, width);
    //}
    //if(position.y < 0|| position.y > height){
    //  velocity.y *= -1;
    //  position.y = constrain(position.y, 0, height);
    //}
    velocity.rotate(random(-0.05, 0.05));
    position.add(velocity);
    
    if (position.x < 0) position.x = width;
    if (position.x > width) position.x = 0;
    if (position.y < 0) position.y = height;
    if (position.y > height) position.y = 0;
      
  }
  
  public void destroy(){
    for(int i = 0; i<targets.size(); i++){
      if(this.equals(targets.get(i))){
        targets.remove(i);
        return;
      }
    }
  }
  
}
