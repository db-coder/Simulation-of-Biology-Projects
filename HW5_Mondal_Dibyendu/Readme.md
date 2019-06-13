Objective
The goal of this assignment is for you to create a simple predatory/prey simulation, based on the WATOR simulation method.  Fish and sharks will live on a 2D grid of squares, and the sharks will eat the fish.  Over time, the population of the fish and the sharks will rise and fall according to their interactions.

Simulation
You will write a WATOR simulator using Processing.  This will be somewhat similar to the Life cellular automata, since both simulations are carried out on regular grids.  Whereas the Life rules are deterministic, however, the WATOR rules have an element of randomness to them.

Some characteristics of your simulator:

Your display window will be separated into two parts, the simulation grid and the phase portrait.
In one sub-region of the screen, draw a grid of cells where each of the cell states EMPTY, FISH, and SHARK are easy to tell apart.
To the right of this grid, create another region of the screen for drawing the phase portrait of the population.
Your entire window size should be at most 1350 x 850 in size (so that it will fit on the screen I use to look at your assignments).  The two sub-screens do not need to be the same size, nor do they have to be exactly square.
When fish and sharks move off one edge of the grid, they should appear on the other side (toroidal wrapping).
Your simulator should act on this set of keyboard commands:

space bar - Stop or start the simulation (toggle between these).
s - Take a single simulation step (leaving the simulation stopped).
r - Randomly re-initialize all of the cells in the grid.
- (minus sign) - Decrease the grid square size and randomize the grid.
=,+ - Increase the grid square size and randomize the grid.
You may use either of two approaches for the WATOR rules for FISH and SHARKS.  You can use the original A.K. Dewdney approach (paper herePreview the document), or you may use the slightly less ambiguous approach from Durrett and Levin (paper herePreview the document).  The rules you use should include birth of fish and sharks, sharks eating fish, sharks dying of hunger, and random motion of both fish and sharks.  Note that neither fish nor sharks die of old age.  If you use the Dewdney approach, make sure to visit the grid cells in a random order, otherwise your patterns will be incorrectly biased towards particular directions.

No matter which approach you take, there are three parameters to set.  Here are the default values that you should use for these parameters:

FISH_BREED = 6
SHARK_BREED = 12
SHARK_STARVE = 8
The first two values indicate how many time steps should pass between a fish or shark giving birth.  SHARK_STARVE indicates how many time steps a shark can go without food before it dies of hunger.  Please consult one or both papers for details on the rules of WATOR.

Grid Size
The size of the grid that you use should be adjustable using the - and = keys.  The size of the grid is determined indirectly based on the size of one cell (in pixels).  Let the size of a cell (the number of pixels wide) be given by the cell_size variable.  Assume, for example, that the region for drawing the grid is a square of 400 by 400 pixels.  When cell_size is equal to 10, the grid size is 40 by 40 cells.  When cell_size is 4, the grid size is 100 by 100 cells.  When cell_size is 1, the grid size is 400 by 400.  Pressing the - key should decrease the cell_size by one, and the = key should increase the cell_size by one.  The lowest allowed value of cell_size is one, and the largest values should be at least 16.  Note that when cell_size is large, the grid resolution will be small.

The easiest way to achieve the above is to allocate space for the largest possible grid resolution.  This will be needed when cell_size equals one.  When simulating a lower resolution grid, you will just not use some of the grid cells.

Avoid Shark Extinction
At very low grid resolutions, the sharks may entirely die out and the screen will then fill with fish.  Automatically detect such an extinction event, and add a small number of sharks at random so that this situation is avoided.

Phase Portrait
To the right of the fish/shark grid, you will draw a phase portrait that shows the recent history of the fish and shark population.  The horizontal axis represents the fraction of cells that are fish, with larger values being further to the right.  The vertical axis represents the fraction of cells that are sharks, with larger values being towards the top.  Keep track of a recent history of these values from the last 200 time steps.  Each new time step, plot all of these recent values.  You can choose to plot these as individual dots, or you can connect them with lines.

Because there are usually very few sharks, you may want to scale the vertical (shark) axis to use more of the vertical space.  It is okay in the case of some extreme population values that the plot points go off the screen.

Correct Behavior of Simulation
Because the update rules are random, you should use indirect clues to tell if your simulator is working properly.  First, single-step your simulator and watch one particular isolated fish.  It should often move randomly to an adjacent cell.  The same should be true for an isolated shark.

When you let the simulator run fast, you should notice a rise and fall of the populations of fish and sharks.  At certain times, the population of fish will be on the rise, and large regions of the screen will become almost a solid region of fish.  Sharks should then begin eating these fish, usually on one side of the region of fish.  The fish should tend to expand into the empty regions of the grid.

Because of the rise and fall of fish and shark populations, the phase portrait will change over time.  In most cases, the motion of the phase should be roughly in a counter-clockwise direction.

Below are some snapshots of a WATOR simulation.  Be aware that, due to randomness, each run of the simulator looks different than another.

wator_01.jpg

wator_02.jpg

wator_03.jpg

wator_04.jpg

Processing
As usual, we will use "Processing" to carry out this assignment:

http://www.processing.org/ (Links to an external site.)Links to an external site.

For any large project such as this, I recommend backing up your work often. You don't want to put in a ton of work and then accidentally delete all of it.

Authorship Rules
The code that you turn in must be entirely your own. You are allowed to talk to other members of the class and to the teacher about general implementation issues. It is also fine to seek the help of others for general programming questions about Processing. You may not, however, use code that anyone other than yourself has written. Code that is explicitly not allowed includes code taken from the Web, github, from books, or from any source other than yourself. You should not show your code to other students. Feel free to seek the help of the instructor for suggestions about debugging your code.

Turning In Your Assignment
Turn in your project on Canvas. Please zip up the Processing folder that contains your code and submit this zip file. Do NOT use tar or rar to compress your folder.