//----------------------------------------------------------------------------
//start with these rules: http://aagenielsen.dk/TaflRulesEnglish.pdf
//----------------------------------------------------------------------------

//this package requires null safety support: import 'package:json_annotation/json_annotation.dart';

//don't import flutter packages because code that does not use flutter (e.g., cli_main.dart) will not compile/run.
//import 'package:flutter/material.dart';
//import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:flutter_viking_student/terminal.dart' as tty;  //for pretty output format
import 'package:flutter_viking_student/Move.dart' show Move;

enum Player { attacker, defender, neither }

enum Piece  { none,             //nada
              attack,           //AKA (Also Known As) sea battle attack longship
              defend,           //AKA sea battle defend longship
              defendKing,       //AKA sea battle defend cargo ship
              defendKnight,     //berserk only
              attackCommander,  //berserk only
              defendCommander,  //berserk only
              defendHirdman,    //unst alea evangelii only
              checked           //not a valid piece; used by circle check only; do not use
}

enum Square { ordinary, cornerExit, throne, edgeWinner, unavailable }

//----------------------------------------------------------------------------
/// abstract base class for all viking board games.
//requires null safety: @JsonSerializable()
abstract class VikingModel {

    ///default board size
    static const int defaultSize = 11;
    final int rows;
    final int cols;
    final bool hasThrone;
    final bool hasCornerExits;
    bool hasEdgeWinner () => !hasCornerExits;  //must be some way to win!

    //in newer versions of dart (for null safety), 'late' may be used below to indicate that i promise to init it (to something other than null).
    ///2d array of pieces on board; pieces may move
    List< List<Piece> > pieces;
    ///2d array of underlying board cells; once initialized, these don't change
    List< List<Square> > squares;
    ///indicate players that move first (not consistent across all games)
    Player turn = Player.attacker;
    bool gameOver    = false;
    bool attackerWon = false;
    bool defenderWon = false;
    ///list of moves from the start of the game
    List< Move >  moveList = [];

