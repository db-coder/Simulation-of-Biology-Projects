
Warm-Up Project: The Game of Life
CS 7492, Spring 2019
Due: Friday, January 18 at 11:59pm
Objective
There are several goals for this assignment. The first is for each of you to gauge your own programing skills and to verify that you will be able to do the later assignments. The second goal is to introduce you to the Processing language and development environment, since we will use it for all of the assignments. Finally, this project will give you some experience working with Cellular Automata.
Processing
We will use a language called "Processing" to carry out this (and later) assignments. Processing is a language very similar to C++ and Java, but it has a number of extra items that make it very easy to write simple interactive programs. Processing runs on several platforms, including Windows, Mac OS X and Linux. The main processing Web site is here:
http://www.processing.org/

I recommend looking at some example code to start with: 
http://www.processing.org/learning/basics/ (Basic examples) 
Documentation for various built-in routines are here: http://www.processing.org/reference/index.html

Download the appropriate version of the development environment for your machine: http://www.processing.org/download/

The development environment is described here: http://www.processing.org/reference/environment/index.html

You can also try out Greg's simple example code (shown in class).

Run the Processing environment and play around with it. I suggest starting with code from the examples page and modifying some examples to try new things.

A Life Simulator
You will write a cellular automata simulator for the game of Life, originally create by John Horton Conway. Life is simulated on a square grid of cells. Each cell is either live (white) or dead (black). The rules for life are simple. At each simulation step, a cell changes its live/dead state according to its last state and the number of live cells adjacent to it. Each cell is said to have eight neighbors, that is, diagonal neighbors count. The rules are simple: a live cell continues to live if it has two or three live neighbors. A dead cell is turned into a live cell if it has exactly three live neighbors. All other cells will be dead.
Your program will display the state of the simulation in a window that contains black and white cells. Here are some of the characteristics of this window:

The grid will be 100 by 100 cells.
Each cell should be at least six by six pixels in size (thus the screen must be at least 600 by 600 pixels).
The grid of cells is toroidal, that is, cells on the far left edge are neighbors to the cells on the far right edge. The top and bottom rows are also adjacent.
You will write a Life simulator that allows a user to create cell patterns by mouse clicks. When the user clicks on a black cell, it is turned to white. Clicking on a white cell changes it to black. Your simulator will also run in either of two modes: single-step or continuous. Various keys will control the behavior of your simulator. Here are the key controls and their behavior:
c,C - Clear the grid to all black.
r,R - Randomize the state of the grid (each cell is black or white with equal probability).
g,G - Toggle between single-step and continuous update mode.
space bar - Switch to single-step mode and take one simulation step.
If you would like to try out another Life simulator, I recommend the Golly simulator.
Routines to Use
The built-in functions for Processing are documented on this page:
http://www.processing.org/reference/index.html

There are several Processing functions that will be of particular help in doing this assignment. Here are some of them:

setup()
This is a routine that you must write. This routine is executed once when the program is first run. This is where you should set the screen size and initialize your rule table and cell grid.
draw()
This is a routine that you write, and it is the main loop for any Processing program. The code here will be executed continuously. When your program is in continuous update mode, this routine should take a simulation step and re-draw the grid.
keyPressed()
This routine is called when any key on the keyboard is pressed. You should then use "key" to check which key was pressed.
mousePressed()
This routine is called when a mouse button is pressed. Inside this routine, you will want to make use of the values of "mouseX" and "mouseY" to determine where the cursor was on the screen.
fill()

stroke()
    
Set the fill color and the outline color for objects that are to be drawn, such as a rectangle.
rect()
Draws a rectangle using on the current stroke and fill color.
background()
Set the color of the screen background.
random()
Returns a floating point random number.
delay()
Pauses the execution of your program for a given number of milliseconds. This can be useful for debugging.
Suggested Approach
If you are already comfortable programming in C, C++ or Java, you can skip this section. If you haven't done much programming in a while, I offer below some suggestions for how to approach this assignment. As with any programming project, it is best to write it in pieces and to test these pieces as you go.
First, create a data structure that will hold your grid of cells. Also write a few lines of code that places a simple life pattern (such as a glider) into your grid. Then write code to display the current grid of cells on the screen. As you write various pieces of code, try to keep each of them in a separate routine, that is, keep your code modular. For instance, your final code probably should have three separate routines for clearing, drawing and randomizing the grid of cells.

Once you can store and display a grid of cells, then it is time to work on user input. Play around with the "mousePressed()" routine and the variables "mouseX" and "mouseY". You will need to have a routine called "draw()", although it doesn't have to do anything at this point. You should be able to have a user click at a point on the screen, and then use this click position to alter the state of one of the cells in your grid (toggle it between white and black). Be sure to re-draw the grid of cells after each such user click.

Once you have the basics of mouse input down, you can add to your "draw()" routine. Each time through this routine, have your program perform one simulation step. This is a matter of using a temporary grid that contains a count of the number of neighbors for each cell in the main grid. With this count grid, you can then go through each cell in the grid and look up the appropriate state/count pair in your rule table to determine the new state of the cell. You may want to insert a "delay(1000)" in your draw routine to slow down the execution of your code during debugging. This will cause your program to pause for one second each time this line is executed.

After your program can take simulation steps, it is time to add the other key press behaviours. Use "keyPressed()" and the variable called "key" to do this.

Turning In Your Assignment
Turn in your Processing source code for this project on Canvas. You can turn in just one .pde file if all of your code is in a single file. If your project contains more than one file, you should zip up the entire project directory and turn this in.
Authorship Rules
The code that you turn in must be entirely your own. You are allowed to talk to other members of the class and to the teacher about general implementation issues. It is also fine to seek the help of others for general programming questions about Processing. You may not, however, use code that anyone other than yourself has written. Code that is explicitly not allowed includes code taken from the Web, from books, from previous assignments or from any source other than yourself. You should not show your code to other students. Feel free to seek the help of the teacher for suggestions about debugging your code. 