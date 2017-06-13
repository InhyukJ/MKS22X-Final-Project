import controlP5.*;
import java.util.*;
import java.lang.*;


class Simulator{
    PriorityQueueEvent PQ;
    ArrayList<Obj> objects;
    ControlP5 cp5;
    boolean play;
    float simSpd;
    float mass1;
    float mass2;
    float iPosX1;
    float iPosX2;
    float spd1;
    float spd2;
    
    Simulator(ControlP5 cp5) {
        objects = new ArrayList<Obj>();
        objects.add(new Wall(true, true));
        objects.add(new Wall(true, false));
        objects.add(new Wall(false, true));
        objects.add(new Wall(false, false));
        
        this.cp5 = cp5;
        initialDrawCP5();
        play = false;
        simSpd = 1;
        mass1 = cp5.getController("m1").getValue();
        mass2 = cp5.getController("m2").getValue();
        iPosX1 = cp5.getController("x1").getValue();
        iPosX2 = cp5.getController("x2").getValue();
        spd1 = cp5.getController("v1").getValue();
        spd2 = cp5.getController("v2").getValue();
        
        objects.add(new Ball(iPosX1, 200, mass1, mass1, spd1, 180, true)); //based on default values
        objects.add(new Ball(iPosX2, 200, mass2, mass2, spd2, 0, true)); //based on default values
        //should take in values from ControlP5
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
        initialDraw();
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
   
   void initialDrawCP5(){ //will create controlP5 stuff
       cp5.addButton("Restart") //create Restart button
          .setPosition(690, 30)
          .setValue(0);
       cp5.addToggle("Play") //create Play toggle
          .setPosition(770, 30)
          .setValue(false)
          .setMode(ControlP5.SWITCH);
       cp5.addSlider("Simulation Speed") //create sim spd slider
          .setPosition(820, 30)
          .setRange(0, 5);
       //cp5.addToggle("") //add in extra options later
          //.setPosition(300, 500)
          //.setValue(false);
       cp5.addTextfield("m1")
          .setPosition(80, 410)
          .setSize(60, 20)
          .setText("25");
       cp5.addTextfield("m2")
          .setPosition(80, 480)
          .setSize(60, 20)
          .setText("25");
       cp5.addTextfield("x1")
          .setPosition(160, 410)
          .setSize(60, 20)
          .setText("230");
       cp5.addTextfield("x2")
          .setPosition(160, 480)
          .setSize(60, 20)
          .setText("430");
       cp5.addTextfield("v1")
          .setPosition(240, 410)
          .setSize(60, 20)
          .setText("5");
       cp5.addTextfield("v2")
          .setPosition(240, 480)
          .setSize(60, 20)
          .setText("10");
   }
   
   void initialDraw(){ //will display walls
       for(Obj object : objects){
          if(object.isWall()){ //draw walls (rect)
              rect(((Wall)object).getX(), ((Wall)object).getY(), ((Wall)object).getWidth(), ((Wall)object).getHeight());
          }else{ //draw balls (ellipse)
              ellipse(((Ball)object).getX(), ((Ball)object).getY(), ((Ball)object).getRadius(), ((Ball)object).getRadius());
          }
       }
       //draw labels for input areas (string)
       PFont font = createFont("Arial", 24, true);
       //fill(0);
       text("Ball 1", 30, 430);
       text("Ball 2", 30, 500);
       text("Mass (kg)", 80, 400);
       text("Position (m)", 160, 400);
       text("Velocity (m/s)", 240, 400);
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
   
   void restarted(){
       //cp5. //change toggle
       ((Ball)objects.get(4)).setX(iPosX1);
       ((Ball)objects.get(5)).setX(iPosX2);
   }
   
   boolean getPlay(){return play;}
   float getSimSpd(){return simSpd;}
   float getMass1(){return mass1;}
   float getMass2(){return mass2;}
   float getIPosX1(){return iPosX1;}
   float getIPosX2(){return iPosX2;}
   float getSpd1(){return spd1;}
   float getSpd2(){return spd2;}
   
   void setPlay(boolean play){this.play = play;}
   //void setSimSpd(float
}


public void Restart(int theValue){
    //println("pressed");
    //cp5. //set play to false
    //play = false;
    
}

public void m1(String theText){
    
}

Simulator simulator = new Simulator(new ControlP5(this));

void setup(){
    size(1000, 600);
    background(0);
    //Simulator simulator = new Simulator(new ControlP5(this));
    //simulator.initialDraw();
}

void draw(){
  
}