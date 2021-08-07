import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getnews/data/constant.dart';
import 'package:getnews/data/localdb.dart';
import 'package:getnews/pages/homepage.dart';
import 'package:getnews/services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:getnews/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void checkUserLog() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = await auth.currentUser;
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkUserLog();
  }

  signInMethod(context) async {
    await signInWithGoogle();
    constant.name = (await LocalDataSaver.getName())!;
    constant.email = (await LocalDataSaver.getEmail())!;
    constant.img = (await LocalDataSaver.getImg())!;

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff574b90),
      // appBar: AppBar(
      // title: Text("Login To App"),
      // backgroundColor: Color(0xff574b90),
      // ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "GetNews",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Your daily news app",
                style: TextStyle(color: Colors.white30, fontSize: 20),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                "Sign in with Google to continue",
                style: TextStyle(color: Colors.white70, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              SignInButton(
                Buttons.GoogleDark,
                // Buttons.Google,

                onPressed: () {
                  signInMethod(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
