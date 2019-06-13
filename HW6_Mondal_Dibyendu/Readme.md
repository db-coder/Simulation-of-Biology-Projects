Chose One Option
In this assignment, you will chose to do either a mass-spring simulator, or a plant growth simulator.  Do not do both!  Below are descriptions of both of these options.  Please pay special attention to the materials that you turn in besides your source code (description of project, images or video).

Authorship Rules (Both Options)
The code that you turn in must be entirely your own. You are allowed to talk to other members of the class and to the teacher about general implementation issues. It is also fine to seek the help of others for general programming questions about Processing. You may not, however, use code that anyone other than yourself has written. Code that is explicitly not allowed includes code taken from the Web, github, from books, or from any source other than yourself. You should not show your code to other students. Feel free to seek the help of the instructor for suggestions about debugging your code.

 

Mass-Spring Locomotion (Option 1)
Objective
The purpose of this project is for you to learn about physical simulation by creating a mass/spring system. Mass/spring systems can be used to explore a wide variety of biological phenomena. For this project, you will create a mass/spring simulator and then use it to demonstrate some form of animal locomotion. The form of locomotion is up to you. It can be crawling, walking, swimming, hopping, or flying. Depending on the type of locomotion that you choose, you will include interaction between your animals and the ground, water, or air. In order to cause your creatures to move, you will modify the rest lengths of their springs over time. You can choose to simulate your animals in 2D or 3D.

Mass/Spring Creature Simulation
This project is more open-ended than prior course projects. You can choose the kind of virtual creature you will make. You can attempt to model a real-world animal, or you can make up a body plan of your own design. Your creature may swim, crawl, walk, jump, fly, or roll. You can choose to create just a single creature, or you can make multiple virtual animals. Your simulated world can be either 2D or 3D. The main goal is to demonstrate creature locomotion through mass/spring simulation.

You have considerable freedom in this project as to the type of creature you simulate. There are, however, a few requirements for this project in order to make sure you challenge yourself sufficiently. Here are the requirements of your simulator:

Create at least two different creatures, each with at least 10 springs in its body.
Vary the length of your creatures' springs to cause them to locomote.
Draw the creatures as they are moving.
Beyond the above requirements, you are free to embellish the simulation in any way that you see fit. You can work to draw your creatures in a pleasing manner. You can add various GUI elements, such as buttons and sliders to help control your creature. You can automatically cause the camera to follow your creature.

Suggested Approach
Whether or not you ultimately plan to create a 2D or a 3D simulation, I recommend that you begin your project in 2D, since this is easier to debug.


Begin creating a simulator by defining a class of point masses. These points should have mass, current position, and velocity. You may also find it useful to have a force or acceleration associated with each point. This is quite similar to the flocking assignment, and you may even wish to borrow code from this earlier assignment. At first, you can create a collection of points at random positions and with random velocities. Store them in a list. Then, include an update step that moves each point according to their velocity, and draw their positions after each simulation step. Next, add a simple force, namely viscous damping. Including damping should cause your points to slow down and eventually come to rest. You may then wish to add gravity. Depending on your ultimate goal, you may also wish to confine the points to a fixed region of the screen, or at least keep them from passing through the floor. 

Once you have point masses implemented, you should add springs. The easiest way to define a spring class is to have each spring have a reference to a pair of point masses. Each spring should also have associated with it a rest length and a spring constant. During the simulation loop, add a step that calculates the forces on the pair of points that a given spring uses. This will be based on the deviation of the distance between the points from the rest length. Add these forces to the per-point accumulated force. 

When testing your springs, it is best to work with just two point masses and a single spring connecting them. It is also useful to be able to take a single step in the simulation, instead of causing the simulation to run continuously. Start your point masses at a distance away from each other that is different than their rest length, say by a factor of 20%. When you simulate the spring motion, be sure to turn on some form of damping, such as viscous damping or spring damping. You will probably have to tune the damping and spring constants until you find parameter settings that cause a spring to oscillate but then finally come to rest. Your first few attempts may well have the points flying off the screen. 

Once you have one spring that oscillates and then comes to rest, it is time to put together a small collection of springs. Create a triangle that is formed by three springs that connect three point masses. See if you can drop the triangle onto a virtual ground. If the spring forces are too weak, the triangle will collapse. Modify the spring constants and damping coefficients until the triangle is strong enough to hold up under its own weight. 

Once you can create a fairly rigid triangle, it is time to add virtual muscles. Allow some (or all) of your springs to oscillate over time. You will probably want to give each spring at least three new parameters: frequency, phase, and amplitude. These are attributes of a sine wave that defines how the rest length of the spring varies over time. At each time-step, each spring should adjust its rest length based on the sinusoid. You can test this by making just one of the triangle's springs oscillate. 

With the ability to create oscillating springs, you should be able to build virtual creatures that move. You may have to add additional effects such a simple fluid force on the springs, or a friction force due to the ground that influences a point mass.

Turning In Your Assignment
You need to turn in several items for this project:

One or more movie files that show the different creatures and their motions
A brief write-up that describes your simulator and the creatures
Your source code
The write-up can be either a PDF or an MS Word file.  The movie files can be made either by using a video capture program while you run your simulator, or you can save a bunch of still images to the disk and then use a program like ffmpeg to create a movie file.  The movies, the written description and your source code should be zipped up and turned in on Canvas.

 

