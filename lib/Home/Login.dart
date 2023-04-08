import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/Home/reg.dart';

import '../Cache_data/cache_date_imp.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController emailcon=TextEditingController();
  TextEditingController passwordcon=TextEditingController();
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

                  Container(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height:210,
                    decoration: new BoxDecoration(

                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50), ),
                      image: new DecorationImage(
                        image: new ExactAssetImage('assets/images/login-animated-gif-14.gif'),

                        fit: BoxFit.cover,
                      ),

                    ),
                  ),
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
                                "ادخل بيانات تسجيل الدخول",
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
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade700),

                                    shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                            side: BorderSide(color: Colors.orange.shade900)))),
                                child: Text("سجل دخول",style: TextStyle(color: Colors.black),),
                                onPressed: () async {


                                  if(
                                  _formkey.currentState!.validate()){
                                    try {
                                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                          email: emailcon.text.toString().trim(),
                                          password: passwordcon.text.toString().trim()
                                      );
                                      cacheDataImpHelper.setemail(emailcon.text.toString());
                                      cacheDataImpHelper.setpassword(passwordcon.text.toString());
                                      print(cacheDataImpHelper.getemail());
                                      print(cacheDataImpHelper.getpassword());
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                                    } on FirebaseAuthException catch (e) {
                                      if (e.email!=emailcon.text.toString().trim()) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("هذا البريد الالكترونى غير موجود",style: TextStyle(color: Colors.red),)));
                                        return;
                                      }
                                    }
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));


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


                              child: Text("اضغط هنا لانشاء حساب",style: TextStyle(color: Colors.grey),),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Registration()));
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
