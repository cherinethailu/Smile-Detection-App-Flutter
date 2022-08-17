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
TextEditingController emailController = TextEditingController();
String errorMessage = "";
String userEmail = "";
String userPassword;
String userPasswordResetEmail = "";
String userNotFound = "";
String emailError = "";

final GlobalKey<FormState> logInGlobalKey = GlobalKey<FormState>();

Pattern emailPattern =
    r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';

class _MyLogIn extends State<LogIn> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    errorMessage = "";
    emailError = "";
    userNotFound = "";
    userPasswordResetEmail = "";
  }
  @override
  final AuthService _authService = AuthService();
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: IconButton (
            icon:Icon(Icons.arrow_back),
            onPressed: (){
            Navigator.pop(context);
          },),
          automaticallyImplyLeading: true,
          title: Text('Face Detection'),
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
                    dynamic authResult = await _authService
                        .logInWithEmailAndPassword(userEmail, userPassword);
                    if (authResult == null) {
                      setState(() {
                        errorMessage = 'Email or password incorrect';
                        userPasswordResetEmail = "" ;
                        emailError = "";
                        userNotFound = "";
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
              
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Forgot password?'),
                  TextButton(
                      onPressed: () async {
                        if (emailController.text.isEmpty || !RegExp(emailPattern).hasMatch(emailController.text)) {
                          setState(() {
                            emailError = "Please enter a valid email";
                            errorMessage = "";
                          });
                        } else {
                          try {
                            // String email = emailController.text.trim();
                            var value = await _authService.userResetPassword(emailController.text.trim());
                            setState(() {

                              userPasswordResetEmail =
                                  "Password resetting email has been sent to " +
                                      emailController.text.trim();
                              print(emailController.text.trim());
                              print(value);
                              emailError = "";
                              userNotFound = "";
                            });
                          } catch (e) {
                            setState(() {
                              userNotFound = "User email not found";
                              userPasswordResetEmail = "";
                              emailError = "";
                              errorMessage = "";
                            });
                          }
                        }
                      },
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              Text(
                emailError,
                style: TextStyle(color: Colors.red),
              ),
              Text(userPasswordResetEmail,
                  style: TextStyle(color: Colors.blueAccent)),
              Text(userNotFound, style: TextStyle(color: Colors.red)),
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
    controller: emailController,
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
