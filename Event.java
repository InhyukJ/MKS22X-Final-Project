public class Event {
    //private float time;
    private Obj a, b; //Ball, Wall

    public Event(Obj a, Obj b) {
	//this.time = time;
	this.a = a;
	this.b = b;
    }

    public Obj getObj1() {
	return a;
    }

    public Obj getObj2() {
	return b;
    }
    /*
    public float getTime() {
	return time;
    }
    */
   
    //Distance between two objects, walls are offset by 30, 30
    public float distanceObj12() {
	if (!a.isWall() && !b.isWall()) {//this will change once 2D is implemented
	    return Math.abs(a.getX() - b.getX());
	}
	else {
	    //boolean isTopLeft/isHorizontal
	    //isTopLeft && isHorizontal == North
	    //isTopLeft && !isHorizontal == West
	    //!isTopLeft && isHorizontal == South
	    //!isTopLeft && !isHorizontal == East
	    if (a.isWall()) {
		if (((Wall)a).isHorizontal()) {
		    return Math.abs(a.getY() - b.getY());
		}
		else {
		    return Math.abs(a.getX() - b.getX());
		}
	    }
	    else {
		if (((Wall)b).isHorizontal()) {
		    return Math.abs(b.getY() - b.getY());
		}
		else {
		    return Math.abs(b.getX() - b.getX());
		}
	    }
	}
    }

    public float compareTo(Event other) {
	return this.distanceObj12() - other.distanceObj12();
    } 
}
