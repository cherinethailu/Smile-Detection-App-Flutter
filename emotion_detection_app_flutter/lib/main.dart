import 'package:emotion_detection_app_flutter/Authentication/login.dart';
import 'package:emotion_detection_app_flutter/Firebase/authenticate.dart';
import 'package:emotion_detection_app_flutter/home.dart';
import 'package:emotion_detection_app_flutter/listener.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Authentication/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
          child: MaterialApp(
       home: Wrapper(),
      ),
    );
  }
}
//Note:We call LogIn class from login.dart by default in main.dart