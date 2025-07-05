class Sensor{
  boolean detectedObstacle;
  PVector endPoint;
  ArrayList<Ray> rays = new ArrayList<Ray>();
  int triggeredRayIndex = -1;
  int numRays = 10;
  int angleRange = 60;
  
  public Sensor(){
    detectedObstacle = false;
  }
  
  public void castRay(Robot robot, float step, float range){
    rays.clear();
    //adding 3 rays:
    for(int i = 0; i < numRays; i++){
      rays.add(new Ray(robot.position.copy(), step, range, robot.velocity.copy().rotate(radians(angleRange / 2 - (angleRange/numRays) * i))));
    }
    detectedObstacle = false;
    
    for(int i = 0; i<rays.size(); i++){
      rays.get(i).cast(robot);
      rays.get(i).draw();
      detectedObstacle = rays.get(i).terminates(robot);
      if(detectedObstacle){
        triggeredRayIndex = i;
        println("ray "+i+" hit? "+rays.get(i).terminates(robot));
        break;
      }
    }
    
  }
  
}
