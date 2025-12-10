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
Now what I worked today:
I am working on solving the movement logic since the program must be able to walk a 2d matrix array. Or at least that is the understandment I have of the solution. This may change however it seems like the most logical option to approach the problem. The program may be able to backtrack, if needed, if it finds itself cornered and it should also be able to do it in the appropriate directions that follow the flow of the maze. 
I will re-read that part of the instructions to clarify it further but in the meantime I started working on the logic of following the movements given and reacting appropriately given the result of following the trajectory.

12/10/2025 12:01 am
Before it turned Dec 10th last night I managed to write:
a) The function to locate the logic of the program at the 's' (start) position of the maze. 
b) The function to retrieve the value inside of a cell location to determine the outcome of the movement.
I will continue and update as I develop the rest of the program.
I will work on the movement through the maze following a set of instructions.

12/10/2025 1:00 am 
I finished the "move" and "validate_move" predicate functions. I had to use atoms to do some sort of function overloading with move(). That way I can call the predicate with different parameters and it will move differently. Then validate_move makes sure that the move is within the bounds of the maze and that the move will not drive the program into a wall. 

12/10/2025 1:29 am 
I made some changes. First I added a is_exit predicate which used cell_value() to check whether the value of the cell was 'e' (exit). I then decided to get rid of this new function and the find_start function I made so that I could implement them inside the validate_move. 
The reasoning was that since in validate_move() I was checking if a wall was in the way I should also use that function to check whether it was a start position or an exit. 
I then realized that it was not aa good idea unless all moves were going to be instructed. However, for the program to be able to find the exit without using given instructions I could not use it like this since it would strugle with my backtracking. 
Since I am not working on that part right now I just decide to bring back find_start() and is_exit() I will then see if there is a work around otherwise I might just leave them as helper functions. 
(This update was written at 1:29 am but I forgot to commit)

12/10/2025 2:09 am
I started writting the main functions using the helpers I have built. find_exit() has now a body that calls to other helper functions. It validates the maze as well as it calls a solver function. I started writing the search function. i will be using a BFS algorithm so I need to make functions to simulate stacks that hold the valid path and the visited stack. I will continue later today.

12/10/2025 10:58 am 
I have finished my DFS, I used a DFS since I mentioned using stacks earlier but I could have also implemented BFS, this is just for consistency with the ideas I elaborated earlier. I have also finished the function that keeps track of the stack of valid moves across the maze. 

12/10/2025 11:21 am most of the code is done, I am now fixing errors. Also writting some helpers that may be useful to make the code cleaner.

12/10/2025 12:14 pm the code runs fine now. I reduced some of the helper functions because they were redundant. I am now commenting whatever is left to be explained in the code and also added some links pointing at the docummentation of the functions I used. 
