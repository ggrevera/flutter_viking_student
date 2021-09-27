///this is simply the old school, command line version for playing a game.
/// the user is simply prompted for a move, and then the move is attempted.
/// the result after the move is then printed.
import 'dart:io';

import 'package:flutter_viking_student/terminal.dart' as tty;
import 'package:flutter_viking_student/VikingModel.dart';
import 'package:flutter_viking_student/SeaBattle.dart';

const bool verbose = false;

//---------------------------------------------------------------------------
void main ( List<String> args ) {
  print( '\nWelcome!' );
  VikingModel m = SeaBattle9x9();  //pick a particular game to play
  //VikingModel m = Historical7x7();  //pick a particular game to play
  while (!m.gameOver) {
    //output current board configuration
    tty.rst();
    tty.cls();
    print( '' );
    stdout.write( m );
    //print( '$m' );
    tty.rst();
    print( "It's ${m.turn}'s turn." );

    //prompt for next move
    int fr, fc;  //from row and col
    int tr, tc;  //to row and col
    try {
      //read from row and col
      tty.boldOn();
      stdout.write( 'enter move from r c: ' );  //instead of print; not follow by newline
      tty.boldOff();
      String ln = stdin.readLineSync();
      if (ln == null)    continue;
      ln = ln.toLowerCase();
      if (ln == 'quit' || ln == 'exit' || ln == 'bye' || ln == 'q' || ln == 'x') {
        print( 'Bye.' );
        return;
      }
      if (ln == 'u' || ln == 'undo') {
        //todo students handle undo

        continue;
      }
      List<String> pieces = ln.split( RegExp('\\s+') );  //whitespace

      fr = int.parse( pieces[0] );
      fc = int.parse( pieces[1] );

      //read to row and col
      stdout.write( 'move to r c: ' );
      ln = stdin.readLineSync();
      if (ln == null)    continue;
      pieces = ln.split( RegExp('\\s+') );  //whitespace

      tr = int.parse( pieces[0] );
      tc = int.parse( pieces[1] );
    } catch (e) {
      print( 'Please specify two ints for each r c followed by <Enter>. For example, ' );
      print( '1 2' );
      print( '10 9' );
      print( 'Please try again.' );
      continue;
    }

    //perform move if possible
    bool ok = m.performMove(fr, fc, tr, tc);
    //see if the move is valid. if so, do it.
    if (!ok) {
      print( '${m.msg} Invalid move. Please try again.' );
    }
  }

  //output game-over info
  print( 'Game over.' );
  if (m.attackerWon) {
    print( 'Attacker won!' );
  } else if (m.defenderWon) {
    print( 'Defender won!' );
  } else {
    print( 'Draw!' );
  }

}
//---------------------------------------------------------------------------