    ///for informational/warning/error messages (otherwise, null)
    String msg = '';

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    //constructor
    VikingModel ( [this.rows=defaultSize, this.cols=defaultSize, this.hasThrone=false, this.hasCornerExits=false] ) {
        //allocate a 2d array for the pieces (movable)
        pieces = List.generate(
            rows,
            (_) => List.generate(cols, (_) => Piece.none), growable: false);

        //allocate the underlying 2d array of board squares (fixed; not movable)
        squares = List.generate(
            rows,
            (_) => List.generate(cols, (_) => Square.ordinary), growable: false);

        ///todo: this should probably be done through inheritance
        if (hasThrone) {
            squares[rows~/2][cols~/2] = Square.throne;
        }
        if (hasCornerExits) {
            squares[0][0] = squares[0][cols-1] =
            squares[rows-1][0] = squares[rows-1][cols-1] = Square.cornerExit;
        }
        if (hasEdgeWinner()) {
            for (int c=0; c<cols; c++) {
                squares[0][c] = squares[rows-1][c] = Square.edgeWinner;
            }
            for (int r=0; r<rows; r++) {
                squares[r][0] = squares[r][cols-1] = Square.edgeWinner;
            }
        }
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 1
    @override
    String toString ( ) {
        String s = super.toString();
        s += '\n';

        return s;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 2
    /// returns true if (r,c) is within array bounds; false otherwise.
    bool isInBounds ( int r, int c ) {
        return true;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 2
    /// returns the [Piece] at (r,c) if it is within array bounds;
    /// [Piece.none] otherwise.
    Piece getPiece ( int r, int c ) {
        return Piece.none;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 2
    /// returns the [Square] at (r,c) if it is within array bounds;
    /// [Square.ordinary] otherwise.
    Square getSquare ( int r, int c ) {
        return Square.ordinary;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 2
    /// returns the [Player] at (r,c) if it is within array bounds;
    /// [Player.neither] otherwise.
    Player getPlayer ( int r, int c ) {
        return Player.neither;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 3
    ///note: set msg to '' if the move is ok; otherwise, set it to a string
    ///      that is an informational message.
    bool isMoveOk ( int fromR, int fromC, int toR, int toC ) {
        msg = '';

        return true;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 7
    ///uses isOkMove, but doesn't actually perform any move
    bool hasAtLeastOneMove ( ) {
        return true;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 8
    @protected
    int countAttackers ( ) {
        return 1;
    }

    ///todo students assn 8
    @protected
    int countDefenders ( ) {
        return 1;
    }

    ///todo students assn 8
    @protected
    int countKings ( ) {
        return 1;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 8
    @protected
    bool checkThreeRepeatedMoves ( ) {
        return false;
    }
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 8 extra credit only. tough.
    /// most subclasses allow for the attackers to win by circling/surrounding
    /// all of the defenders.
    /// see http://engr.case.edu/merat_francis/eecs490f07/Lectures/Lecture23.pdf
    /// and http://www.imageprocessingplace.com/downloads_V3/root_downloads/tutorials/contour_tracing_Abeer_George_Ghuneim/moore.html
    /// for algorithmic ideas.
    ///
    /// subclasses that do not allow this sort of win should simply override
    /// this and return false. (could possibly be accomplished by two mixins:
    /// one that does it and one that does not. but i don't think that would
    /// be as simple.)
    ///
    /// step 1: find a defender
    /// step 2: do a (4-connected) flood fill starting at that location
    /// step 3: as flood progresses, mark using 'checked'.
    ///         stop at out-uf-bounds, unavailable, or attackers.
    ///         count defenders.
    /// step 4: compare count of defenders in flooded region to count of all
    ///         defenders. if the same, all are surrounded.
    @protected
    bool checkCircle ( ) {
        return false;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///the building blocks may be provided in VikingModel but maybe this
    ///should be abstract and left to individual subclasses. nah!
    @protected
    bool setGameOverAndWinner ( ) {
        if (countKings() < 1) {
            gameOver = attackerWon = true;
            return true;
        }
        if (kingEscaped()) {
            gameOver = defenderWon = true;
            return true;
        }
        if (checkCircle()) {
            gameOver = attackerWon = true;
            return true;
        }
        if (countDefenders() < 1 && countAttackers() < 1) {  //draw?
            gameOver = true;
            return true;
        }
        if (countDefenders() < 1) {
            gameOver = attackerWon = true;
            return true;
        }
        if (countAttackers() < 1) {
            gameOver = defenderWon = true;
            return true;
        }
        if (checkThreeRepeatedMoves()) {
            if (turn == Player.attacker) {
                defenderWon = true;
            } else if (turn == Player.defender) {
                attackerWon = true;
            } else {
                assert( false );  //sould never get here
            }
            gameOver = true;
            return true;
        }

        return false;
    }

    ///todo students assn 8
    bool kingEscaped ( ) {
        return false;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    /// abstract
    @protected
    bool performCapture ( int mr, int mc );

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    /// uses isOkMove, performCapture, and setGameOverAndWinner
    bool performMove ( int fromR, int fromC, int toR, int toC ) {
        if (!isMoveOk(fromR, fromC, toR, toC))    return false;
        //perform the move
        pieces[toR][toC] = pieces[fromR][fromC];  //copy to dst
        pieces[fromR][fromC] = Piece.none;        //remove from src
        performCapture( toR, toC );  //if any

        //add move to list
        Move m = Move( fromR, fromC, toR, toC );
        moveList.add( m );

        setGameOverAndWinner();
        if (turn == Player.attacker) {
            turn = Player.defender;
        } else if (turn == Player.defender) {
            turn = Player.attacker;
        } else {
            assert( false ); //should never get here
        }

        if (!gameOver && !hasAtLeastOneMove()) {
            gameOver = true;
            if (turn == Player.attacker) {
                defenderWon = true;
            } else if (turn == Player.defender) {
                attackerWon = true;
            } else {
                assert( false );  //should never get here
            }
        }

        return true;  //move was performed successfully
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 5
    @override
    bool operator ==( Object other ) =>
        false;

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///abstract
    VikingModel clone ( );

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 5
    ///used by clone. 'other' should be a deep copy of 'this'.
    @protected
    void copyValues ( VikingModel other ) {
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 9
    @protected
    bool captureSandwich ( int mr, int mc, int ar, int ac, int pr, int pc ) {
        return false;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    ///todo students assn 9
    @protected
    bool isHostile ( int r, int c, Player beingCaptured ) {
        return false;
    }

    /// based on https://stackoverflow.com/questions/49753412/converting-object-to-an-encodable-object-failed
    Map< String, dynamic> toJson ( ) {
        //todo needs work
        print( 'VikingModel.toJson' );

        //encode pieces
        List< List<String> > p = [];
        for (int r=0; r<rows; r++) {
            List< String > row = [];
            for (int c=0; c<cols; c++) {
                row.add( pieces[r][c].toString() );
            }
            p.add( row );
        }

        //encode board squares
        List< List<String> > s = [];
        for (int r=0; r<rows; r++) {
            List< String > row = [];
            for (int c=0; c<cols; c++) {
                row.add( squares[r][c].toString() );
            }
            s.add( row );
        }

        //encode move list
        List< String > m = [];
        for (int i=0; i<moveList.length; i++) {
            m.add( '${moveList[i].fromRow},${moveList[i].fromCol},${moveList[i].toRow},${moveList[i].toCol},' );
        }

        return {
            'type':           runtimeType.toString(),
            'rows':           rows,
            'cols':           cols,
            'hasCornerExits': hasCornerExits,
            'hasThrone':      hasThrone,
            'pieces':         p,
            'squares':        s,
            'defenderWon':    defenderWon,
            'attackerWon':    attackerWon,
            'msg':            msg,
            'gameOver':       gameOver,
            'moveList':       m,
        };
    }

}

//============================================================================
/// from http://aagenielsen.dk/tafl_rules.php:
/// ```
///   rules
///     weak king     "The weak king is armed and captured from 2 sides."
///     strong king
///     unarmed sea battle cargo ship*
/// ```
///   *although unarmed sea battle cargo ship is placed at the same level as the
///    strong and weak kings (in the doc above), it may be more appropriate to
///    place it in the inheritance hierarchy under weak king.
///
///   see http://aagenielsen.dk/tafl_rules.php#weak.
abstract class WeakKing extends VikingModel {
    WeakKing ( int rows, int cols, bool hasThrone, bool hasCornerExits )
        : super(rows, cols, hasThrone, hasCornerExits);

    ///todo students assn 9
    @override
    @protected
    bool performCapture ( int mr, int mc ) {
        return false;
    }

}

//============================================================================
/// see http://aagenielsen.dk/tafl_rules.php#strong.
abstract class StrongKing extends VikingModel {
    StrongKing ( int rows, int cols, bool hasThrone, bool hasCornerExits )
        : super(rows, cols, hasThrone, hasCornerExits);

    ///todo students assn 9
    @protected
    @override
    bool captureSandwich ( int mr, int mc, int ar, int ac, int pr, int pc ) {
        return false;
    }

}
