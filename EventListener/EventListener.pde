import controlP5.*;
import java.util.*;
import java.lang.Thread;


class Simulator{
    PriorityQueueEvent PQ;
    ArrayList<Obj> objects;
    ControlP5 cp5;
    //may need to add variables controlled by the cp5 stuff
    
    Simulator(ControlP5 cp5) {
        objects = new ArrayList<Obj>();
        objects.add(new Wall(true, true));
        objects.add(new Wall(true, false));
        objects.add(new Wall(false, true));
        objects.add(new Wall(false, false));
        objects.add(new Ball(430, 200, 25, 25, 5, 180, true)); //based on default values
        objects.add(new Ball(230, 200, 40, 40, 10, 0, true)); //based on default values
        PQ = new PriorityQueueEvent();
        //based on ArrayList<Obj> objects, will create events and add them (or will it just be updated with the PQ.update?  
        //no... that only rearranges existing events)
        for(int i = 0; i < objects.size(); i++){
            for(int index = i + 1; index < objects.size(); index++){
                if(!(objects.get(i).isWall() && objects.get(index).isWall())){
                    PQ.add(new Event(objects.get(i), objects.get(index)));
                }
            }
        }
        this.cp5 = cp5;
    }
    
    ArrayList<Obj> getObjects(){
        return objects;
    }
    
    /*
      EventListener is basically doing this (for the repeating part) 
      when the start/play button has been pressed:
      *Delay time - the minimum time between "frames"/updates. I think this will help in keeping the 
      animation consistent. Maybe the delay time can be controlled by a slider (then it will change
      the simulation speed). The delay time is pretty small, since we want to keep the animation smooth
      - check if a collision has happened yet (ask PQ to reference the distance of the 
        root event
        - PQ.update()
        - if collision, recalculate velocity, direction, then update the objects' variables (not screen)
        - if no collision, wait for the delay time/keep looping 
      - update all displayed values (such as velocity) except for position of the ball
      - based on updated values, make the ball travel on-screen (i.e. update the visuals on screen)
        - in 1D, balls automatically move towards each other before the first collision, 
          so set the default direction (whenever the restart button is pressed) this way. 
          The changes in direction from following collisions is calculated from/during the 
          collision. (i.e. need restart method)
      Pause freezes the animation & calculations w/o program closing, so perhaps the 
      update/run function has a boolean parameter, which, if set to false, just waits for 
      the duration of the delay time instead of updating & delaying as usual
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
                ((Ball)Obj1).bounceB((Ball)Obj2, true); //just put a placeholder true for now. remember 
                //to update this statement based on the change you made to Ball.java
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
        
        //I think the code below is supposed to be within the if statement above, no? it's in the case of a collision, right?
        //also for that if statement, the else statement (just waiting for the duration of the delay time) needs to be 
        //included
  
        if (!Obj1.isWall()) { //NEEDS TO BE MODIFIED FOR 2D
            ((Ball)Obj1).setX(((Ball)Obj1).getX() + (((Ball)Obj1).getVel()));
        }
        else if (!Obj2.isWall()) {
            ((Ball)Obj2).setX(((Ball)Obj2).getX() + (((Ball)Obj2).getVel()));
        }

        PQ.update();
    }
    
   boolean isColliding(Event evt) { //so will check the root event i.e. event with smallest distanceObj12()
       //pre-condition: PQ.update(); 
      return evt.distanceObj12() < 5.0f;
   }
   
   void initialDraw(){ //will display walls, then create controlP5 stuff
       for(Obj object : objects){
          if(object.isWall()){ //draw walls (rect)
              rect(((Wall)object).getX(), ((Wall)object).getY(), ((Wall)object).getWidth(), ((Wall)object).getHeight());
          }else{ //draw balls (ellipse)
              ellipse(((Ball)object).getX(), ((Ball)object).getY(), ((Ball)object).getRadius(), ((Ball)object).getRadius());
          }
       }
       //draw labels for input areas (string)
       cp5 //create 
   }
   
   void reDraw(){ // to visually update screen. called every *insertDelayTime i.e. called everytime the simulation loops
       /*
         translate circles a very small amt and resize if needed
         will probably want to use a for loop, disregarding Walls
       */
       
   }
   
   void simLoop(boolean paused){ // the loop that puts all the helper functs together. should be called in draw()
       redraw();
   }
}



void setup(){
    size(1000, 600);
    Simulator simulator = new Simulator(new ControlP5(this));
    simulator.initialDraw();
}

void draw(){
  
}