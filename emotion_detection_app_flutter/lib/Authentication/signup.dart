import 'package:emotion_detection_app_flutter/Firebase/authenticate.dart';
import 'package:emotion_detection_app_flutter/main.dart';
import 'package:emotion_detection_app_flutter/route.dart' as route;
import 'package:flutter/material.dart';

void main() {
  runApp(SignUp());
}

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

String errorMessage = '';
String userEmail;
String userPassword;
String userPhoneNumber;
final GlobalKey<FormState> signUpGlobalKey = GlobalKey<FormState>();
//Patterns for email and phone number
Pattern emailPattern =
    r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
Pattern phonePattern = r'^(?:[+0]9)?[0-9]{10}$';

class _SignUp extends State<SignUp> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: route.generateRoute,
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text('Sign Up for free'),
              centerTitle: true,
              backgroundColor: Colors.grey,
            ),
            body: Form(
                key: signUpGlobalKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Already have an account?',
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('login');
                              },
                              child: Text(
                                'Log In',
                                style: TextStyle(color: Colors.cyan),
                              )),
                        ],
                      ),
                      email(),
                      SizedBox(height: 30),
                      password(),
                      SizedBox(height: 30),
                      confirmPassword(),
                      SizedBox(height: 30),
                      phoneNumber(),
                      SizedBox(height: 30),
                      FlatButton(
                        onPressed: () async {
                          if (signUpGlobalKey.currentState.validate()) {
                            dynamic authResult =
                                _authService.signUpWithEmailAndPassword(
                                    userEmail, userPassword);
                            if (authResult == null) {
                              setState(() {
                                errorMessage = 'Error signing up';
                              });
                            }
                          }
                        },
                        child: Text('Sign Up',
                            style: TextStyle(color: Colors.white)),
                        padding: EdgeInsets.all(10),
                        color: Colors.blue[300],
                        hoverColor: Colors.white,
                      ),
                      SizedBox(height: 15),
                      Text(errorMessage)
                    ],
                  ),
                )),
          ),
        ));
  }
}

Widget email() {
  return TextFormField(
    keyboardType: TextInputType.emailAddress,
    validator: (String input) {
      if (input.isEmpty || !RegExp(emailPattern).hasMatch(input)) {
        return 'Enter a valid email';
      } else
        userEmail = input; //Assign this to userEmail value later
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
        userPassword = input; //Use the password later
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

Widget confirmPassword() {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    validator: (String input) {
      if (input.isEmpty || input.length <= 7 || userPassword != input) {
        return 'Enter a valid password';
      }
      //Use the password later
    },
    decoration: InputDecoration(
      hintText: 'Confirm Password',
      prefixIcon: Icon(Icons.lock),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(33))),
    ),
  );
}

Widget phoneNumber() {
  return TextFormField(
    keyboardType: TextInputType.phone,
    validator: (String phone) {
      if (phone.isEmpty || !RegExp(phonePattern).hasMatch(phone)) {
        return 'Enter valid phone number';
      }
      //Assign this to userPhoneNumber later
    },
    decoration: InputDecoration(
      hintText: 'Your Phone',
      prefixIcon: Icon(Icons.phone),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(33))),
    ),
  );
}
