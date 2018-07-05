# PROLOG PROJECT

This project has been written for the exam of Artificial Intelligence Laboratory at the University of Turin.

It consists in an impementation of itearative deeepening, A* and IDA* in Prolog with two domains, a labyrinth and the 8 tile game.

## Installing

I recommend using [VSCode](https://code.visualstudio.com/download) with the extension [VSC-Prolog](https://marketplace.visualstudio.com/items?itemName=arthurwang.vsc-prolog) (of course you need to have SWIProlog installed and then follow the instructions on the plugin page to setup the runnable path). Then clone the repo and open the folder with VSCode.

## Running the program

In The top level folder there are 3 main files: `Astar.pl`, `IDAstar.pl` and `iterative_deepening.pl`. Each of them contains the code for their respective algorithm. Notice the import at the first line of each file: `:-['./{domain_folder}/loader.pl', 'utils.pl'].`: change the `{domain_folder}` with either `labyrinth` or `tile_game` to load their respective domain.

If you followed my recommendations, you can easily load and run the program just by opening one of them and pressing `ALT+X` and `L` (NB do not keep pressing `ALT` while pressing `L`).

## Description

### Domains

Each domain is self contained inside his respective folder. The `loader.pl` file inside them allows to load all the necessary predicates to explore the domain. All the domain specific predicates uses standardized names so that all the algorithms don't have to handle the specifications of each one.

File structure:

- `baseDati.pl` contains the knowledge base of the domain.
- `azioni.pl` contains the set of actions allowed in that domain with their transformations.
  - The predicate `applicabile(action, S)` checks if an `action` from a given state `S` is allowed. For each action there is an `applicable()` predicate.
  - `trasforma(action, S, S1)` is used as a function where `action` is the action t oapply in the given state `S`, `S1` in the new state where the action has led. Note that `trasforma()` does not check if `applicabile()`.
  - `maxDepth(D)` unifies `D` with the maxium depth of the domain.
  - `costoPasso(S, S1, C)` is used as function that given the input states `S` and `S1` calculate in `C` the cost of the transition from `S` to `S1`.
- `euristica.pl` contains the predicates used to calculate the heuristic of the specified domain.
  - `euristica(S, Sol, E)` is used to calculate the heuristic value `E` of state `S`; `Sol` is the solution of the relaxed problem, ofter ignored.

#### Labyrinth

<p align="center">
  <img src="https://raw.githubusercontent.com/lamba92/prolog-project/master/stuff/labyrinth.png"/>
</p>

This domain represent a labyrinth using the predicate `pos(X, Y)` where `X` and `Y` are the agent positioncoordinates. Simirarly the blue walls are represented by `occupata(pos(X, Y))`. `applicabile()` just checks if the action doesn't lead outside the labyrinth or inside a blue block, while `trasforma()` generate the new state as expected.

The heuristic used here is the manhattan distance that ignores the blue squares. The search is handled by `h_ric_prof_lim()` which implements an iterative deepening search.

#### 8 Tile Game

The game columns/rows number is expressed by `dim(n)` inside `baseDati.pl`, while the order of the single tiles is expressed by a list long n*n (this domain has `n = 3` which means a list leanght of 9). 

### Search Algorithms

- `iterative_deepening.pl` implements an iterative deepening search exploiting the innate Prolog's depth search inside the space of possibile variables unifications. The code is preatty self explanatory.

- `AStar.pl` implements the heuristic driven search algorithm A*

## Author

* **Cesare Iurlaro** - [CesareIurlaro](https://github.com/CesareIurlaro)
* **Giuseppe Gabbia**  - [beppe95](https://github.com/beppe95)
* **Lamberto Basti**  - [lamba92](https://github.com/lamba92)