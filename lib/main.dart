import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/Home/home.dart';
import 'package:nurseries/Home/send_complain.dart';
import 'package:nurseries/Home/user_replays.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/adminhome.dart';
import 'openscreen.dart';
late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
   prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "yel",

        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const OpenScreen()
          : FirebaseAuth.instance.currentUser!.email == 'admin@yahoo.com'
              ? const AdminHome()
              : Home(),

      routes: {
        UserComplain.routeName: (ctx) => UserComplain(),
        Home.routeName: (ctx) => Home(),
        AdminHome.routeName: (ctx) => AdminHome(),
        StoreReplays.routeName: (ctx) => StoreReplays(),
      },
    );
  }
}

