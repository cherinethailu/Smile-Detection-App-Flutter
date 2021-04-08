import 'package:flutter/material.dart';

import 'Authentication/login.dart';
import 'Authentication/signup.dart';
import 'home.dart';
Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case LogInRoute:
      return MaterialPageRoute(builder: (context) => LogIn());
    case SignUpRotue:
      return MaterialPageRoute(builder: (context) => SignUp());
    default:
       return MaterialPageRoute(builder: (context) => Home());
  }
}
const String HomeRoute = '/';
const String LogInRoute = 'login';
const String SignUpRotue = 'signup';