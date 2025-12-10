% Eduardo Juarez Exj220003
% validate_maze validates the maze in terms of dimensions, content, and also checks for starts
validate_maze(Maze) :-
    Maze \= [],                                     % not empty
    validate_length(Maze),                          % checks the size of the rows to make sure it is not disproportional
    count_symbol(Maze, s, SCount),                  % count the number of 's' (starts)
    SCount =:= 1,                                   % has one start
    count_symbol(Maze, e, ECount),                  % count the number of 'e' (exits)
    ECount >= 1.                                    % has at least one exit

% helper function to validate dimensions of the maze
% uses the built in function length to retrieve the length of the rows
% length() was taken from https://www.swi-prolog.org/pldoc/doc_for?object=length/2
validate_length([_]).                               % check for cases with one row which can still be valid
validate_length([FirstRow, SecondRow | Rest]) :-
    length(FirstRow, L),                            % get the length of the first row
    length(SecondRow, L),                           % then compare to the second row recursively
    validate_length([SecondRow | Rest]).            

% count_symbol is a helper to ensure the right amount of symbols is present in the maze
% https://stackoverflow.com/questions/9059572/flatten-a-list-in-prolog flatten use extracted from the examples in here
count_symbol(Maze, Symbol, Count) :-
    flatten(Maze, FlatMaze),                        % flattensmaze into a list to count the symbols linearly
    findall(Symbol, member(Symbol, FlatMaze), SymbolList), % find all occurrences of the symbol 
    length(SymbolList, Count).                      % count the total occurrences

% find_exit is the main function that solves the maze, it accepts an unbound second argument
% it returns a list with the correct path to solve the maze
find_exit(Maze, Actions) :-
    validate_maze(Maze),                            % check the maze is valid
    find_start(Maze, Row, Col),                     % find the start position
    solve_maze(Maze, Row, Col, [(Row, Col)], [], Actions). % solve the valid maze starting from the right position

% find_start finds the location of the starting cell 's'
% The function uses the built in nth0 to retreive the location in the list at a given index
% nth0 documentation found at https://www.swi-prolog.org/pldoc/man?predicate=nth0/3.
find_start(Maze, Row, Col) :-
    nth0(Row, Maze, RowList),                       % get the rows list from the rows in the maze
    nth0(Col, RowList, s),                          % compare 's' to the value in the cell from the row x col location
    !.                                              % stop upon finding it

% cell_value verifies if a given value corresponds to the value at the row x col location
% The purpose of this function is to look up/ locate the value of a cell to determine the outcome of a move
% The function uses the built in nth0 to retrieve the location in the list at a given index
cell_value(Maze, Row, Col, Value) :-
    nth0(Row, Maze, RowList),                        % get the rows list from the rows in the maze
    nth0(Col, RowList, Value).                       % compare 'Value' to the value in the cell from the row x col location

% move is the overloaded predicate that computes the new cell position given a direction
% move(CurrRow, CurrCol, action, NextRow, NextCol) is the syntax of the predicate
move(CurrRow, CurrCol, up, NextRow, CurrCol) :-     % move up 
    NextRow is CurrRow - 1.
move(CurrRow, CurrCol, down, NextRow, CurrCol) :-   % move down
    NextRow is CurrRow + 1.
move(CurrRow, CurrCol, right, CurrRow, NextCol) :-  % move right
    NextCol is CurrCol + 1.
move(CurrRow, CurrCol, left, CurrRow, NextCol) :-   % move left
    NextCol is CurrCol - 1.

% validate_move is a predicate that validates that a move does not overstep any forbidden movement boundaries
validate_move(Maze, Row, Col) :-
    Row >= 0,                                       % cell row position is >= 0
    Col >= 0,                                       % cell col position is >= 0
    length(Maze, NumRows),                          % retrieve row count
    Row < NumRows,                                  % cell row position is < row limit
    nth0(Row, Maze, RowList),                       % retrieve row at index
    length(RowList, NumCols),                       % retrive col count
    Col < NumCols,                                  % ensure cell col position is < col limit
    cell_value(Maze, Row, Col, Cell),               % get the value of the cell at row x col
    Cell \= w.                                      % ensure the value is not a 'w' (wall)

% just another validation/checker function to check for the exit of the maze
is_exit(Maze, Row, Col) :-                          
    cell_value(Maze, Row, Col, e).                  % check whether cell is 'e' (exit)

% next_move takes an action to move accross the map 
next_move(Maze, Row, Col, Action, NextRow, NextCol) :-
    move(Row, Col, Action, NRow, NCol),             % makes a move
    validate_move(Maze, NRow, NCol),                % validates the move
    NextRow = NRow,                                 % if valid, it updates the coordinates
    NextCol = NCol.

% valid_moves keeps track of the valid steps into the maze so that we can backtrack if needed
% it is a tuple list containing the action/direction and the coordinates of the cell
valid_moves(Maze, Row, Col, PathList) :-
    findall((Action, NextRow, NextCol),             % find all valid moves and add them as candidates of the PathList
    next_move(Maze, Row, Col, Action, NextRow, NextCol),
    PathList).

% solve_maze is the implementation of my DFS 
% base case:
% I used reverse() from https://www.swi-prolog.org/pldoc/man?predicate=reverse/2.
solve_maze(Maze, Row, Col, Visited, Moves, FinalMoves) :-
    is_exit(Maze, Row, Col),                        % base case to return when exit is found
    reverse(Moves, FinalMoves).                     % reverse the list to return moves in order

% recursive helper for DFS
% I used member() from https://www.swi-prolog.org/pldoc/man?predicate=member/2.
solve_maze(Maze, Row, Col, Visited, Moves, FinalMoves) :-
    valid_moves(Maze, Row, Col, PathList),          % find the valid moves
    member((Action, NextRow, NextCol), PathList),   % choose a valid move (in order) at the current cell
    \+ member((NextRow, NextCol), Visited),         % check if the cell has been visited
    NewVisited = [(NextRow, NextCol)|Visited],      % append the cell to the visited list
    NewMoves = [Action|Moves],                      % append the action to the current m,ove path
    solve_maze(Maze, NextRow, NextCol, NewVisited, NewMoves, FinalMoves).