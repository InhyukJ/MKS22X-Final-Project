public class Ball {
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
	velDir = 180 - velDir;
	if (velDir < 0) velDir += 360;
    }

    public void bounceY() {
	velDir = 360 - velDir;
    }
    
    public void bounceB(Ball other, boolean elasticity) { //Elastic collision
	velDir *= -1;
	float otherM = other.getMass();
	float M = getMass();
	float newVel = (((M - otherM)/(M + otherM)) * getVel()) + (((2 * otherM)/(M + otherM)) * other.getVel());
	setVel(newVel);

	float newVel2 = (((otherM - M)/(M + otherM)) * other.getVel()) + (((2 * otherM)/(M + otherM)) * getVel());
	other.setVel(newVel2);
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

    public boolean isWall() {
	return false;
    }
    public boolean isHorizontal() {
	return false;
    }
    public boolean isTopLeft() {
	return false;
    }
}
