import java.util.*;

public class EventListener {
    private PriorityQueue<Event> PQ;
    
    public EventListener() {
	PQ = new PriorityQueue<Event>();
    }

    public void update() {
	Event pEvt = PQ.peek();
	if (isColliding(pEvt)) {
	    if (!(pEvt.getObj1).isWall() && !(pEvt.getObj2).isWall()) {
		(Ball)pEvt.
	
    }

    private boolean isColliding(Event evt) {
	return evt.distanceObj12() < 5.0f;
    }
