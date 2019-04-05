import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:your_cook/intro%20screen.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () => runApp(Intro()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        "images/Pizza Slice.flr",
        animation: "Pizza Bounce",
        alignment: Alignment.center,
        fit: BoxFit.contain,
      ),
    );
  }
}
