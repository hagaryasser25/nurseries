import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Cache_data/cache_date_imp.dart';
import 'Home/Login.dart';
import 'Home/home.dart';
import 'admin/adminlogin.dart';

class OpenScreen extends StatefulWidget {
  const OpenScreen({Key? key}) : super(key: key);

  @override
  State<OpenScreen> createState() => _OpenScreenState();

}

class _OpenScreenState extends State<OpenScreen> {
  Cache_Data_imp cacheDataImpHelper=Cache_Data_imp();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginCache();
  }

void loginCache()async{

  String email=cacheDataImpHelper.getemail();
  String password=cacheDataImpHelper.getpassword();
  if(email.isEmpty && password.isEmpty)
  {
    print("null");
  }else{
    print(email);
    print(password);

    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString().trim(),
        password: password.toString().trim()
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));

  }

}

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  height: 300,
                  child: Image.asset(
                    "assets/images/hdanat.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Center(
                    child: Text(
                      "تطبيق لعرض و حجز حضانات الاطفال",
                      style: TextStyle(fontSize: 25, fontFamily: "Yel"),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black)))),
                    child: Text(
                      "  سجل دخول كولى أمر",
                      style: TextStyle(color: Colors.amber, fontSize: 25),
                    ),
                    onPressed: ()  {
                     Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LoginScreen()));

                    },
                  ),
                ),
              ),
              TextButton(onPressed: () {
               // Navigator.of(context).push(MaterialPageRoute(builder:(context)=>RegistrationScreen()));

              },
                  child: Text("اذا كان ليس لديك حساب انشىء حساب",style: TextStyle(color: Colors.grey),)
              ),
              TextButton(onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(builder:(context)=>AdminLogin()));

              },
                  child: Text("منطقة مدير النظام",style: TextStyle(color: Colors.grey),)
              ),
            ],
          ),
        )
    );
  }
}
