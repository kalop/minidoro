import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:developer';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minidoro',
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Minidoro'),
      home: MyStack(),
    );
  }
}

class MyStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 1,
            child: Container(
              color: Colors.white,
            ),
            ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.25,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.lightGreen],
                  begin: Alignment.topLeft
                  ),
              ),
              child: FlutterLogo()
              )
            ),
        ),
        MyHomePage(title: 'Minidoro'),

      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _FormData createState() => _FormData();
}


class _FormData extends State<MyHomePage> with TickerProviderStateMixin{ 
  AnimationController controller;

  String get _counter {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState(){
    super.initState();
    controller =AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );
  }

// This method is rerun every time setState is called
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: <Widget>[
       
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget child){
                return Text(
                  _counter,
                  style: TextStyle(
                    fontFamily: 'Digital7',
                    fontSize: 150,
                    color: Colors.blueGrey),
                );
              },
            ),
      
            ButtonTheme(
              child: RaisedButton(
                color: Colors.green,   
                padding: EdgeInsets.all(0),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0)),
                onPressed: (){
                  if(controller.isAnimating){
                    controller.stop();
                  }
                  else{
                    controller.reverse(
                      from: controller.value == 0.0 ? 1.0:controller.value
                    );
                  }
                  
                },
                child: AnimatedBuilder(   
                  animation: controller,
                  builder: (BuildContext context, Widget child){
                    return Icon (controller.isAnimating
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                      size: 80,
                      color: Colors.white,
                      );
                  },
                 ),
                ),
              ),
              RaisedButton(
                color: Colors.red,
                padding: EdgeInsets.all(0),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0)),
                onPressed: (){
                    controller.reset();
                },
                child: AnimatedBuilder(                  
                  animation: controller,
                  builder: (BuildContext context, Widget child){
                    return Icon (
                      Icons.stop,
                     size: 80,);
                  },
                ),
              )
        
          ],
        ),
      ),
    
      );
    // This trailing comma makes auto-formatting nicer for build methods.
    
  }
}