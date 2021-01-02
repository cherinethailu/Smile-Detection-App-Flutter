import 'package:emotion_detection_app_flutter/Firebase/authenticate.dart';
import 'package:emotion_detection_app_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//Image uploading page
main() {
  runApp(UploadPicture());
}

class UploadPicture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UploadPicture();
  }
}

class _UploadPicture extends State<UploadPicture> {
  @override
  AuthService _firebaseAuth = AuthService();
  String placeholderPictureAddress =
      "assets/images/picture_placeholder.png";
  Widget _uploadFromGallery() {}
  Widget _uploadFromCamera() {}
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _firebaseAuth.userSignOut();
              },
              icon: Icon(Icons.person, color: Colors.red),
              label: Text(
                "Sign Out",
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.asset(
                  placeholderPictureAddress,
                  width: 400,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        side: BorderSide(color: Colors.grey)),
                    onPressed: () {},
                    color: Colors.blue[50],
                    textColor: Colors.white,
                    splashColor: Colors.teal[100],
                    child: Text("Camera",
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey)),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23.0),
                        side: BorderSide(color: Colors.grey)),
                    onPressed: () {},
                    color: Colors.blue[50],
                    splashColor: Colors.teal[100],
                    textColor: Colors.white,
                    child: Text("Gallery",
                        style: TextStyle(fontSize: 14, color: Colors.blueGrey)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
