# Project2Prologue
Project 2 using Prologue 
Eduardo Juarez exj220003

11/28/2025 7:38 pm (worked on 11/27/2025 10:30 am) 
Re-read the instructions for the project. Read the .txt and .pl files to understand what I would need.
I planned some of the functions that I will need like a map validation function for the "bad" maps that should not work.

11/28/2025 8:07 pm
I have created the .pl file and started writing a carcass for my map validation function, as well as I created an empty "solve" function to encapsulate all the logic for moving around the maze. After I have finished the validation function I will work on the movement. I believeworking the validation first will give me a better idea of how to solve the movement logic. Once I have it I will move it inside the solve logic(). I also watched a couple of videos on prologue syntax.

11/29/2025 2:41 pm
Almost done with the validation of map funtion. The basic rules so far are as follows: 
Maze cannot be empty, cannt have rows with varying sizes, must have one start, must have one exit. 

12/6/2025 11:47 pm (worked on 12/4-5/2025)
Finished the map validation function. So far I have not added abny other check additional to wehat I had initiallky planned. 
I have also made predicates for the left, right, up, down movement along the grid. As well as I started a function that checks that the movement is valid, that means that the program does not run into a wall or cross a wall.

12/6/2025 11:50 pm
Now realted to what I worked today:
I am working on swolving the movement logic since the program must be able to walk a 2d matrix array. Or at least that is the understandment I have of the solution. This may change however it seems like the most logical option to approach the problem. The program may be able to backtrack, if needed, if it finds itself cornered and it should also be able to do it in the appropriate directions that follow the flow of the maze. 
I will re-read that part of the instructions to clarify it further but in the meantime I will work on the logic of following the movements given and reacting appropriately given the result of following the trajectory.
