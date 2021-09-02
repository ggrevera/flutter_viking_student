# flutter_viking_student

A Dart (and eventually Dart+Flutter) project to implement the viking chess game
(actually a family of games, see below).

![viking game family tree](./games.png)

## Getting started

You start working at your first job on a family of iboard games based on viking chess.
Your first assignment is to work on the Sea Battle game, specifically. The lead architect
on the project has already created a framework for the logic behind the game
for you to use. She has also created a way for you to exercise your code from
the good old command line while she continues to work on the GUI (based on
Flutter).

---
### assignment #1: set up Sea Battle

- Complete the [SeaBattle](./lib/SeaBattle.dart) __ctors__ (viz., SeaBattle9x9, SeaBattle11x11,
  SeaBattle13x13, and SeaBattle15x15).
  Use [these rules](./sea_battle_rules.pdf) as a reference.

- Complete toString in [VikingModel](./lib/VikingModel.dart). It should return (not print) a string that
  looks something like the following when printed (or saved to a text file, or
  transmitted around the world and viewed with a browser or a text editor).
  These are just examples below. Your string does not have to be exactly like
  them. Anything reasonable is acceptable. All fields and their corresponding
  values should be represented.
  Note that what we consider to be 'the board' actually consists of two components:
  (a) the actual pieces on the board, and
  (b) the underlying board itself.
  In the first figure below, the top represent
  the pieces on the board and the bottom represents the underlying board.
  In the second figure below, they appear side-by-side. The third figure below
  uses color to combine both into one.
```
  Instance of 'SeaBattle9x9', rows: 9, cols: 9, turn: Player.attacker
    012345678
  0 ....a....
  1 .a..a..a.
  2 ..a...a..
  3 ...DDD...
  4 aa.DKD.aa
  5 ...DDD...
  6 ..a...a..
  7 .a..a..a.
  8 ....a....

    012345678
  0 eeeeeeeee
  1 e.......e
  2 e.......e
  3 e.......e
  4 e.......e
  5 e.......e
  6 e.......e
  7 e.......e
  8 eeeeeeeee
```
Or even better (and for full credit):
```
  Instance of 'SeaBattle9x9', rows: 9, cols: 9, turn: Player.attacker
    012345678    012345678
  0 ....a....    eeeeeeeee
  1 .a..a..a.    e.......e
  2 ..a...a..    e.......e
  3 ...DDD...    e.......e
  4 aa.DKD.aa    e.......e
  5 ...DDD...    e.......e
  6 ..a...a..    e.......e
  7 .a..a..a.    e.......e
  8 ....a....    eeeeeeeee
```
Or even more better [sic], (by embedding controls sequences provided in
[terminal.dart](./lib/terminal.dart) in the string):

![example of more sophisticated toString result](./example-tostring-output.png)

The "colorized" example directly above is challenging. It is NOT required. It is for extra
credit (and my undying respect and admiration) only.

---
### assignment #2: coming soon

