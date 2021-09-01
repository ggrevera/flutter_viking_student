import 'package:meta/meta.dart';
import 'package:flutter_viking_student/VikingModel.dart';

//----------------------------------------------------------------------------
/// set ups & rules: http://aagenielsen.dk/seabattle_rules.php (or cached
/// locally as sea_battle_rules.pdf).
///
/// disregard the rules in http://tafl.cyningstan.com/data-download/966/sea-battle-tafl-leaflet.
/// they are incomplete (viz., missing these rules:
/// 6b. If the attackers surround the cargo ship and ALL remaining defenders,
/// then they win, as they have prevented the cargo ship from escaping.
/// 7. Perpetual repetitions are forbidden. Any perpetual repetition results in
/// a loss for white.
/// 8. If a player cannot move, he loses the game.
/// 9. If it is not possible to end the game, fx. because both sides have too
/// few pieces left, it is a draw.),
/// and differ with the above (viz., player to make first move).
///
/// Note: although 'unarmed sea battle cargo ship' appears at the same level as
/// the strong and weak kings (in http://aagenielsen.dk/tafl_rules.php), it is
/// more appropriate (imho) to place it in the inheritance hierarchy under
/// strong king.
///
/// Note: "The cargo ship may not take part in captures."
///       - http://aagenielsen.dk/seabattle_rules.php
///       "A pirate ship is not captured when sandwiched between the cargo
///       ship and a defender; the cargo ship may not be used to capture
///       pirates."
///       - http://tafl.cyningstan.com/data-download/966/sea-battle-tafl-leaflet
/// Note: all SeaBattles lack thrones and corner exits (even though pictures of
///       board layouts may indicate otherwise).
abstract class SeaBattle extends StrongKing {

  SeaBattle(int rows, int cols) : super(rows, cols, false, false);

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  ///todo students assn 9
  /// perform capture(s) (if any) after move.
  /// note: 0 to 3 pieces may be captured as a result of one move in any of
  /// four positions 'c' below:
  /// ```
  ///            North
  ///
  ///              p
  ///              a
  ///   West   p a m a p   East
  ///              a
  ///              p
  ///
  ///            South
  ///
  /// where m is the most recently moved piece at (mr,mc),
  ///       a is a piece that is being attacked and possibly captures, and
  ///       p is another possible piece.
  /// ```
  @override
  @protected
  bool performCapture(int mr, int mc) {
    return false;
  }
}

//----------------------------------------------------------------------------
/// set ups & rules: http://aagenielsen.dk/seabattle_rules.php (or cached
/// locally as sea_battle_rules.pdf).
class SeaBattle9x9 extends SeaBattle {

  ///todo students assn 1
  SeaBattle9x9 ( ) : super(9, 9) {
    //place attackers
    pieces[0][4] = Piece.attack;  // <-- i'll get you started.

    //place defenders

    //place defender king

  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  SeaBattle9x9 clone ( ) {
    SeaBattle9x9 other = SeaBattle9x9();
    copyValues( other );
    return other;
  }

}

//----------------------------------------------------------------------------
/// set ups & rules: http://aagenielsen.dk/seabattle_rules.php (or cached
/// locally as sea_battle_rules.pdf).
class SeaBattle11x11 extends SeaBattle {

  ///todo students assn 1
  SeaBattle11x11 ( ) : super(11, 11) {
  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  SeaBattle11x11 clone ( ) {
    SeaBattle11x11 other = SeaBattle11x11();
    copyValues( other );
    return other;
  }

}

//----------------------------------------------------------------------------
/// set ups & rules: http://aagenielsen.dk/seabattle_rules.php (or cached
/// locally as sea_battle_rules.pdf).
class SeaBattle13x13 extends SeaBattle {

  ///todo students assn 1
  SeaBattle13x13 ( ) : super(13, 13) {
  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  SeaBattle13x13 clone ( ) {
    SeaBattle13x13 other = SeaBattle13x13();
    copyValues( other );
    return other;
  }

}

//----------------------------------------------------------------------------
/// set ups & rules: http://aagenielsen.dk/seabattle_rules.php (or cached
/// locally as sea_battle_rules.pdf).
class SeaBattle15x15 extends SeaBattle {

  ///todo students assn 1
  SeaBattle15x15 ( ) : super(15, 15) {
  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  @override
  SeaBattle15x15 clone ( ) {
    SeaBattle15x15 other = SeaBattle15x15();
    copyValues( other );
    return other;
  }

}
