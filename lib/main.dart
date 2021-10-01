//
//how to save a few hours (or more) of your life:
//  make sure the (windows) environment variable, JAVA_HOME,
//  is correctly set to the jdk that you wish to use!
//
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:assets_audio_player/assets_audio_player.dart';  //https://protocoderspoint.com/assets-audio-player-flutter-example/
//import 'package:flutter_sound/flutter_sound.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:flutter_viking_student/View.dart' as View;
//very initially based on https://www.youtube.com/watch?v=Zv5T2C1oKus
//  https://dart.dev/guides/language/effective-dart

const bool verbose = false;

//---------------------------------------------------------------------------
//splashscreen code from https://pub.dev/packages/splashscreen
// ***same problem as other solution!***
/*
import 'package:splashscreen/splashscreen.dart';

void main ( ) {
  runApp(new MaterialApp( home: new MyApp(), ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new SecondScreen(),
        title: new Text('Welcome In SplashScreen',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: const Image(image: AssetImage('images/vikingskannet_rev_1195.png')),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Flutter Egypt"),
        loaderColor: Colors.red
    );
  }
}
*/
//---------------------------------------------------------------------------
//splashscreen code from https://www.geeksforgeeks.org/splash-screen-in-flutter/
// ***same problem as other solution!***
void main ( List<String> args ) => runApp( const MyApp0() );
//or skip splash screen:
//void main(List<String> args) => runApp(const SecondScreen());
//void main ( ) {
//    print( 'debug mode? $kDebugMode' );
//    runApp( const SecondScreen() );
//}
//---------------------------------------------------------------------------
class MyApp0 extends StatelessWidget {
  const MyApp0({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const MyHomePage0(),
      debugShowCheckedModeBanner: true,
    );
  }
}

//---------------------------------------------------------------------------
class MyHomePage0 extends StatefulWidget {
  const MyHomePage0({Key key}) : super(key: key);

  @override
  _MyHomePageState0 createState() => _MyHomePageState0();
}

//---------------------------------------------------------------------------
class _MyHomePageState0 extends State<MyHomePage0> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement( context, MaterialPageRoute(builder: (context) => const SecondScreen()) ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //child: FlutterLogo( size: MediaQuery.of(context).size.height )
      child: const Image(image: AssetImage('images/vikingskannet_rev_1195.png')),
    );
  }
}

//---------------------------------------------------------------------------
class SecondScreen extends StatelessWidget {
  const SecondScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viking Game',
      home: const MyHomePage(Key('state')),
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: true,
    );
  }
}

//---------------------------------------------------------------------------
class MyHomePage extends StatefulWidget {
  const MyHomePage(Key key) : super(key: key);

  @override
  View.MyHomePageState createState() => View.MyHomePageState();
}

//---------------------------------------------------------------------------
