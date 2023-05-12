import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:nurseries/Home/home.dart';
import 'dart:ui' as ui;

import '../Models/user_model.dart';

class Booking extends StatefulWidget {
  String name;
  String id;
  int number;
  Booking({required this.name, required this.id, required this.number});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
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
    });
  }

  late String _datebook, _no, _agebaby, _nots;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController datebookcon = TextEditingController();
  TextEditingController notescon = TextEditingController();
  TextEditingController nocon = TextEditingController();
  TextEditingController agecon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formkey,
            child: Container(
              color: Colors.grey.shade100,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      color: Colors.grey.shade100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                "ادخل بيانات حجز الحضانة",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TextField(
                            controller: datebookcon,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText: "Enter Date" //label text of field
                                ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  datebookcon.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "من فضلك ادخل عمر الطفل";
                                  }
                                  return null;
                                },
                                onSaved: (age) {
                                  _agebaby = age!;
                                },
                                controller: agecon,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'ادخل عمر الطفل',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'عمرالطفل',
                                  labelStyle: TextStyle(color: Colors.black),

                                  //prefixText: ' ',
                                  //suffixText: 'USD',
                                  //suffixStyle: const TextStyle(color: Colors.green)),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: TextFormField(
                                maxLines: 4,
                                controller: notescon,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'ادخل ملحوظات اضافية ',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'ملحوظات اضافية',
                                  labelStyle: TextStyle(color: Colors.black),

                                  //prefixText: ' ',
                                  //suffixText: 'USD',
                                  //suffixStyle: const TextStyle(color: Colors.green)),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Container(
                              width: 250,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.orange.shade500),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            side: BorderSide(
                                                color:
                                                    Colors.orange.shade500)))),
                                child: Text(
                                  "ارسال طلب الحجز",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () async {
                                  String date = datebookcon.text.trim();
                                  String age = agecon.text.trim();
                                  String notes = notescon.text.trim();
                                  int nurNumber = widget.number - 1;

                                  User? user =
                                      FirebaseAuth.instance.currentUser;

                                  if (user != null) {
                                    DatabaseReference companyRef =
                                        FirebaseDatabase.instance
                                            .reference()
                                            .child('bookings');

                                    String? id = companyRef.push().key;

                                    await companyRef.child(id!).set({
                                      'id': id,
                                      'date': date,
                                      'age': age,
                                      'userName': currentUser.name,
                                      'userPhone': currentUser.phone,
                                      'notes': notes,
                                      'hospitalName': widget.name,
                                      'hospitalId': widget.id,
                                      'nurnumber': nurNumber,
                                      'uid': FirebaseAuth
                                          .instance.currentUser!.uid,
                                    });

                                    DatabaseReference bloodRef =
                                        FirebaseDatabase.instance
                                            .reference()
                                            .child('hosbitals')
                                            .child('${widget.id}');

                                    await bloodRef
                                        .update({'nurnumber': nurNumber});
                                  }
                                  showAlertDialog(context);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: TextButton(
                              child: Text(
                                "اضغط هنا للعودة",
                                style: TextStyle(color: Colors.grey),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Home()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('ادفع الأن'),
            content: Container(
              height: 100,
              child: Text('اختر طريقة الدفع'),
            ),
            actions: [
              ElevatedButton.icon(
                icon: const Icon(Icons.credit_card, size: 18),
                label: Text('بطاقة الأئتمان'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Notice"),
                        content: SizedBox(
                          height: 65,
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: HexColor('#155564'),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfff8a55f), width: 2.0),
                              ),
                              border: OutlineInputBorder(),
                              hintText: 'ادخل رقم الفيزا',
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: HexColor('#6bbcba'),
                            ),
                            child: Text("دفع"),
                            onPressed: () {
                              Navigator.pushNamed(context, Home.routeName);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.credit_card, size: 18),
                label: Text('كاش'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Notice"),
                        content: Text("تم الحجز وسيتم الفع كاش فى المستشفى"),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: HexColor('#6bbcba'),
                            ),
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.pushNamed(context, Home.routeName);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ));
}
