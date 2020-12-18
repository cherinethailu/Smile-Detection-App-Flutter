import 'package:emotion_detection_app_flutter/Firebase/authenticate.dart';
import 'package:emotion_detection_app_flutter/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LogIn());
}

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyLogIn();
  }
}

String errorMessage = '';
String userEmail;
String userPassword;
final GlobalKey<FormState> logInGlobalKey = GlobalKey<FormState>();
Pattern emailPattern =
    r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';

class _MyLogIn extends State<LogIn> {
  @override
  final AuthService _authService = AuthService();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Emotion Detection'),
          centerTitle: true,
        ),
        body: Form(
          key: logInGlobalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              email(),
              SizedBox(
                height: 30,
              ),
              password(),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () async {
                  if (logInGlobalKey.currentState.validate()) {
                    //loginGlobalKey.currentState.save();
                    //And Auth stuff
                    dynamic authResult = _authService.logInWithEmailAndPassword(
                        userEmail, userPassword);
                    if (authResult == null) {
                      setState(() {
                        errorMessage = 'Email or password incorrect';
                      });
                    }
                  }
                },
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.all(10),
                color: Colors.blue,
                hoverColor: Colors.white,
              ),
              SizedBox(height: 15),
                Text(errorMessage,style:TextStyle(color: Colors.red),),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Forgot password?'),
                  FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget email() {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    validator: (String input) {
      if (input.isEmpty || !RegExp(emailPattern).hasMatch(input)) {
        return 'Enter a valid email';
      } else
        userEmail = input;
    },
    decoration: InputDecoration(
      hintText: 'Email',
      prefixIcon: Icon(Icons.mail),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(33))),
    ),
  );
}

Widget password() {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    validator: (String input) {
      if (input.isEmpty || input.length <= 7) {
        return 'Enter a valid password';
      } else
        userPassword = input;
    },
    decoration: InputDecoration(
      hintText: 'Password',
      prefixIcon: Icon(Icons.lock),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(33))),
    ),
  );
}
