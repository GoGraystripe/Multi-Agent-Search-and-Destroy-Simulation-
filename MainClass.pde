public ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
public ArrayList<Target> targets = new ArrayList<Target>();
int numObstacles = 5;
int numTargets = 5;
public Robot robot;
public Sensor sensor;
public PVector velocityOfTarget = new PVector(1,1);



void setup() {
  size(900, 500);
  background(#000000);
  startMapBuild();
  
}



void startMapBuild(){
  for(int i = 0; i < numObstacles; i++){
    PVector position = new PVector(random(900), random(500));
    obstacles.add(new Obstacle(position, 40));
  }
  
  for(int i = 0; i < numTargets; i++){
    PVector position = new PVector(random(900), random(500));
    targets.add(new Target(position, velocityOfTarget, 10));
  }
  
  
  sensor = new Sensor();
  robot = new Robot(new PVector(random(900), random(500)), sensor);
  
  
  
}

void draw(){
  background(#000000);
  
  for(Obstacle obstacle : obstacles){
    obstacle.draw();
  }
  
  for(Target target : targets){
    target.draw();
    target.move();
  }
  
  robot.draw();
  robot.move();
  
  // Draw path trail
  stroke(#39FF14); // light blue, semi-transparent
  noFill();
  beginShape();
  for (PVector p : robot.trail) {
    vertex(p.x, p.y);
  }
  endShape();
  

  
}

void mousePressed(){
  robot.endGoal = new PVector(mouseX, mouseY);
  
  robot.velocity = new PVector(robot.endGoal.x - robot.position.x, robot.endGoal.y - robot.position.y);
  robot.velocity.normalize().mult(4);
}
