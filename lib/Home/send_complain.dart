import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nurseries/Home/home.dart';

import '../Models/user_model.dart';

class UserComplain extends StatefulWidget {
  static const routeName = '/userComplain';
  const UserComplain({
    super.key,
  });

  @override
  State<UserComplain> createState() => _UserComplainState();
}

class _UserComplainState extends State<UserComplain> {
  var descriptionController = TextEditingController();
  String uid = FirebaseAuth.instance.currentUser!.uid;

  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;

  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserData();
  }

  late Users currentUser;
  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("Parents")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
      print(currentUser.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 10.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Text(
                          "ادخل محتوى الشكوى",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: TextFormField(
                          maxLines: 4,
                          controller: descriptionController,
                          style:
                              TextStyle(fontFamily: "yel", color: Colors.black),
                          // controller: addRoomProvider.bednocon,
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(color: Colors.black),
                            ),

                            hintText: 'ادخل الشكوى',
                            hintStyle: TextStyle(color: Colors.black),
                            labelText: 'الشكوى',
                            labelStyle: TextStyle(color: Colors.black),

                            //prefixText: ' ',
                            //suffixText: 'USD',
                            //suffixStyle: const TextStyle(color: Colors.green)),
                          )),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Container(
                        width: 250,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orange.shade500),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      side: BorderSide(
                                          color: Colors.orange.shade500)))),
                          child: Text(
                            "ارسال الشكوى",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            String description =
                                descriptionController.text.trim();

                            if (description.isEmpty) {
                              CherryToast.info(
                                title: Text('ادخل الشكوى'),
                                actionHandler: () {},
                              ).show(context);
                              return;
                            }

                            User? user = FirebaseAuth.instance.currentUser;

                            if (user != null) {
                              String uid = user.uid;
                              int date = DateTime.now().millisecondsSinceEpoch;

                              DatabaseReference companyRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('userComplains');

                              String? id = companyRef.push().key;

                              await companyRef.child(id!).set({
                                'id': id,
                                'userUid': uid,
                                'name': currentUser.name,
                                'phoneNumber': currentUser.phone,
                                'description': description,
                                'date': date,
                              });
                            }
                            showAlertDialog(context);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TextButton(
                        child: Text(
                          "اضغط هنا للعودة",
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, Home.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم ارسال الشكوى '),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
