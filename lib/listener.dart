import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:emotion_detection_app_flutter/home.dart';
import 'package:emotion_detection_app_flutter/Services/uploadPicture.dart';
import 'package:emotion_detection_app_flutter/Firebase/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  AuthService _authService = AuthService();
  Widget build(BuildContext context) {
    final userData = Provider.of<FirebaseUser>(context);
    if(userData == null){
      return Home();
    }
    else
    return UploadPicture();
  }
}
