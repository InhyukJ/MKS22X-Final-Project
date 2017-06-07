import java.util.*;

public class EventListener {
    private PriorityQueue<Event> PQ;
    
    public EventListener() {
	PQ = new PriorityQueue<Event>();
    }

    public void update() {
	Event pEvt = PQ.peek();
	Obj Obj1 = pEvt.getObj1();
	Obj Obj2 = pEvt.getObj2();
	if (isColliding(pEvt)) {
	    if (!Obj1.isWall() && !Obj2.isWall()) {
		((Ball)Obj1).bounceB();
		((Ball)Obj2).bounceB();
	    }
	    else if (!Obj1.isWall()) {
		if (!((Wall)Obj2).isHorizontal()) ((Ball)Obj1).bounceY();
		else ((Ball)Obj1).bounceX();
	    }
	    else {
		if (((Wall)Obj1).isHorizontal()) ((Ball)Obj2).bounceY();
		else ((Ball)Obj2).bounceX();
	    }
	}
    }
    
    private boolean isColliding(Event evt) {
	return evt.distanceObj12() < 5.0f;
    }
}
