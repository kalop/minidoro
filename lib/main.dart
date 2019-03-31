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
      primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Minidoro'),
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
    ThemeData themeData = Theme.of(context);
     return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

      ),
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
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget child){
                return Text(
                  _counter,
                  style: themeData.textTheme.display4,
                );
              },
            ),
            RaisedButton(
                color: Colors.green,
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
                child: Container(
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 25
                    ),),
                )
              ),
              RaisedButton(
                color: Colors.red,
                onPressed: (){
                  if(controller.isAnimating){
                    controller.reset();
                  }
                  else{
                    controller.reverse(
                      from: controller.value == 0.0 ? 1.0:controller.value
                    );
                  }
                  
                },
                child: Container(
                  child: Text(
                    'RESET',
                    style: TextStyle(
                      fontSize: 25
                    ),),
                )
              )
        
          ],
        ),
      ),
    
      );
    // This trailing comma makes auto-formatting nicer for build methods.
    
  }
}