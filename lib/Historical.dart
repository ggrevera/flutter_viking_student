import 'package:flutter_viking_student/VikingModel.dart';

//----------------------------------------------------------------------------
/// use these rules: http://aagenielsen.dk/TaflRulesEnglish.pdf
/// (also cached locally as file://TaflRulesEnglish.pdf).
abstract class Historical extends WeakKing {

  //note: Ard Ri and Brandubh also subclass historical but have different
  // values for hasThrone and hasCornerExits.
  Historical ( int rows, int cols, bool hasThrone, bool hasCornerExits )
      : super(rows, cols, hasThrone, hasCornerExits);

}

//----------------------------------------------------------------------------
/// Historical on a 7x7 board.
/// use these rules: http://aagenielsen.dk/TaflRulesEnglish.pdf
/// (also cached locally as file://TaflRulesEnglish.pdf).
class Historical7x7 extends Historical {

  /// todo students assn 2
  /// note: exactly same setup as ArdRi7x7, Brandubh7x7, and Historical7x7.
  /// (throne and corner exits are differences.)
  Historical7x7 ( ) : super(7, 7, true, false) {  //throne = yes; corner exits = no

  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  Historical7x7 clone ( ) {
    Historical7x7 other = Historical7x7();
    copyValues( other );
    return other;
  }

}

//----------------------------------------------------------------------------
/// Historical on a 9x9 board
/// use these rules: http://aagenielsen.dk/TaflRulesEnglish.pdf
/// (also cached locally as file://TaflRulesEnglish.pdf).
class Historical9x9 extends Historical {

  /// todo students assn 2
  Historical9x9 ( ) : super(9, 9, true, false) {  //throne = yes; corner exits = no

  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  Historical9x9 clone ( ) {
    Historical9x9 other = Historical9x9();
    copyValues( other );
    return other;
  }

}

//----------------------------------------------------------------------------
/// Historical on a 11x11 board
/// use these rules: http://aagenielsen.dk/TaflRulesEnglish.pdf
/// (also cached locally as file://TaflRulesEnglish.pdf).
class Historical11x11 extends Historical {

  /// todo students assn 2
  Historical11x11 ( ) : super(11, 11, true, false) {  //throne = yes; corner exits = no

  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  Historical11x11 clone ( ) {
    Historical11x11 other = Historical11x11();
    copyValues( other );
    return other;
  }

}

//----------------------------------------------------------------------------
/// Historical on a 13x13 board
/// use these rules: http://aagenielsen.dk/TaflRulesEnglish.pdf
/// (also cached locally as file://TaflRulesEnglish.pdf).
class Historical13x13 extends Historical {

  /// todo students assn 2
  Historical13x13 ( ) : super(13, 13, true, false) {  //throne = yes; corner exits = no

  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  Historical13x13 clone ( ) {
    Historical13x13 other = Historical13x13();
    copyValues( other );
    return other;
  }

}

//----------------------------------------------------------------------------
/// Historical on a 15x15 board
/// use these rules: http://aagenielsen.dk/TaflRulesEnglish.pdf
/// (also cached locally as file://TaflRulesEnglish.pdf).
class Historical15x15 extends Historical {

  /// todo students assn 2
  Historical15x15 ( ) : super(15, 15, true, false) {  //throne = yes; corner exits = no

  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  Historical15x15 clone ( ) {
    Historical15x15 other = Historical15x15();
    copyValues( other );
    return other;
  }

}
