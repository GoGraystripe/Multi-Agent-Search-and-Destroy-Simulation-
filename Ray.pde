class Ray{
  PVector startPoint;
  PVector endPoint;
  float step;
  float range;
  PVector direction;
  
  public Ray(PVector startPoint, float step, float range, PVector direction){
    this.startPoint = startPoint;
    this.endPoint = startPoint.copy();
    this.step = step;
    this.range = range;
    this.direction = direction.copy();
    
  }
  
  public void cast(Robot robot){
    endPoint = startPoint.copy();
    
    if(robot.velocity.mag() == 0){
      return;
    }
    
    while(!terminates(robot) && distance() <= range){
      endPoint.add(PVector.mult(direction, step));
    }
    
  }
  
  public boolean terminates(Robot robot){
    
    for(Target target : targets){
      if(target.contains(endPoint) && !robot.targetLocked){
        robot.targetLocked = true;
        robot.target = target;
        robot.endGoal = target.position;
        break;
      }
    }
    
    for(Obstacle obstacle : obstacles){
      if(obstacle.contains(endPoint)){
        return true;
      }
    }
    return false;
  }
  
  public float distance(){
    return PVector.dist(endPoint, startPoint);
  }
  
  public void draw(){
    stroke(255, 0, 0); //red
    strokeWeight(2);
    line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
    
  }
  
}
