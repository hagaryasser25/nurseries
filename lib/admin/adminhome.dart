import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/admin/admin_bookings.dart';
import 'package:nurseries/admin/admin_complains.dart';

import '../openscreen.dart';
import 'add_hosbital.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              "الصفحة الرئيسية لمدير النظام",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            child: ListView(
              children: [
                Image(
                  image: AssetImage('assets/images/adminn.png'),
                  width: 400.0,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                    "صلاحيات مدير النظام",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddHosbital()));
                        },
                        child: Container(
                          height: 50,
                          color: Colors.purple.shade400,
                          child: const Center(
                              child: Text(
                            'أضافة مستشفيات',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BookingList()));
                        },
                        child: Container(
                          height: 50,
                          color: Colors.amber[200],
                          child: const Center(
                              child: Text(
                            'حجوزات الحضانات',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminComplains()));
                        },
                        child: Container(
                          height: 50,
                          color: Colors.amber[100],
                          child: const Center(
                              child: Text(
                            'الشكاوى',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          )),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OpenScreen()));
                        },
                        child: Container(
                            height: 50,
                            color: Colors.purple.shade50,
                            child: const Center(
                                child: Text(
                              'خروج',
                              style: TextStyle(color: Colors.black, fontSize: 25),
                            )),
                          ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          drawer: SafeArea(
            child: Drawer(
              elevation: 2.3,
              child: ListView(
                // header
                children: [
                  DrawerHeader(
                    //container with alignment.center
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Color(0xffC43990)])),
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50, // sets the radius of the circle
                          backgroundImage: AssetImage(
                              'assets/images/download.png'), // sets the image
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "منطقة مدير النظام",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //he
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("الرئيسية"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                    dense: true,
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AdminHome()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.ten_k_outlined),
                    title: Text("أضافة المستشفيات"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                    dense: true,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddHosbital()));
                    },
                  ),

                  /// logout
                ],
              ),
            ),
          ),
        ));
  }
}
