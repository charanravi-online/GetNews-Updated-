// import 'package:firebase_auth/firebase_auth.dart';

// import 'dart:html';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:getnews/data/localdb.dart';
import 'package:getnews/pages/category.dart';
import 'package:getnews/pages/homepage.dart';
import 'package:getnews/pages/newsview.dart';
import 'package:getnews/screens/login.dart';
import 'package:getnews/services/local_notification_service.dart';
// import 'package:getnews/views/sign_up_widget.dart';
import 'pages/homepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: unnecessary_statements
  LocalNotificationService.initialize;

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogIn = false;

  getLoggedInState() async {
    await LocalDataSaver.getLogData().then((value) {
      setState(() {
        isLogIn = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoggedInState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GetNews',
      theme: ThemeData(
        brightness: Brightness.light,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.blue,
      ),
      home: isLogIn ? HomePage() : Login(),
      routes: {
        //caategories
        "HomePage": (_) => HomePage(),
        "business": (_) => Category(query: "business"),
        "technology": (_) => Category(query: "technology"),
        "entertainment": (_) => Category(query: "entertainment"),
        "sports": (_) => Category(query: "sports"),
        "science": (_) => Category(query: "science"),
        "health": (_) => Category(query: "health"),
        "corona": (_) => Category(query: "corona"),

        // distributions
        "toi": (_) => Category(query: "the-times-of-india"),
        "bbc": (_) => Category(query: "bbc-news"),
        "cnn": (_) => Category(query: "cnn"),
        "foxnews": (_) => Category(query: "fox-news"),
        "news24": (_) => Category(query: "news24"),
        "techradar": (_) => Category(query: "techradar"),
        "mashable": (_) => Category(query: "mashable"),
        "buzzfeed": (_) => Category(query: "buzzfeed"),
        "espn": (_) => Category(query: "espn"),
        "bbcsport": (_) => Category(query: "bbc-sport"),
        "bleacherreport": (_) => Category(query: "bleacher-report"),
      },
      // FirebaseAuth.instance.currentUser == null ? Login() : HomePage(),
    );
  }
}
