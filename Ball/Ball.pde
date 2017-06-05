class Ball {
  float radius, x, y, vel, velDir, mass;
  
  public Ball(float x, float y, float radius, float mass, float vel, float velDir) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.mass = mass;
    this.vel = vel;
    this.velDir = velDir; //theta
  }
  
  void addXY(float X, float Y) {
    x += X;
    y += Y;
  }
  
  void 
}