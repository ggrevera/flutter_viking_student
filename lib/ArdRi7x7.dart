import 'package:meta/meta.dart';
import 'package:flutter_viking_student/VikingModel.dart';
import 'package:flutter_viking_student/Historical.dart';

/// Ard Ri on a 7x7 board
/// use these rules: http://aagenielsen.dk/TaflRulesEnglish.pdf
/// (also cached locally as file://TaflRulesEnglish.pdf).
class ArdRi7x7 extends Historical {

    /// todo students assn 2
    /// note: exactly same setup as ArdRi7x7, Brandubh7x7, and Historical7x7.
    /// (throne and corner exits are differences.)
    ArdRi7x7 ( ) : super(7, 7, false, false) {  //throne = no; corner exits = no

    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    @override
    @protected
    bool performCapture ( int mr, int mc ) {
        //todo
        //assert( false );
        return false;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    @override
    ArdRi7x7 clone ( ) {
        ArdRi7x7 other = ArdRi7x7();
        copyValues( other );
        return other;
    }

}

