
import java.util.*;

public class EventListener {
    private PriorityQueue<Event> PQ;
    
    public EventListener() {
	PQ = new PriorityQueue<Event>();
    }

    /*
      EventListener is basically doing this (for the repeating part) 
      when the start/play button has been pressed:
      *I think it will be good to have a delay time, which would basically be the 
      minimum time between "frames"/updates. I think this will help in keeping the 
      animation consistent
      - check if a collision has happened yet (ask PQ to reference the distance of the 
        root event
        - I just realized we have a little problem b/c the PQ has to be updated constantly 
	  according to the changing distances... I'll think of something
	- if collision, recalculate velocity, direction, then update the objects
	- if no collision, wait for the delay time/keep looping 
      - update all displayed values (such as velocity) except for position of the ball
      - based on updated values, make the ball travel on-screen 
        - in 1D, balls automatically move towards each other before the first collision, 
	  so set the default direction (whenever the restart button is pressed) this way. 
	  The changes in direction from following collisions is calculated from/during the 
	  collision.

      Pause freezes the animation & calculations w/o program closing, so perhaps the 
      update/run function has a boolean parameter, which, if set to false, just waits for 
      the duration of the delay time instead of updating & delaying as usual

      Useful/Likely-To-Be-Used ControlP5 Classes:
      - Button
      - CheckBox
      - RadioButton
      - Slider
      - TextField
      - Toggle
     */

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
