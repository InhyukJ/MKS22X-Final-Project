# MKS22X-Final-Project
<h1><u> Project Title: Collision Simulation </u></h1>
<h2> Team Name: Shrug (Inhyuk Jun & Winnie Chen Pd. 10) </h2>
<br>
<h3> Online Prototype Link </h3>
<a href="https://docs.google.com/a/stuy.edu/document/d/1zUjmv0Ju6JxZ-WDXiuN-f27jyM76EbTEz0Kuzz4Mg7s/edit?usp=sharing"> updated online version of prototype </a>
<br>
<!-- add in helpful diagrams (at end?) -->
<h3> Directions </h3>
<ol>
    <li> Run the EventListener.pde file in the <em>master</em> or <em>Winnie4</em> branch </li>
    <li> Enter new values into the corresponding textfields to change the mass (analogous to the radius of the balls in this case), velocity, and initial x-position of the two balls. </li>
    <li> Toggle the inelasticity switch to determine the behavior of the balls in collisions. <br>
    True = perfectly inelastic <br>
    False = elastic </li>
    <li> Use the simulation slider to speed up the rate of the simulation. </li>
    <li> Toggle the play button to play or pause the simulation. <br>
    True = simulation running <br>
    False = simulation paused </li>
    <li> The controllers above can be changed/used as the simulation is playing. However, the initial position of the balls will not affect the current positions of the balls. </li>
    <li> Use the restart button to restart the simulation, returning the balls to their specified initial positions. </li>
</ol>
<img src="Diagram of Features.jpg">
<h3> Features </h3>
<ul>
    <li> The Java program will calculate the predict collisions between two balls and the enclosing walls. The values and behavior of the balls will change accordingly. </li>
    <li> A window produced by Processing will show the changing positions of the 2 balls during the simulation. </li>
    <li> Mass, initial position, and velocity of the balls can be manipulated by the user with the text boxes. </li>
    <li> Simulation speed can be manipulated with the slider. </li>
    <li> The simulation can be started and paused with a toggle button. </li>
    <li> Elasticity can be toggled using a toggle button. </li>
    <li> The reset button will return the balls to the initial positions specified by the user. </li>
    <li> The balls' momentum and kinetic energy are displayed and updated for the user. </li>
</ul>
<br>
<h3> Known Bugs </h3>
<ul>
    <li> In the <em>Winnie4</em> branch, the center of the balls are used to detect collisions rather than the edge of the balls. </li>
    <li> In the <em>master</em> branch, the balls bounce before the edges actually touch. </li>
    <li> During collisions, balls seem to pause, then return to normal speed. </li>
    <li> The textfields of the simulation are not updated with the simulation. </li>
    <li> The balls sometimes get caught on a wall or pass through. </li>
    <li> The balls sometimes disappear after colliding. </li>
</ul>
<br>
<h3> UML Diagram </h3> <!-- to be updated at very end -->
    *For each instance variable, if logical, create get and set methods (not necessarily included in the UML diagram)
    <br>
    **For each ControlP5 controller, create a method with the same name (not necessarily included in the UML diagram)
    <br>
    <img src="CS Project Proposals & Prototype (Spring).jpg">
<br>
<b> Dev. Log </b>
<ul>
    <li> 2017-06-11 & 12
        <ul>  
            <li> Visual Setup Working (displays objects, ControlP5 elements, and text) </li>
        </ul>
    </li>
    <li> 2017-06-16
        <ul>  
            <li> Satisfactory Visualization of Perfectly Inelastic Collision </li>  
            <li> Added Elastic Calculations to Simulation </li>
            <li> Bug Fixes
                <ul>  
                    <li> Accounted for sleeping for a negative remaining time in looping </li>
                    <li> Fixed isColliding() and distance traveled when simulation running to detect ball-ball collisions </li> 
                    <li> Simulation Speed Simulator Works </li>
                </ul>
            </li>
        </ul>
    </li> 
    <li> 2017-06-17
        <ul>  
            <li> Momentum, and kinetic energy displayed </li> 
            <li> Bug Fixes
                <ul>
                    <li>  </li>
                </ul>
            </li>
        </ul>
    </li> 
    <li> 2017-06-18
        <ul> 
            <li> Bug Fixes
                <ul>
                    <li> Dealt with non-numeric arguments from textfields </li>
                </ul>
            </li>
        </ul>
    </li>
</ul>
