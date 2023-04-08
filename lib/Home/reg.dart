import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/Models/Parents.dart';
import '../Cache_data/cache_date_imp.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'Login.dart';
import 'home.dart';
class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late String _email,_name,_adress,_phone;

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController emailcon=TextEditingController();
  TextEditingController namecon=TextEditingController();
  TextEditingController phonecon=TextEditingController();
  TextEditingController adresscon=TextEditingController();
  TextEditingController passwordcon=TextEditingController();
  late FirebaseDatabase database;
  late FirebaseApp  app;
  late DatabaseReference base;
  Cache_Data_imp cacheDataImpHelper=Cache_Data_imp();
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
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                "ادخل بيانات انشاء الحساب",
                                style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: TextFormField(

                                validator: (value){
                                  if(value!.isEmpty){
                                    return "من فضلك ادخل الايميل";
                                  }
                                  return null;
                                },
                                onSaved: (email){
                                  _email=email!;
                                },
                                controller: emailcon,
                                style: TextStyle(fontFamily: "yel",color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.emailAddress,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color:Colors.black),
                                  ),

                                  hintText: 'ادخل البريد الالكترونى',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'البريد الالكترونى',
                                  labelStyle: TextStyle(color: Colors.black),

                                  //prefixText: ' ',
                                  //suffixText: 'USD',
                                  //suffixStyle: const TextStyle(color: Colors.green)),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: TextFormField(

                                validator: (value){
                                  if(value!.isEmpty){
                                    return "من فضلك ادخل الاسم";
                                  }
                                  return null;
                                },
                                onSaved: (name){
                                  _name=name!;
                                },
                                controller: namecon,
                                style: TextStyle(fontFamily: "yel",color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color:Colors.black),
                                  ),

                                  hintText: 'ادخل الاسم',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'الاسم',
                                  labelStyle: TextStyle(color: Colors.black),

                                  //prefixText: ' ',
                                  //suffixText: 'USD',
                                  //suffixStyle: const TextStyle(color: Colors.green)),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: TextFormField(

                                validator: (value){
                                  if(value!.isEmpty){
                                    return "من فضلك ادخل العنوان";
                                  }
                                  return null;
                                },
                                onSaved: (adress){
                                  _adress=adress!;
                                },
                                controller: adresscon,
                                style: TextStyle(fontFamily: "yel",color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color:Colors.black),
                                  ),

                                  hintText: 'ادخل العنوان ',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'العنوان',
                                  labelStyle: TextStyle(color: Colors.black),

                                  //prefixText: ' ',
                                  //suffixText: 'USD',
                                  //suffixStyle: const TextStyle(color: Colors.green)),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: TextFormField(

                                validator: (value){
                                  if(value!.isEmpty){
                                    return "من فضلك ادخل الهاتف";
                                  }
                                  return null;
                                },
                                onSaved: (phone){
                                  _phone=phone!;
                                },
                                controller: phonecon,
                                style: TextStyle(fontFamily: "yel",color: Colors.black),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color:Colors.black),
                                  ),

                                  hintText: 'ادخل الهاتف ',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'الهاتف',
                                  labelStyle: TextStyle(color: Colors.black),

                                  //prefixText: ' ',
                                  //suffixText: 'USD',
                                  //suffixStyle: const TextStyle(color: Colors.green)),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "من فضلك ادخل كلمة المرور";
                                  }
                                  return null;
                                },
                                onSaved: (password){
                                },
                                controller: passwordcon,

                                style: TextStyle(fontFamily: "yel",color: Colors.amber.shade500),
                                // controller: addRoomProvider.bednocon,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),

                                  hintText: 'ادخل كلمة المرور',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelText: 'كلمة المرور',
                                  labelStyle: TextStyle(color:Colors.black),
                                  counterStyle: TextStyle(color:Colors.black),
                                  suffixStyle: TextStyle(color:Colors.black),
                                  //prefixText: ' ',
                                  //suffixText: 'USD',
                                  //suffixStyle: const TextStyle(color: Colors.green)),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Container(
                              width: 250,
                              child: ElevatedButton(

                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade500),

                                    shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                            side: BorderSide(color: Colors.orange.shade500)))),
                                child: Text("سجل حساب",style: TextStyle(color: Colors.black),),
                                onPressed: () async {


                                  if(
                                  _formkey.currentState!.validate()){
                                    showDialog<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext dialogContext) {
                                        return AlertDialog(
                                          title: Text('تحميل البيانات....'),
                                          content: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              CircularProgressIndicator(),
                                            ],
                                          ),

                                        );
                                      },
                                    );
                                    UserCredential userCredential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                        email: emailcon.text.toString().trim(),
                                        password: passwordcon.text.toString()
                                            .trim()
                                    );
                                    app = await Firebase.initializeApp();
                                    database = FirebaseDatabase(app: app);
                                    base = database.reference().child("Parents");
                                    String email = emailcon.text;
                                    String password = passwordcon.text;
                                    String name = namecon.text;
                                    String phone = phonecon.text;
                                    String adress=adresscon.text;
                                    Parents parents = Parents(
                                      email: email,
                                      password: password,
                                      name: name,
                                      phone: phone,
                                      adress: adress,
                                      Uid: FirebaseAuth.instance.currentUser?.uid
                                    );
                                    base.child(
                                        FirebaseAuth.instance.currentUser!.uid)
                                        .set(parents.toJson())
                                        .whenComplete(() {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    });


                                  }else{
                                    print("خطا");
                                  }

                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: TextButton(


                              child: Text("اضغط هنا للعودة",style: TextStyle(color: Colors.grey),),
                              onPressed: () {
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
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
