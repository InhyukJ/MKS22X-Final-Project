public class Event {
    private Obj a, b; //Ball, Wall

    public Event(Obj a, Obj b) {
	this.a = a;
	this.b = b;
    }

    public Obj getObj1() {
	return a;
    }

    public Obj getObj2() {
	return b;
    }

    private float distBallWall(Ball ball, Wall wall){
	float dist;
	if(wall.isHorizontal() && wall.isTopLeft()){ //horizontal top wall
	    dist = ball.getY() - ball.getRadius() - wall.getY() - 5;
	}else if(wall.isHorizontal()){ //horizontal bot wall
	    dist = wall.getY() - ball.getY() - ball.getRadius();
	}else if(wall.isTopLeft()){ //vertical left wall
	    dist = ball.getX() - ball.getRadius() - wall.getX() - 5;
	}else{ //vertical right wall
	    dist = wall.getX() - ball.getX() - ball.getRadius();
	}
	return Math.abs(dist);
    }
   
    //Distance between two objects, walls are offset by 30, 30
    public float distanceObj12() {
	if(!a.isWall() && !b.isWall()){//this will change once 2D is implemented
	    //System.out.println(Math.abs(a.getX() - b.getX()));
	    return Math.abs(a.getX() - b.getX()) - ((Ball)a).getRadius() - ((Ball)b).getRadius();
	    //boolean isTopLeft/isHorizontal
	    //isTopLeft && isHorizontal == North
	    //isTopLeft && !isHorizontal == West
	    //!isTopLeft && isHorizontal == South
	    //!isTopLeft && !isHorizontal == East
	}else if(a.isWall()){
	    return distBallWall((Ball)b, (Wall)a);
	}else{
	    return distBallWall((Ball)a, (Wall)b);
	}
	/*
	    if(a.isWall()){
		float ballB = 0.0f;
		if(((Wall)a).isHorizontal()){
		    if(((Wall)a).isTopLeft()){
			ballB = b.getY() + ((Ball)b).getRadius();
		    }else{
			ballB = b.getY() - ((Ball)b).getRadius();
		    }
		    return Math.abs(a.getY() - ballB);
		}else{
		    if (((Wall)a).isTopLeft()) ballB = b.getX() + ((Ball)b).getRadius();
		    else ballB = b.getX() + ((Ball)b).getRadius();
		    return Math.abs(a.getX() - ballB);
		}
	    }
	    else {
		float ballA = 0.0f;
		if (((Wall)b).isHorizontal()) {
		    if (((Wall)b).isTopLeft()) ballA = a.getY() + ((Ball)a).getRadius();
		    else ballA = a.getY() - ((Ball)a).getRadius();
		    return Math.abs(b.getY() - ballA);
		}
		else {
		    if (((Wall)b).isTopLeft()) ballA = a.getX() + ((Ball)a).getRadius();
		    else ballA = a.getX() - ((Ball)a).getRadius();
		    return Math.abs(b.getX() - ballA);
		}
	    }
	}
	*/
    }

    public float compareTo(Event other) {
	return this.distanceObj12() - other.distanceObj12();
    }

    public static void main(String[] args){

    }
}
