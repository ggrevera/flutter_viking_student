# flutter_viking_student

A Dart (and eventually Dart+Flutter) project to implement the viking chess game 
(actually a family of games, see below).

[//]: # (Comment: first is for dartdoc html; second is for github)

<img alt="(viking game family tree)" src="../../games.png" width="100%" />

<img alt="(viking game family tree)" src="./games.png"     width="100%" />

## Getting started

You start working at your first job at GH&trade; (Generally Hectic&trade;) on a family of board games based on viking chess.
Your first assignment is to work on the Sea Battle game, specifically. The lead architect
on the project has already created a framework for the logic behind the game 
for you to use. She has also created a way for you to exercise your code from
the good old command line while she continues to work on the GUI (based on 
Flutter).

---
### assignment #1: set up Sea Battle

- Complete the SeaBattle (see SeaBattle.dart in lib) __ctors__ (viz., SeaBattle9x9, SeaBattle11x11, 
  SeaBattle13x13, and SeaBattle15x15).
  Use these rules (see sea_battle_rules.pdf) as a reference.

- Complete toString in VikingModel (see VikingModel.dart in lib). It should return (not print) a string that 
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
Or even more better (sic), (by embedding controls sequences provided in
lib/terminal.dart) in the string):

[//]: # (Comment: first is for dartdoc html; second is for github)

<img alt="" src="../../example-tostring-output.png" width="100%" />

<img alt="" src="./example-tostring-output.png"     width="100%" />

   

The "colorized" example directly above is challenging. It is NOT required. It is for extra 
credit (and my undying respect and admiration) only.

---
### assignment #2: the power of inheritance!
1. Other individuals at GH&trade; have been hard at work on other parts of the project.
   Before you can incorporate their changes (on the remote repo), you must commit (save) your
   changes to your local repo. Run Android Studio, open your project (if it's not
   already open), and then select _Commit_ from the Git menu.
   Enter 'finished assignment #1' in the _Commit Message_ area, and then press _Commit_.
   If prompted for your email, enter it. Press the _Commit_ button if asked about warnings.
1. To incorporate the changes on the remote repo with your code, you need to first run Android Studio,
   open your project, and then select _Pull..._ from the Git menu.
   This will update your code with their changes.
   Make sure that you can run your code without any errors before proceeding.
   (If you have errors after the pull, please contact me.)
1. In VikingModel, complete:
    - isInBounds,
    - getPiece  (should use isInBounds),
    - getSquare (should use isInBounds), and
    - getPlayer (should use isInBounds).
1. Take a look at the definition of the enum Square (in VikingModel.dart).
   Ensure that your toString includes something reasonable for all of these values (some
   are supported by the the games below).
1. In Historical, complete Historical ctors (viz., Historical7x7, ..., Historical15x15).
   (This part should be relatively easy (if you did a good job on assignment #1).
   There is a great deal of commonality between Sea Battle setups and Historical.)
1. In ArdRi7x7, complete the ctor. This part is trivial. Simply copy the set up code
   in Historical7x7 to ArdRi7x7. (The difference between these games is in the presence
   or absence of a throne and/or corner exits. This is already done for you.)
1. In Brandubh7x7, complete the ctor. This part is trivial. Simply copy the set up code
   in Historical7x7 to Brandubh7x7. (The difference between these games is in the presence
   or absence of a throne and/or corner exits. This is already done for you.)

At this point, take a look at how much of the family tree is filled in.
Pat yourself on the back! Don't worry about the remaining games.
We are going to concentrate on the game logic in the future.

[//]: # (Comment: first is for dartdoc html; second is for github)

<img alt="(updated viking game family tree)" src="../../games2.png" width="100%" />

<img alt="(updated viking game family tree)" src="./games2.png"     width="100%" />

---
### assignment #3: is a move acceptable or not?
Before we can actually perform a move, we must ensure that the move is acceptable.
Begin working on isMoveOk in VikingModel. **This function does not perform the move 
(i.e., it does not modify any data).** 
it simply returns true or false to indicate whether or not it is acceptable.
Here are situations that you should handle:
1. As (what will become) usual, commit your changes to your local repo as follows.
   Run Android Studio, open your project (if it's not
   already open), and then select Commit from the Git menu.
   Enter 'finished assignment #2' in the Commit Message area, and then press Commit.
   If prompted for your email, enter it. Press the Commit button if asked about warnings.
   To incorporate any changes on the remote repo with your code, you need to first run Android Studio,
   open your project, and then select Pull... from the Git menu.
   This will update your code with any changes.
   Make sure that you can run your code without any errors before proceeding.
1. Out-of-bounds moves are not ok.
1. One may only move a piece of the type that corresponds to the current turn.
1. One cannot move onto (on top of) an existing piece.
1. One may only move horizontally or vertically (never diagonally, etc.).
   (Note: The next assignment will have you modify this to disallow moves through
   intervening pieces. This situation may be ignored for this assignment.)

Of course you should also include more mundane "sanity checks" of your own as well.
The next assignment will add additional rules.
Don't forget to comment your code (or else).

---
### assignment #4: modify isMoveOk (in VikingModel) to handle the following:
1. As usual, commit your changes to your local repo as follows.
   Run Android Studio, open your project (if it's not
   already open), and then select Commit from the Git menu.
   Enter 'finished assignment #3' in the Commit Message area, and then press Commit.
   If prompted for your email, enter it. Press the Commit button if asked about warnings.
   To incorporate any changes on the remote repo with your code, you need to first run Android Studio,
   open your project, and then select Pull... from the Git menu.
   This will update your code with any changes.
   Make sure that you can run your code without any errors before proceeding.
1. It is _not_ ok to allow moves after the game is over.
1. One cannot move through/jump over piece(s).
1. Only the king may occupy the throne (in games that have a throne). 
   (But other pieces are free to move through it when unoccupied.)
1. Only the king may occupy a corner exit (in games that have corner exits).

---
### assignment #5: coming soon!

