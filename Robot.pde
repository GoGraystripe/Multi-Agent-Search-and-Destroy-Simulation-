class Robot{
  PVector position;
  float angle;
  PVector velocity;
  Sensor sensor;
  float stepX = 20;
  float stepY = 20;
  int counter = 0;
  
  float step = 10;
  float range = 50; //placeholders for now
  public Target target = null;
  boolean targetLocked = false;
  PVector endGoal;

  
  //-----
  ArrayList<PVector> trail = new ArrayList<PVector>();
  
  public Robot(PVector position, Sensor sensor){
    this.position = position.copy();
    endGoal = this.position.copy();
    this.sensor = sensor;
    velocity = new PVector(endGoal.x - position.x, endGoal.y - position.y);
    velocity.normalize().mult(4);
    velocity.normalize();
    velocity.mult(4);
  }
  
  public void move(){
    float distToGoal = PVector.dist(endGoal, position);
    if(distToGoal < 5){
      return;
    }
    //drawTrail();
    avoid();
    if(targetLocked){
      followTarget();
    }
    else{
      moveToAssigndPosition();
    }
    
  }
  
  void followTarget(){
      PVector originalEndGoal = endGoal.copy();
      velocity.normalize().mult(4);
      position.add(velocity);
      if(PVector.dist(position, target.position) < 5){
        targetLocked = false; //target has been destroyed;
        target.destroy();
        endGoal = originalEndGoal;
      }
      
  }
  
  void moveToAssigndPosition(){
    velocity = new PVector(endGoal.x - position.x, endGoal.y - position.y);
    velocity.normalize().mult(4);
    position.add(velocity);
    
  }
  
  
  void wrap(){
    if (position.x < 0) position.x = width;
    if (position.x > width) position.x = 0;
    if (position.y < 0) position.y = height;
    if (position.y > height) position.y = 0;
  }
  
  public void avoid(){
    sensor.castRay(this, step, range);
    if(sensor.detectedObstacle){
      velocity.rotate(0.1);
    }
    else{
      PVector goalVelocity = new PVector(endGoal.x - position.x, endGoal.y - position.y);
      goalVelocity.normalize();
      goalVelocity.mult(4);
      velocity.lerp(goalVelocity, 0.05);
    }
  }
  

  
  public void draw(){
    
    fill(#39FF14);
    stroke(0);
    strokeWeight(1);
    ellipse(position.x, position.y, 2, 2);
    
    pushMatrix();
    translate(position.x, position.y);
    
    if(velocity.mag() > 0){
      rotate(velocity.heading());
    }
    
    float length = 30;
    float halfBase = 10;
    
    fill(#39FF14);
    stroke(0);
    strokeWeight(2);
    
    triangle(length / 2, 0,
    - length / 2, -halfBase,
    - length / 2, halfBase
    );
    
    
    
    popMatrix();
    if(endGoal != null){
      float distToGoal = PVector.dist(endGoal, position);
      if(distToGoal >= 5){
        fill(50, 50, 50);
        stroke(0);
        strokeWeight(1);
        ellipse(endGoal.x, endGoal.y, 10, 10);
      }
    }
    
  }
  
  void drawTrail(){
    trail.add(position.copy());
    if (trail.size() > 1000) {
      trail.remove(0);
    }
  }

}
