import 'dart:io';

//see https://en.wikipedia.org/wiki/ANSI_escape_code#Colors for details.
const String clear = '\x1b[1;1H\x1b[0J';
const String reset = '\x1b[0m';

void cls()     => stdout.write( clear );  //clear the screen
void rst()     => stdout.write( reset );  //reset tty settings
void boldOn()  => stdout.write( '\x1b[1m' );
void boldOff() => stdout.write( '\x1b[22m' );

//square types from VikingModel.dart:
//  enum Square { ordinary, cornerExit, throne, edgeWinner, unavailable }
const String cornerExitBg  = '\x1b[30;42m';
const String ordinaryBg    = '\x1b[30;47m';
const String throneBg      = '\x1b[30;104m';
const String edgeWinnerBg  = '\x1b[30;102m';
const String unavailableBg = '\x1b[30;41m';
const String whiteBg       = '\x1b[30;107m';

//example usage:
//  final String greenBg = '\x1b[30;42m';
//  print( '${greenBg}hello${whiteBg}' );
