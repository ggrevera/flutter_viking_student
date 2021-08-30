
///Used to save a location (row,col).
class Click {
    final int r, c;  //row, col

    const Click ( this.r, this.c );

    @override
    String toString() {
        return '(r,c)=($r,$c)';
    }

    @override
    bool operator ==( Object other ) =>
        other is Click && r == other.r && c == other.c;

    ///todo: override hashCode (since == was overridden)
    @override
    int get hashCode => super.hashCode;
}

//----------------------------------------------------------------------------
///Move could actually be defined as a pair of Clicks, but that may be too
/// pedantic. So we'll define it as a pair of locations (fromRow,fromCol) and
/// (toRow,toCol).
class Move {
    final int fromRow, fromCol;
    final int toRow, toCol;

    const Move ( this.fromRow, this.fromCol, this.toRow, this.toCol );

    Move clone ( ) => Move( fromRow, fromCol, toRow, toCol );

    @override
    String toString ( ) {
        return '($fromRow,$fromCol,$toRow,$toCol)';
    }
}
