import controlP5.*;
ControlP5 cp5;
import java.util.*;
import java.lang.Thread;


class Simulator{
    PriorityQueue<Event> PQ;
    ArrayList<Obj> objects;
    
    Simulator() {
        objects = new ArrayList<Obj>();
        objects.add(new Wall(true, true));
        objects.add(new Wall(true, false));
        objects.add(new Wall(false, true));
        objects.add(new Wall(false, false));
        objects.add(new Ball(
        PQ = new PriorityQueue<Event>();
        
    }
    
    ArrayList
    
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
     
    void update() {
      //Thread.sleep(someDelayTime)
      updateH();
   }
   
    void updateH() {
        Event pEvt = PQ.peek();
        Obj Obj1 = pEvt.getObj1();
        Obj Obj2 = pEvt.getObj2();
        if (isColliding(pEvt)) {
            if (!Obj1.isWall() && !Obj2.isWall()) {
                ((Ball)Obj1).bounceB((Ball)Obj2);
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
  
        if (!Obj1.isWall()) { //NEEDS TO BE MODIFIED FOR 2D
            ((Ball)Obj1).setX(((Ball)Obj1).getX() + (((Ball)Obj1).getVel()));
        }
        else if (!Obj2.isWall()) {
            ((Ball)Obj2).setX(((Ball)Obj2).getX() + (((Ball)Obj2).getVel()));
        }

        PQ.update();
  
        //update values
        //6/7/17
        //I'm not sure why you don't want me to change the X or the Y values,
        //but if those aren't changed here then there's nothing else to change
        //in 1D elastic total collision.
        
        //I meant don't change the X & Y in the textbox that the user uses to 
        //choose the initial position of the ball (the the simulation is restarted
    }
    
   boolean isColliding(Event evt) {
      return evt.distanceObj12() < 5.0f;
   }
}


void setup(){
    Simulator simulator = new Simulator();
    for(
}

void draw(){
  
}