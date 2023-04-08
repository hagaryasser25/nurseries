import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/hosbital.dart';
import 'adminhome.dart';

class AddHosbital extends StatefulWidget {
  const AddHosbital({Key? key}) : super(key: key);

  @override
  State<AddHosbital> createState() => _AddHosbitalState();
}

class _AddHosbitalState extends State<AddHosbital> {
  late String _hosname,
      _hosadress,
      _nurnumber,
      _nurdes,
      _nurprice,
      _latitude,
      _longitude;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController hosnamecon = TextEditingController();
  TextEditingController hosadresscon = TextEditingController();
  TextEditingController nurnumbercon = TextEditingController();
  TextEditingController nurpricecon = TextEditingController();
  TextEditingController nurdescon = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();

  late FirebaseDatabase database;
  late FirebaseApp app;
  late DatabaseReference base;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
                            padding: const EdgeInsets.all(40.0),
                            child: Center(
                              child: Text(
                                "ادخل بيانات المستشفيات",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "من فضلك ادخل اسم المستشفى";
                                  }
                                  return null;
                                },
                                onSaved: (hosname) {
                                  _hosname = hosname!;
                                },
                                controller: hosnamecon,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: 'ادخل  اسم المستشفى',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'اسم المستشفى',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "من فضلك ادخل عنوان المستشفى";
                                  }
                                  return null;
                                },
                                onSaved: (hosadress) {
                                  _hosadress = hosadress!;
                                },
                                controller: hosadresscon,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'ادخل عنوان المستشفى',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'عنوان المستشفى',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "خط العرض على الخريطة";
                                  }
                                  return null;
                                },
                                onSaved: (latituide) {
                                  _latitude = latituide!;
                                },
                                controller: latitude,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'ادخل خط العرض على الخريطة',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'خط العرض على الخريطة',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "ادخل خط الطول على الخريطة";
                                  }
                                  return null;
                                },
                                onSaved: (longitude) {
                                  _longitude = longitude!;
                                },
                                controller: longitude,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'خط الطول على الخريطة',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'خط الطول على الخريطة',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "من فضلك ادخل عدد الحضانات";
                                  }
                                  return null;
                                },
                                onSaved: (nurno) {
                                  _nurdes = nurno!;
                                },
                                controller: nurnumbercon,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'ادخل عدد الحضانات',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'عدد حضانات المستشفى',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "من فضلك ادخل سعر الحضانة فى الليلة";
                                  }
                                  return null;
                                },
                                onSaved: (nurprice) {
                                  _nurprice = nurprice!;
                                },
                                controller: nurpricecon,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'ادخل سعر الحضانة فى الليلة',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'سعر الحضانة فى الليلة',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "من فضلك ادخل وصف الحضانة  ";
                                  }
                                  return null;
                                },
                                onSaved: (nurdes) {
                                  _nurdes = _nurdes!;
                                },
                                controller: nurdescon,
                                style: TextStyle(
                                    fontFamily: "yel", color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                maxLines: 4,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'ادخل وصف الحضانة ',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'وصف الحضانة  ',
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
                                  "ادخل بيانات المستشفيات و الحضانات ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    app = await Firebase.initializeApp();
                                    database = FirebaseDatabase(app: app);
                                    base =
                                        database.reference().child("hosbitals");
                                    String? id = base.push().key;

                                    String hosname = hosnamecon.text;
                                    String hosadress = hosadresscon.text;
                                    int nurnumber =
                                        int.parse(nurnumbercon.text);
                                    String nurprice = nurpricecon.text;
                                    String nurdes = nurdescon.text;
                                    String latitudee = latitude.text;
                                    String longitudee = longitude.text;

                                    Hosbital hos = Hosbital(
                                      hosname: hosname,
                                      hosadress: hosadress,
                                      nurdes: nurdes,
                                      nurnumber: nurnumber,
                                      nurprice: nurprice,
                                      longitude: longitudee,
                                      latitude: latitudee,
                                      id: id,
                                    );
                                    base
                                        .push()
                                        .set(hos.toJson())
                                        .whenComplete(() {
                                      hosnamecon.text = "";
                                      hosadresscon.text = "";
                                      id = "";
                                      nurpricecon.text = "";
                                      nurpricecon.text = "";

                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "تم حفظ المستشفى بنجاح ")));
                                      setState(() {});
                                    });
                                  } else {
                                    print("خطا");
                                  }
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
                                    builder: (context) => AdminHome()));
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
