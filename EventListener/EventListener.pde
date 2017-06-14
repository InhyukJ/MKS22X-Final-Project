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
        mass1 = 25;
        mass2 = 10;
        iPosX1 = 230;
        iPosX2 = 430;
        spd1 = 5;
        spd2 = 10;
        
        objects.add(new Ball(iPosX1, 200, mass1, mass1, spd1, 180, true)); //based on default values
        objects.add(new Ball(iPosX2, 200, mass2, mass2, spd2, 0, true)); //based on default values
        //should take in values from ControlP5
        initialDraw();
        
        PQ = new PriorityQueueEvent();
        //based on ArrayList<Obj> objects, will create events and add them
        for(int i = 0; i < objects.size(); i++){
            for(int index = i + 1; index < objects.size(); index++){
                if(!(objects.get(i).isWall() && objects.get(index).isWall())){
                    PQ.add(new Event(objects.get(i), objects.get(index)));
                }
            }
        }
    }
    
    ArrayList<Obj> getObjects(){return objects;}
    boolean getPlay(){return play;}
    float getSimSpd(){return simSpd;}
    float getMass1(){return mass1;}
    float getMass2(){return mass2;}
    float getIPosX1(){return iPosX1;}
    float getIPosX2(){return iPosX2;}
    float getSpd1(){return spd1;}
    float getSpd2(){return spd2;}
    
    void setPlay(boolean play){this.play = play;}
    void setSimSpd(float simSpd){this.simSpd = simSpd;}
    void setMass1(float mass1){this.mass1 = mass1;}
    void setMass2(float mass2){this.mass2 = mass2;}
    void setIPosX1(float iPosX1){this.iPosX1 = iPosX1;}
    void setIPosX2(float iPosX2){this.iPosX2 = iPosX2;}
    void setSpd1(float spd1){this.spd1 = spd1;}
    void setSpd2(float spd2){this.spd2 = spd2;}
     
    /*
    void update() {
      //Thread.sleep(someDelayTime)
      updateH();
    }
    */
   
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
   
   void initialDrawCP5() {
       //draw labels for input areas (string)
       PFont font = createFont("Arial", 24, true);
       text("Ball 1", 30, 430);
       text("Ball 2", 30, 500);
       text("Mass (kg)", 80, 400);
       text("Position (m)", 160, 400);
       text("Velocity (m/s)", 240, 400);
       cp5.addButton("Restart") //create Restart button
          .setPosition(690, 30)
          .setValue(0);
       cp5.addToggle("Play") //create Play toggle
          .setPosition(770, 30)
          .setValue(false)
          .setMode(ControlP5.SWITCH);
       cp5.addSlider("Simulation Speed") //create sim spd slider
          .setPosition(820, 30)
          .setRange(1, 5);
       //cp5.addToggle("") //add in extra options later
          //.setPosition(300, 500)
          //.setValue(false);
       cp5.addTextfield("m1")
          .setPosition(80, 410)
          .setSize(60, 20)
          .setText("25")
          .setValue(25);
       cp5.addTextfield("m2")
          .setPosition(80, 480)
          .setSize(60, 20)
          .setText("10")
          .setValue(10);
       cp5.addTextfield("x1")
          .setPosition(160, 410)
          .setSize(60, 20)
          .setText("230")
          .setValue(230);
       cp5.addTextfield("x2")
          .setPosition(160, 480)
          .setSize(60, 20)
          .setText("430")
          .setValue(430);
       cp5.addTextfield("v1")
          .setPosition(240, 410)
          .setSize(60, 20)
          .setText("5")
          .setValue(5);
       cp5.addTextfield("v2")
          .setPosition(240, 480)
          .setSize(60, 20)
          .setText("10")
          .setValue(10);
   }
   
   void initialDraw(){ //will display walls, then create controlP5 stuff
       for(Obj object : objects){
          if(object.isWall()){ //draw walls (rect)
              rect(((Wall)object).getX(), ((Wall)object).getY(), ((Wall)object).getWidth(), ((Wall)object).getHeight());
          }else{ //draw balls (ellipse)
              ellipse(((Ball)object).getX(), ((Ball)object).getY(), ((Ball)object).getRadius(), ((Ball)object).getRadius());
          }
       }
       //ctrl + X
       //? what is the shortcut commented above for?
   }
   
    void generalVarUpdate(){ //uses instance variables to update balls' vel, velDir, mass, and radius
        Ball b1 = (Ball)(objects.get(4));
        Ball b2 = (Ball)(objects.get(5));
        
    }
   
   void reDraw(){ // to visually update screen. called every *insertDelayTime i.e. called every time the simulation loops
       /*
         translate circles a very small amt and resize if needed
         will probably want to use a for loop, disregarding Walls
       */
       
   }
   
    void simLoop(boolean paused){ // the loop that puts all the helper functs together. should be called in draw()
        long startTime = System.currentTimeMillis();
        //use appropriate instance variable values
        if(paused){
            //visually update ball radius
        }else{
            //translate balls (will have to figure out x- & y- components & update visually
            if(isColliding(PQ.peek())){
                //update instance vars & textfields of balls based on collision calculations
            }
        }
        long endTime = System.currentTimeMillis();
        long elapsedTime = endTime - startTime;
        //figure out totalDelayTime based on simSpd
        long remainingTime = totalDelayTime - elapsedTime;
        Thread.sleep(remainingTime);
        //redraw();
    }
}


public void Restart(int theValue){
    //System.out.println("restarted");
    ((Ball)(simulator.getObjects()).get(4)).setX(simulator.getIPosX1());
    ((Ball)(simulator.getObjects()).get(5)).setX(simulator.getIPosX2());
    cp5.getController("Play").setValue(0);
}

public void Play(int theValue){
    //System.out.println("play toggled: " + cp5.getController("Play").getValue());
    if(cp5.getController("Play").getValue() == 1.0){
        simulator.setPlay(true);
    }else{
        simulator.setPlay(false);
    }
}

//for changes to simSpd

public void m1(String theText){ //triggered/updated when ENTER key pressed
    //System.out.println("m1 changed: " + Float.parseFloat(theText));
    simulator.setMass1(Float.parseFloat(theText));
    //cp5.getController("m1").setText(theText); //must re-display entered value--------error----------
}

//other text fields
//add instructions and error-handling for non-numerical inputs

public void m2(String theText){
    //System.out.println("m2 changed: " + Float.parseFloat(theText));
    simulator.setMass2(Float.parseFloat(theText));
}

public void x1(String theText){
    //System.out.println("x1 changed: " + Float.parseFloat(theText));
    simulator.setIPosX1(Float.parseFloat(theText));
}

public void x2(String theText){
    //System.out.println("x2 changed: " + Float.parseFloat(theText));
    simulator.setIPosX2(Float.parseFloat(theText));
}

public void v1(String theText){
    //System.out.println("v1 changed: " + Float.parseFloat(theText));
    simulator.setSpd1(Float.parseFloat(theText));
}

public void v2(String theText){
    //System.out.println("v2 changed: " + Float.parseFloat(theText));
    simulator.setSpd2(Float.parseFloat(theText));
}


ControlP5 cp5;
Simulator simulator;

void setup(){
    size(1000, 600);
    background(0);
    cp5 = new ControlP5(this);
    simulator = new Simulator(cp5);
}

void draw(){
    
}