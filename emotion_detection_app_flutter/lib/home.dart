import 'package:emotion_detection_app_flutter/route.dart';
import 'package:flutter/material.dart';
import 'package:emotion_detection_app_flutter/route.dart' as route;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: route.generateRoute,
      initialRoute: HomeRoute,
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) =>Scaffold(
        
        
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text("Emotion Detection"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  child: Image.network(
                    'https://www.nviso.ai/uploads/cms_media/image-white-paper.jpg',width:400,height:300,
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      side: BorderSide(color: Colors.cyanAccent)),
                  onPressed: () {
                    Navigator.of(context).pushNamed('login');
                  },
                  color: Colors.blue[50],
                  textColor: Colors.black,
                  child: Text("Log In", style: TextStyle(fontSize: 14,color: Colors.blueGrey)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'OR',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.0),
                      side: BorderSide(color: Colors.cyanAccent)),
                  onPressed: () {Navigator.of(context).pushNamed('signup');},
                  color: Colors.blue[50],
                  textColor: Colors.white,
                  child: Text("Sign Up", style: TextStyle(fontSize: 14,color: Colors.blueGrey)),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
