import 'package:emotion_detection_app_flutter/Authentication/login.dart';
import 'package:emotion_detection_app_flutter/home.dart';
import 'package:flutter/material.dart';

import 'Authentication/signup.dart';

void main() => runApp(Home());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Scaffold(
       appBar: AppBar(),
       body: LogIn(),
     ),
    );
  }
}
//Note:We call LogIn class from login.dart by default in main.dart