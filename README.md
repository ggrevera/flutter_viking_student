# flutter_viking_student

A Dart (and eventually Dart+Flutter) project to implement the viking chess game (actually a family of games).

## Getting Started

This project is a starting point for a Dart implementation of viking chess.

## assigment #1

- Complete the SeaBattle ctors (viz., SeaBattle9x9, SeaBattle11x11, SeaBattle13x13, and SeaBattle15x15).
- Complete toString in VikingModel. It should return (not print) a string that looks something like the following
when printed (or saved to a text file, or transmitted around the world and viewed with a text editor):

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

Or even better:

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

Or even more [sic] better: ![Alt text](https://assets.digitalocean.com/articles/alligator/boo.svg "a title")

- [Lab: Write your first Flutter app](https://raw.githubusercontent.com/ggrevera/flutter_viking_student/master/example-tostring-output.png)

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