Voxel Space Plant Grown (Option 2)
Objective
The object of this project is to familiarize yourself with a virtual plant model in which the growth is influenced by the plant's environment. You can create any kind of virtual plant that you wish, so long as it demonstrates environmental growth factors such as preference for lighted areas, spiraling around pillars, or phototaxis.

Voxel-Space Techniques
This project is based on Ned Greene's paper, which you should read prior to working on this assignment. You can find the paper herePreview the document.

This project is more open-ended than prior course projects. You can make your own choice about what kind of plant that you wish to simulate. You can select vines, bushes, or trees. The leaves of your plant may be any geometric form that you deem appropriate. You can model your plant based on real-world plants, or you can make up your own alien plant life form.

You have considerable freedom in this project as to the type of plant that you simulate. There are, however, a few requirements for this project in order to make sure you challenge yourself sufficiently. Here are the requirements of your plant growth simulator:

Create plants that demonstrate a branching structure. Grass and palm trees are examples of non-branching plants, and should be avoided.
Demonstrate a plant growth pattern that is affected by the environment. This can be plants that prefer shade or sunlight, plants that grow towards light (phototaxis), or plants that spiral around a pillar.
Include objects in your virtual environment that are distinct from your growing plant. Examples might be walls, pillars, or tree trunks of other plants. Your plants should avoid growing into these other objects.
The plant and its environment must be in 3D.
Beyond the above requirements, you are free to embellish the simulation in any way that you see fit. You can add various GUI elements to your code, such as buttons and sliders to help control the plant growth. You can vary the diameter of the branches based on their age. You can add leaves or flowers to your plant.  Yes, leaves are optional. If you like, you can create multiple species of plants, including plants that interact with each other. You may wish to animate the plant growth process, similar to a time-lapse video.

Suggested Approach
There are two main aspects to your plant simulator: creating a branching structure, and influencing the direction of growth based on the plant sensing its environment. You should begin by creating a method to grow branching structures. I recommend that you use a method similar to Ned Greene's approach, where you add segments to a growing tip. Based on a random number, you should occasionally allow the growing tip to split, creating two segments that will form two branches. You should experiment with branching probabilities and branching angles until you get results that you like. You may wish to keep some history of the last branching event along a growing branch, and use this to affect subsequent branching events. 

The direction of the newly added segments can at first be random. Eventually, however, you will need to bias this direction according to what the plant senses in its environment. You may also decide to terminate the growth of a tip under some circumstances, such as too little light. 

The Voxel-Space Automata paper makes use of 3D grids that assist in a plant sensing its environment. One of these grids is used to speed up ray tracing so that the plant can sense the sky and/or the sun. This kind of grid simply specifies occupancy (filled or empty cells). The other grid is for sensing proximity to environmental objects such as a pillar. This grid contains per-cell distances to the given object. You may want to pick one or the other style of grid to use, depending on which sensing you wish your plants to demonstrate. It is also possible to perform ray tracing and distance calculations without a pre-calculated grid. It is up to you whether you want to use a grid-based or a gridless approach. 

If you do decide to use a grid, you will need to be able to place objects in the grid. I strongly recommend that you limit yourself to voxelizing simple objects (such as line segments and boxes) into the grid. 

If you plan to use use occupancy grids, use axis-aligned blocks as the objects in your environment. Each box can be specified by six numbers: three to specify the minimum-value coordinates in x, y, z, and three more to specify the maximum-value coordinates of the box. Starting with a zeroed-out occupancy grid, a new box can be added by looping through the x, y, and z ranges for the box, and marking the appropriate grid cells as filled. 

The purpose of the occupancy grid is to assist in fast ray tracing towards sources of light. Moving from one grid cell to the next is usually referred to as DDA, and you can read about this method herePreview the document.  This approach is very similar to the way in which a description of a line segment is rasterized into pixels. Once you have fast ray tracing implemented, you should cast multiple rays towards the sky or the sun's path from each growing tip to determine the direction of growth and/or whether to terminate the tip growth. 

If you are implementing proximity grids, I suggest that you use cylinders as your environmental elements. Each cylinder is defined by a location on the ground plane (call these the x,y positions) and a radius. Loop through all of the grid cells, and determine the distance along the x,y plane from the current grid cell to the cylinder's x,y position. You can entirely ignore the vertical (z) direction in this distance calculation. Place the distance in the proximity grid. This creates a cylinder that is as tall as the grid. 

Once you have the ability to sense distances to other objects such as pillars, you should use these distances to affect the way your vines and/or other plants grow. Ned Greene used distances to keep a growing vine adjacent to a pillar. He also incorporated a twisting tendency so that the vine would spiral around the pillar. 

Once you have the ability to affect the plant growth based on environmental factors, experiment with different parameters and objects in the environment. Create a growth model and an environment that demonstrates the effects that you seek to model.

Turning In Your Assignment
You need to turn in several items for this project:

Three or more image files that show off your plants
A brief write-up that describes your plant growth simulator
Your source code
The write-up can be either a PDF or an MS Word file.  The image files should demonstrate how your plants are affected by the environment.  They should also show that your plants do not grow into other objects in the scene.  The images, the written description and your source code should be zipped up and turned in on Canvas.