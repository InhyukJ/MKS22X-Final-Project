import controlP5.*;
import java.util.*;
import java.lang.Thread;


class Simulator{
    PriorityQueueEvent PQ;
    ArrayList<Obj> objects;
    
    Simulator() {
        objects = new ArrayList<Obj>();
        objects.add(new Wall(true, true));
        objects.add(new Wall(true, false));
        objects.add(new Wall(false, true));
        objects.add(new Wall(false, false));
        objects.add(new Ball(300, 100, 25, 25, 5, 0, true)); //will need access to arguments. just putting in dummy arguments
        // first time, will create Balls, subsequent times, will change values
        PQ = new PriorityQueueEvent();
        
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
      
      Useful/Likely-To-Be-Used ControlP5 Classes:
      - Button
      - RadioButton
      - Slider
      - TextField
      - Toggle
      
      need restart() to reset values and display
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
  
        //update values
        //6/7/17
        //I'm not sure why you don't want me to change the X or the Y values,
        //but if those aren't changed here then there's nothing else to change
        //in 1D elastic total collision.
        
        //I meant don't change the X & Y in the textbox that the user uses to 
        //choose the initial position of the ball (the the simulation is restarted
    }
    
   boolean isColliding(Event evt) { //so will check the root event i.e. event with smallest distanceObj12()
       //pre-condition: PQ.update(); 
      return evt.distanceObj12() < 5.0f;
   }
   
   
ControlP5 cp5;
Accordion accordion;


void setup(){
    size(1000, 600);
    Simulator simulator = new Simulator();
    initialDraw();
    
}
   
   void initialDraw(){ //will display controlP5 stuff and walls
      cp5 = new ControlP5(this);
      
      //group 1, contains
      Group g1 = cp5.addGroup("1D vs 2D")
                    .setBackgroundColor(color(0, 64)) //placehold colors
                    .setBackgroundHeight(75)
                    ;
                    
     cp5.addRadioButton("radio")
        .setPosition(10, 30)
        .setItemWidth(20)
        .setItemHeight(20)
        .addItem("1D", 1)
        .addItem("2D", 2)
        .setColorLabel(color(225)) //placehold color
        .activate(1)
        .moveTo(g1)
        ;
        
     Group g2 = cp5.addGroup("Elasticity")
                   .setBackgroundColor(color(0, 64)) //placehold colors
                   .setBackgroundHeight(75)
                   ;
                   
     cp5.addRadioButton("radio")
       .setPosition(10, 30)
       .setItemWidth(20)
       .setItemHeight(20)
       .addItem("Elastic Collision", 1)
       .addItem("Inelastic Collision", 2)
       .setColorLabel(color(225)) //placehold color
       .activate(1)
       .moveTo(g2)
       ;
       
     Group g3 = cp5.addGroup("Size")
                   .setBackgroundColor(color(0, 64)) //ph colors
                   .setBackgroundHeight(100)
                   ;
                   
     cp5.addSlider("Ball 1")
        .setPosition(20, 20)
        .setSize(100, 20)
        .setRange(1, 50)
        .setValue(25)
        .moveTo(g3)
        ;
        
     cp5.addSlider("Ball 2")
        .setPosition(20, 60)
        .setSize(100, 20)
        .setRange(1, 50)
        .setValue(25)
        .moveTo(g3)
        ;
        
     Group g4 = cp5.addGroup("Speed")
                   .setBackgroundColor(color(0, 64))
                   .setBackgroundHeight(100);
     
     cp5.addSlider("Ball 1")
        .setPosition(20, 20)
        .setSize(100, 20)
        .setRange(1, 20)
        .setValue(10)
        .moveTo(g4)
        ;
        
     cp5.addSlider("Ball 2")
        .setPosition(20, 60)
        .setSize(100, 20)
        .setRange(1, 20)
        .setValue(10)
        .moveTo(g4)
        ;
 
     accordion = cp5.addAccordian("acc")
                    .setPosition(20, 20)
                    .setWidth(150)
                    .addItem(g1)
                    .addItem(g2)
                    .addItem(g3)
                    ;
    
     accordion.open(0, 1, 2, 3);
   }
   
   void reDraw(){ // to visually update screen. called every *insertDelayTime i.e. called everytime the simulation loops
       /*
         translate circles a very small amt and resize if needed
         will probably want to use a for loop, disregarding Walls
       */
       
   }
   
   void simLoop(boolean loop){ // the loop that puts all the helper functs together. should be called in draw()
     
   }
}

void draw(){
  
}