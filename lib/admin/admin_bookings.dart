import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Home/booking.dart';
import '../Models/booking_model.dart';

class BookingList extends StatefulWidget {
  static const routeName = '/bookingList';
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Bookings> bookingList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchBookings();
  }

  void fetchBookings() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bookings");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Bookings p = Bookings.fromJson(event.snapshot.value);
      bookingList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text('قائمة الحجوزات'),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                itemCount: bookingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15, bottom: 10),
                              child: Container(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'اسم المستشفى: ${bookingList[index].hospitalName.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Cairo'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'اسم المستخدم : ${bookingList[index].userName.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Cairo'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'رقم الهاتف : ${bookingList[index].userPhone.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Cairo'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'عمر الطفل : ${bookingList[index].age.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Cairo'),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'تاريخ الحجز : ${bookingList[index].date.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Cairo'),
                                      ),
                                    ),
                                    
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'ملاحظات أضافية : ${bookingList[index].notes.toString()}',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Cairo'),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: ElevatedButton.icon(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        Colors.purple),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                18.0),
                                                        side: BorderSide(
                                                            color: Colors.blue
                                                                .shade200)))),
                                            onPressed: () async {
                                              User? user = FirebaseAuth
                                                  .instance.currentUser;
                                                  app = await Firebase.initializeApp();
                                              int? number =
                                                  bookingList[index].nurnumber;

                                              
                                                DatabaseReference bloodRef =
                                                    FirebaseDatabase.instance
                                                        .reference()
                                                        .child('hosbitals')
                                                        .child(
                                                            '${bookingList[index].hospitalId.toString()}');

                                                await bloodRef.update({
                                                  'nurnumber': number! + 1,
                                                });
                                              
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
                                              base
                                                  .child(bookingList[index]
                                                      .id
                                                      .toString())
                                                  .remove();
                                            },
                                            icon: Icon(Icons.assistant_outlined),
                                            label: Text(
                                              "انتهاء الحجز",
                                              style: TextStyle(fontSize: 20),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
