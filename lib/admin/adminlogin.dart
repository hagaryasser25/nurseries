import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'adminhome.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  late String _email;

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController emailcon=TextEditingController();
  TextEditingController passwordcon=TextEditingController();
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
                        image: new ExactAssetImage('assets/images/admin.gif'),

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
                                "تسجيل دخول مدير النظام",
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
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange.shade500),

                                    shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(0),
                                            side: BorderSide(color: Colors.orange.shade500)))),
                                child: Text("سجل دخول",style: TextStyle(color: Colors.black),),
                                onPressed: () async {


                                  if(
                                  _formkey.currentState!.validate()){

if(emailcon.text=="admin@yahoo.com"&&passwordcon.text=="123456"){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminHome()));

}else{

    Fluttertoast.showToast(
        msg: "خطأ فى الايميل او كلمة المرور",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[600],
        textColor: Colors.white,
        fontSize: 16.0
    );

}
                                    //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));

                                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>customerHomePage()));

                                  }else{
                                    print("خطا");
                                  }

                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

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
