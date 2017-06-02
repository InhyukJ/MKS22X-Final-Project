public class Ball {
    private float radius, x, y, vel, velDir, mass;
    
    public Ball(float x, float y, float radius, float mass, float vel, float velDir) {
	this.x = x;
	this.y = y;
	this.radius = radius;
	this.mass = mass;
	this.vel = vel;
	this.velDir = velDir; //theta
    }
    
    public void addXY(float X, float Y) {
	x += X;
	y += Y;
    }
    
    public void addVel(float velocity) {
	vel += velocity;
    }

    public void bounceX() {
	velDir *= -1;
    }

    public void bounceY() {
	velDir *= -1;
    }
    
    public void bounceB() {
	velDir *= -1;
    }

    //Getters and Setters
    public float getX() {return x;}
    public float getY() {return y;}
    public float getRadius() {return radius;}
    public float getMass() {return mass;}
    public float getVel() {return vel;}
    public float getVelDir() {return velDir;}
    
    public void setX(float x) {this.x = x;}
    public void setY(float y) {this.y = y;}
    public void setVel(float vel) {this.vel = vel;}
}
