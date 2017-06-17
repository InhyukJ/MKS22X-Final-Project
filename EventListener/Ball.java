import java.lang.Math;

public class Ball implements Obj{
    private float radius, x, y, vel, velDir, mass;
    private boolean elasticity;
    
    public Ball(float x, float y, float radius, float mass, float vel, float velDir, boolean elasticity) {
	this.x = x;
	this.y = y;
	this.radius = radius;
	this.mass = mass;
	this.vel = vel;
	this.velDir = velDir; //theta, degrees
	this.elasticity = elasticity;
    }
    
    public void addXY(float X, float Y) {
	x += X;
	y += Y;
    }
    
    public void addVel(float velocity) {
	vel += velocity;
    }

    public void bounceX() {
      //System.out.println("BonceX");
	velDir = adjust(180 - velDir);
    }

    public void bounceY() {
	velDir = 360 - velDir;
    }
    
    public void bounceB(Ball other, boolean elasticity) { //Elastic collision
	float otherM = other.getMass();
	float M = this.getMass();
  //System.out.println("bounceB");
	
	if (elasticity) { //For both balls, velocity and final angles are same
	    //calculate velocity
	    float fVel = ((M * getVel()) + (otherM * other.getVel())) / (M + otherM);
	    setVel(fVel);
	    other.setVel(fVel);

	    if (M > otherM) other.setVelDir(getVelDir());
	    else setVelDir(other.getVelDir());
	}
	else {
	    float cDir = ((float)Math.toDegrees(Math.atan((double)((other.getY() - getY()) / (other.getX() - getX()))))); //velDir between the centers, in degrees
	    float cDirO = 0.0f;
	    if (getY() > other.getY()) {
		cDirO = adjust(cDir + 180);
	    }
	    else {
		cDirO = cDir;
		cDir = adjust(cDir + 180);
	    }
	    setVelDir((cDir + getVelDir()) / 2);
	    other.setVelDir((cDirO + other.getVelDir()) / 2);
	    
	    float newVel = (((M - otherM)/(M + otherM)) * getVel()) + (((2 * otherM)/(M + otherM)) * other.getVel());
	    setVel(newVel);
	    
	    float newVel2 = (((otherM - M)/(M + otherM)) * other.getVel()) + (((2 * otherM)/(M + otherM)) * getVel());
	    other.setVel(newVel2);
	}
    }

    //Getters and Setters
    public float getX() {return x;}
    public float getY() {return y;}
    public float getRadius() {return radius;}
    public float getMass() {return mass;}
    public float getVel() {return vel;}
    public float getVelDir() {return velDir;}

    public float momentum(){
	return mass * vel;
    }

    public float kineticEnergy(){
	return (1.0f / 2.0f) * mass * (float)(Math.pow(vel, 2));
    }
    
    public void setX(float x) {this.x = x;}
    public void setY(float y) {this.y = y;}
    public void setVel(float vel) {this.vel = vel;}
    public void setVelDir(float velDir) {this.velDir = velDir;}
    public void setMass(float mass){this.mass = mass;}
    public void setRadius(float radius){this.radius = radius;}
    

    public boolean isWall() {
	return false;
    }

    private float adjust(float theta) {
	if (theta > 360) return theta - 360;
	else if (theta < 0) return theta + 360;
	else return theta;
    }
}