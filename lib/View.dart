//import 'dart:ui';
//import 'dart:convert';
import 'dart:convert';
//import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

import 'package:flutter_viking_student/main.dart';
import 'package:flutter_viking_student/VikingModel.dart';
import 'package:flutter_viking_student/Controller.dart';
import 'package:flutter_viking_student/Move.dart' show Click;

import 'package:flutter_viking_student/ArdRi7x7.dart';
import 'package:flutter_viking_student/Brandubh7x7.dart';
import 'package:flutter_viking_student/Historical.dart';
import 'package:flutter_viking_student/SeaBattle.dart';

//no audio support for windows (or linux)!
// import 'package:audioplayer/audioplayer.dart';
//---------------------------------------------------------------------------
// *** this will become the "view" ***
//
//note: _ at the beginning of a class name limits scope to this .dart file
// (like static in C). https://api.flutter.dev/flutter/widgets/State-class.html
class MyHomePageState extends State<MyHomePage> {
  VikingModel model;
  //View v;
  List< Click > clicks;
  String whichGame;
  bool  showImages = true;

  Color selectedColor;
  double strokeWidth;
  bool repaint = true;

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.black;
    strokeWidth = 2;
    Controller.doChanged(this, null);
    print(model.runtimeType.toString());
    clicks = [];
  }

  void selectColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: const Text('fred'), actions: <Widget>[
          TextButton(
              child: const Text('close'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ]);
      },
      /*
        child: AlertDialog(
          title: const Text('Color Chooser'),

          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                this.setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),

          actions: <Widget>[
            TextButton(  //FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'))
          ],
        ),
          */
    );
  } // selectColor

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  Widget _getButton ( BuildContext ctx, int r, int c, double cellSize ) {
    //appearance will be different if currently selected
    Click clk = Click( r, c );
    bool isSelected = clicks.contains( clk );

    //specify text font color (for text buttons)
    ButtonStyle bs = ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>( Colors.black ),
    );
    //indicate cell background color
    Color backgroundColor;
    switch (model.squares[r][c]) {
      case Square.throne:
        backgroundColor = Colors.indigoAccent;
        break;
      case Square.unavailable:
        backgroundColor = Colors.red;
        break;
      case Square.cornerExit:
        backgroundColor = Colors.green[800];
        break;
      case Square.edgeWinner:
        backgroundColor = Colors.green[300];
        break;
      case Square.ordinary:
        backgroundColor = Colors.grey;
        break;
    }

    //specify piece name (string), image (file name), and size
    String name;
    String imageName;
    double imageSize = 0.40 * cellSize;  //reasonable default
    switch (model.pieces[r][c]) {
      case Piece.attack:
        name = 'a';
        imageName = (model is SeaBattle) ? 'images/ship50.png' : 'images/wp2.png';
        break;
      case Piece.attackCommander:
        name = 'c';
        break;

      case Piece.defend:
        name = 'D';
        imageName = (model is SeaBattle) ? 'images/ship30.png' : 'images/bp2.png';
        break;
      case Piece.defendKing:
        name = 'K';
        imageName = (model is SeaBattle) ? 'images/ship51.png' : 'images/bk.png';
        imageSize = 0.80 * cellSize;  //make king larger
        break;
      case Piece.defendCommander:
        name = 'C';
        break;
      case Piece.defendHirdman:
        name = 'H';
        break;

      case Piece.none:
        name = '';
        break;
      default:
        name = '?';
        break;
    }

    //specify box background color
    // and optionally outline in a contrasting color if selected
    BoxDecoration bd;
    double sz = 0.04*cellSize;
    if (sz < 3)    sz = 3;
    if (isSelected) {
      //selected (so outline in contrasting color)
      bd = BoxDecoration(
          color: backgroundColor,
          border: Border.all(width:sz, color: Colors.yellow)
      );
    } else {
      //not selected (don't outline)
      bd = BoxDecoration( color: backgroundColor, );
    }

    //create button (either outlined button with text or image button)
    Widget b;
    if (!showImages || imageName == null) {
      b = OutlinedButton(
        child: Center( child: Text(name, style: TextStyle(fontSize: cellSize / 2)) ),
        style: bs,
        key: Key('$r,$c'), //for testing
        onPressed: () => setState(() => Controller.doPieceClick(ctx, this, r, c)),
      );
    } else {
      /*
      ImageButton has bugs!
      b = ImageButton( //https://pub.dev/packages/imagebutton
        children: <Widget>[],
        width: 0.60 * cellSize,
        height: 0.60 * cellSize,
        pressedImage: Image.asset(imageName),
        unpressedImage: Image.asset(imageName),
        key: Key('$r,$c'), //for testing
        onTap: () => setState(() => Controller.doPieceClick(this, r, c)),
      );
      */
      b = SizedBox(  //was Container
          width:  imageSize,
          height: imageSize,
          child: FloatingActionButton(
            child: Image.asset(imageName),
            key: Key('$r,$c'), //for testing
            onPressed: () => setState(() => Controller.doPieceClick(ctx, this, r, c)),
            backgroundColor: backgroundColor,
          )
      );
    }

    Container cntr = Container(
      width:  cellSize,
      height: cellSize,
      child: Center(child: b),
      decoration: bd,
    );

    return cntr;
  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  static final List<Type> game = [
    ArdRi7x7,
    Brandubh7x7,
    Historical7x7,
    Historical9x9,
    Historical11x11,
    Historical13x13,
    Historical15x15,
    SeaBattle9x9,
    SeaBattle11x11,
    SeaBattle13x13,
    SeaBattle15x15,
  ];

  static final List<String> gameName = [for (Type t in game) '$t'];
  String lastJSON = '';

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  //laying out the ui dynamically is such a pain!
  @override
  Widget build ( BuildContext context ) {
    print('build: $whichGame');
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double tableSize = width < height ? 0.70 * width : 0.70 * height;
    final double cellSize = model.rows < model.cols
        ? tableSize / model.cols
        : tableSize / model.rows;
    //print( 'build: cellSize=$cellSize' );

    List<TableRow> rows = [];
    for (int r = 0; r < model.rows; r++) {
      List<Widget> row = [];
      for (int c = 0; c < model.cols; c++) {
        Widget b = _getButton(context, r, c, cellSize);
        row.add(b);
      } //end for c
      TableRow tr = TableRow(children: row);
      rows.add(tr);
    } //end for r

    Table t = Table(
        defaultColumnWidth: FixedColumnWidth(cellSize),
        border: TableBorder.symmetric( outside: const BorderSide(width: 4), inside: const BorderSide(width: 0.5) ),
        children: rows
    );
/*
    Container cntr = Container(
        alignment: Alignment.center,
        //width:  tableSize,
        //height: tableSize,
        child: t
    );
*/
    //Text txt = Text( 'json', key: Key('json') );

    return Scaffold(
        appBar: AppBar(
          title: const Text('flutter viking'),
          backgroundColor: const Color.fromRGBO(138+14, 35+4, 135+14, 1.0),
          actions: [
            DropdownButton<String>(
              key: const Key('game'),
              hint: const Text('game'),
              value: whichGame,
              onChanged: (String s) {
                print('old state: $whichGame, new state: $s');
                setState(() => Controller.doChanged(this, s) );
                print('current state: $whichGame');
              },
              items: [
                for (String s in gameName)
                  DropdownMenuItem(child: Text(s), value: s)
              ],
              dropdownColor: const Color.fromRGBO(138, 35, 135, 1.0),
              style: const TextStyle( color: Colors.grey ),
            ),
            IconButton(
                key: const Key('undo'), //for testing
                tooltip: 'undo',
                icon: Icon(
                  Icons.undo,
                  color: selectedColor,
                ),
                onPressed: () => print('undo pressed')),
            IconButton(
              key: const Key('restore'), //for testing
              tooltip: 'restore',
              icon: Icon(
                Icons.restore,
                color: selectedColor,
              ),
              onPressed: () =>
                  setState(() =>
                      Controller.doChanged(this, whichGame)),
            ),
            IconButton(
                key: const Key('hint'), //for testing
                tooltip: 'hint',
                icon: Icon(
                  Icons.help,
                  color: selectedColor,
                ),
                onPressed: () => print('help pressed')),
            IconButton(
              key: const Key('changesides'), //for testing
              tooltip: 'change sides',
              icon: Icon(
                Icons.alt_route,
                color: selectedColor,
              ),
              onPressed: () {
                print('change sides pressed');
                //AudioPlayer().play( 'ass' );
              },
            ),
            IconButton(
                key: const Key('save'), //for testing
                tooltip: 'save',
                icon: Icon(
                  Icons.file_upload,
                  color: selectedColor,
                ),
                onPressed: () {
                  JsonEncoder enc = const JsonEncoder.withIndent( '  ' );
                  String s = enc.convert( model );
                  print( 'save json data: $s' );
                  var f = File( './viking.json' );
                  f.writeAsString( s, flush: true );
                  setState(() {
                    lastJSON = s;
                  });
                }
            ),
            IconButton(
                key: const Key('load'), //for testing
                tooltip: 'load',
                icon: Icon(
                  Icons.file_download,
                  color: selectedColor,
                ),
                onPressed: () {
                  print( Platform.operatingSystemVersion );
                  File f = File( 'viking.json' );
                  String s = f.readAsStringSync();
                  print( 'from viking.json: $s' );
                  JsonDecoder dec = const JsonDecoder( );
                  var m = dec.convert( s );
                  //VikingModel.fromJson( m );
                  print( 'load json data: $m' );
                  //SeaBattle9x9.fromJson( m );
                }
            ),
            IconButton(
              key: const Key('settings'), //for testing
              tooltip: 'settings',
              icon: Icon(
                  Icons.settings,
                  color: selectedColor,
              ),
              onPressed: () => print( 'settings' )
            ),
          ],
        ),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(138, 35, 135, 1.0),
                      Color.fromRGBO(233, 64, 87, 1.0),
                      Color.fromRGBO(242, 113, 33, 1.0),
                    ])),
          ),
          Visibility(
            visible: true,
            child: Text( lastJSON, key: const Key('json') ),
          ),
          Center( child: t ),
          /*
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cntr,
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          key: const Key('settings'), //for testing
                          icon: Icon(
                            Icons.settings,
                            color: selectedColor,
                          ),
                          onPressed: () => print('settings pressed')),
                      DropdownButton<String>(
                        hint: const Text('game:'),
                        value: this.whichGame,
                        onChanged: (String s) {
                          print('old state: ${this.whichGame}, new state: $s');
                          setState(() {
                            Controller.doChanged(this, s);
                          });
                          print('current state: ${this.whichGame}');
                        },
                        items: [
                          for (String s in gameName)
                            DropdownMenuItem(child: Text(s), value: s)
                        ],
                      ),
                      IconButton(
                          key: const Key('undo'), //for testing
                          icon: Icon(
                            Icons.undo,
                            color: selectedColor,
                          ),
                          onPressed: () => print('undo pressed')),
                      IconButton(
                        key: const Key('restore'), //for testing
                        icon: Icon(
                          Icons.restore,
                          color: selectedColor,
                        ),
                        onPressed: () =>
                            setState(() =>
                                Controller.doChanged(this, this.whichGame)),
                      ),
                      IconButton(
                        key: const Key('changeSides'), //for testing
                        icon: Icon(
                          Icons.alt_route,
                          color: selectedColor,
                        ),
                        onPressed: () => print('change sides pressed'),
                      ),
                    ])
              ])
          */
        ]));
  }

}  //class MyHomePageState
