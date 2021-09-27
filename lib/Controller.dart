import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:assets_audio_player/assets_audio_player.dart';  //https://protocoderspoint.com/assets-audio-player-flutter-example/
//import 'package:flutter_sound/flutter_sound.dart';
//import 'package:just_audio/just_audio.dart';
//import 'package:audioplayer/audioplayer.dart';

import 'package:flutter_viking_student/VikingModel.dart';
import 'package:flutter_viking_student/ArdRi7x7.dart';
import 'package:flutter_viking_student/Brandubh7x7.dart';
import 'package:flutter_viking_student/Historical.dart';
import 'package:flutter_viking_student/SeaBattle.dart';

import 'package:flutter_viking_student/Move.dart' show Click;
import 'package:flutter_viking_student/View.dart' as view;

//---------------------------------------------------------------------------
//callbacks
class Controller {

  ///todo students undo the most recent move
  static void doUndo ( view.MyHomePageState state ) {
    print( 'doUndo' );
    //state.setState(() {  // <-- caller is responsible for this

    ///refer to current game via state. for example:
    /// print( state.model );
    ///state.clicks = [];

    //});  // <-- ditto
  }

  ///start a new game of the specified type
  static void doChanged ( view.MyHomePageState state, String which ) {
    //todo: might want to check gameInProgress first. if in progress, one
    //      we might want to ask the user if they are sure.
    VikingModel m;
    switch (which) {
      case 'ArdRi7x7':
        m = ArdRi7x7();
        break;
      case 'Brandubh7x7':
        m = Brandubh7x7();
        break;
      case 'Historical7x7':
        m = Historical7x7();
        break;
      case 'Historical9x9':
        m = Historical9x9();
        break;
      case 'Historical11x11':
        m = Historical11x11();
        break;
      case 'Historical13x13':
        m = Historical13x13();
        break;
      case 'Historical15x15':
        m = Historical15x15();
        break;
      case 'SeaBattle9x9':
        m = SeaBattle9x9();
        break;
      case 'SeaBattle11x11':
        m = SeaBattle11x11();
        break;
      case 'SeaBattle13x13':
        m = SeaBattle13x13();
        break;
      case 'SeaBattle15x15':
        m = SeaBattle15x15();
        break;
      default:
        m = SeaBattle9x9();
        break;
    }
    //state.setState(() {  // <-- caller is responsible for this
    state.clicks = [];
    state.model = m;
    state.whichGame = m.runtimeType.toString();
    //});
  }

  ///handle click on the board.
  ///  caller is responsible for calling setState().
  static void doPieceClick ( BuildContext ctx, view.MyHomePageState state, int r, int c ) {
    print( 'doPieceClick: (r=$r,c=$c)' );
    Click clk = Click( r, c );

    //problems/dart analysis reports:
    //  info: The member 'setState' can only be used within instance members of subclasses of 'package:flutter/src/widgets/framework.dart'. (invalid_use_of_protected_member at [flutter_viking] lib\main.dart:104)
    //  but it won't work without it!
    //state.setState(() {  // <-- caller is responsible for this
    state.clicks.add( clk );
    print( state.clicks.toString() );
    if (state.clicks.length >= 2) {
      //wait for ui to update
      Timer( const Duration(milliseconds: 500), () {
        print( 'here' );
        //todo: attempt to make move here
        //SystemSound.play( SystemSoundType.alert );
        //audioPlayer.open( Audio('sounds/break.mp3') );

        //problems/dart analysis reports:
        //  info: The member 'setState' can only be used within instance members of subclasses of 'package:flutter/src/widgets/framework.dart'. (invalid_use_of_protected_member at [flutter_viking] lib\main.dart:119)
        //  but it won't work without it (maybe it occurs in a separate thread?)!
        // ignore: INVALID_USE_OF_PROTECTED_MEMBER
        state.setState(() {
          bool ok = state.model.performMove( state.clicks[0].r, state.clicks[0].c, state.clicks[1].r, state.clicks[1].c );
          print( state.model );
          if (!ok) {
            ScaffoldMessengerState scaffold = ScaffoldMessenger.of( ctx );
            scaffold.showSnackBar(
              SnackBar(
                content: Text( state.model.msg ),
                action:  SnackBarAction( label: 'Close', onPressed: scaffold.hideCurrentSnackBar ),
              )
            );
            print( state.model.msg );
          } else {
            if (state.model.gameOver) {
              String msg;
              if (state.model.defenderWon) {
                msg = 'defender won';
              } else if (state.model.attackerWon) {
                msg = 'attacker won';
              } else {
                msg = 'draw';
              }
              ScaffoldMessengerState scaffold = ScaffoldMessenger.of( ctx );
              scaffold.showSnackBar(
                  SnackBar(
                    content: Text( msg ),
                    action:  SnackBarAction( label: 'Close', onPressed: scaffold.hideCurrentSnackBar ),
                  )
              );
              print( msg );
            }
          }
          state.clicks = [];
        });
      });
    }
    //});
  }

}
