import 'package:emotion_detection_app_flutter/Firebase/authenticate.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mlkit/mlkit.dart';
import 'dart:ui' as ui;

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
  File placeholderPictureAddress;
  List<Rect> rectArr = new List();
  ui.Image image;
  _uploadFromGallery() async {
    placeholderPictureAddress =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFile(placeholderPictureAddress);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> listOfFaces =
        await faceDetector.processImage(firebaseVisionImage);
    for (Face face in listOfFaces) {
      rectArr.add(face.boundingBox);
    }
    print(rectArr);
    setState(() {});
  }

  _uploadFromCamera() async {
    placeholderPictureAddress =
        await ImagePicker.pickImage(source: ImageSource.camera);
    FirebaseVisionImage firebaseVisionImage =
        FirebaseVisionImage.fromFile(placeholderPictureAddress);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> listOfFaces =
        await faceDetector.processImage(firebaseVisionImage);
    for (Face face in listOfFaces) {
      rectArr.add(face.boundingBox);
    }
    print(rectArr);
    //var bytesFromImageFile = placeholderPictureAddress.readAsBytesSync();

    setState(() {});
  }

  Widget _checkIfPathIsEmpty() {
    if (placeholderPictureAddress == null) {
      this.setState(() {});
      return Text("Please select an image to continue");
    } else {
      this.setState(() {});
      return Image.file(placeholderPictureAddress);
    }
  }

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
                width: 400,
                height: 300,
                child: _checkIfPathIsEmpty(),
                alignment: Alignment.center,
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
                    onPressed: () {
                      _uploadFromCamera();
                    },
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
                    onPressed: () {
                      _uploadFromGallery();
                    },
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
