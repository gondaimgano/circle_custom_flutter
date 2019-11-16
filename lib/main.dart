import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:vector_math/vector_math.dart'  as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Had Fun with Custom Draw'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin{
  AnimationController _controller;
  double arcLength()=>lerpDouble(0.0, 1.0, _controller.value);
  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this,duration: Duration(milliseconds: 600),);
    Future.delayed(Duration(seconds: 1),(){
      toggle();
    });

  }
  void toggle(){
    final iscomplete=_controller.status==AnimationStatus.completed;
    _controller.fling(velocity: iscomplete?-0.5:1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
            onTap: toggle,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context,child)=>
               Container(
                 width: 300,
                 height: 300,
                 child: CustomPaint(
                  foregroundPainter: CustomCircleArc(value: arcLength()),

              ),
               ),
            ),
          )),
    );
  }
}

class CustomCircleArc extends CustomPainter {

  CustomCircleArc({this.value=0.0});
  final double value;
  @override
  void paint(Canvas canvas, Size size) {
    Paint red = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke

      ..strokeWidth = 90;
    Paint blue = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke

      ..strokeWidth = 50;
    Paint green = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke

      ..strokeWidth = 70;
    Paint yellow = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke

      ..strokeWidth = 80;
    Paint black = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke

      ..strokeWidth = 100;
    Paint lime = Paint()
      ..color = Colors.limeAccent
      ..style = PaintingStyle.fill

      ..strokeWidth = 100;

    // Path path=Path();
    var rect = Rect.fromCircle(
      center: Offset(size.width * 0.5, size.height * 0.5),
      radius: size.width*0.45
    );

    // path.addArc(Rect.fromCircle(center:Offset(size.width*0.5,size.height*0.5),radius: size.width*0.45), math.radians(0), math.radians(20));
    canvas
      ..drawArc(rect, math.radians(360*0.0), math.radians((360*0.2)*value), false, red)
      ..drawArc(rect, math.radians(360*0.21), math.radians((360*0.2)*value), false, blue)
      ..drawArc(rect, math.radians(360*0.44), math.radians((360*0.10)*value), false, green)
      ..drawArc(rect, math.radians(360*0.55), math.radians((360*0.15)*value), false, yellow)
      ..drawArc(rect, math.radians(360*(0.71)), math.radians((360*0.28)*value), false, black);

    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), (size.width*0.20)*value, lime);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
