import 'package:flutter/material.dart';
import 'package:flutter_animation/chrome_floating_circles.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Goolge Animation',
      home: new Scaffold(
        appBar: AppBar(
          title: Text('Flutter Google Animation'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ChromeFloatingCircles(
                topLeftItemColor: Colors.red,
                topRightItemColor: Colors.green,
                bottomLeftItemColor: Colors.yellow,
                bottomRightItemColor: Colors.blue,
                size: 50.0,
              )
            ],
          ),
        ),
      )
    );
  }
}
