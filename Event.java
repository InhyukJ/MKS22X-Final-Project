public class Event {
    private float time;
    private Obj a, b; //Balls

    public Event(float time, Obj a, Obj b) {
	this.time = time;
	this.a = a;
	this.b = b;
    }

    public Obj getObj1() {
	return a;
    }

    public Obj getObj2() {
	return b;
    }

    public float getTime() {
	return time;
    }
   
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
		if (a.isTopLeft() && a.isHorizontal())
	    return Math.abs(a.getX() - b.getX())
    }
