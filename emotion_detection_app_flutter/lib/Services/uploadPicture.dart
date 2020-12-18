import 'package:emotion_detection_app_flutter/Firebase/authenticate.dart';
import 'package:emotion_detection_app_flutter/main.dart';
import 'package:flutter/material.dart';

//Image uploading page
main() {
  runApp(UploadPicture());
}

class UploadPicture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UploadPicture();
  }
}

class _UploadPicture extends State<UploadPicture> {
  @override
  AuthService _firebaseAuth = AuthService();
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(onPressed: () async {
                await _firebaseAuth.userSignOut();
              }, child: Text('Sign Out'))
            ],
          ),
        ),
      ),
    );
  }
}
