import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/Home/send_complain.dart';
import 'package:nurseries/Home/user_replays.dart';

import '../Cache_data/cache_date_imp.dart';
import '../Models/hosbital.dart';
import '../openscreen.dart';
import 'nur.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Hosbital> hosList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    HosListFun();
  }

  void HosListFun() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("hosbitals");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Hosbital p = Hosbital.fromJson(event.snapshot.value);
      hosList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  Cache_Data_imp cacheDataImpHelper = Cache_Data_imp();
  final List<Widget> images = [
    Image.asset('assets/images/hadana.jpeg'),
    Image.asset('assets/images/hadana2.jpeg'),
    Image.asset('assets/images/haaaaaa.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              "الصفحة الرئيسية لولى الامر",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      height: 300,
                    ),
                    items: images
                        .map((item) => Container(
                              child: item,
                            ))
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Text(
                      "قائمة المستشفيات",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    )),
                  ),
                  ListView.builder(
                      itemCount: hosList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NurDet(hosList[index])));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, left: 10),
                            child: Container(
                                width: 350.00,
                                child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                  hosList[index].hosname.toString(),
                                  style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            hosList[index].hosadress.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    )),
                                decoration: new BoxDecoration(
                                  color: Colors.purple.shade700,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: Colors.amber, width: 8),
                                )),
                          ),
                        );
                      })
                ],
              ),
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
                              'assets/images/haaaaaa.jpg'), // sets the image
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "منطقة ولى الامر",
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Home()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.ten_k_outlined),
                    title: Text("ارسال الشكوى"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                    dense: true,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserComplain()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.ten_k_outlined),
                    title: Text("الردود على الشكاوى"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                    dense: true,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StoreReplays()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("خروج"),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                    dense: true,
                    onTap: ()async {
                      await FirebaseAuth.instance.signOut();
                      cacheDataImpHelper.setpassword("");
                      cacheDataImpHelper.setemail("");
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) => OpenScreen(),));
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
