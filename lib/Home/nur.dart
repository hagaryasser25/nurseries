import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nurseries/Home/booking.dart';
import 'package:nurseries/Home/nur_location.dart';
import 'package:nurseries/Models/hosbital.dart';

class NurDet extends StatefulWidget {
  final Hosbital hosList;

  const NurDet(this.hosList, {Key? key}) : super(key: key);

  @override
  State<NurDet> createState() => _NurDetState();
}

class _NurDetState extends State<NurDet> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text(
              "تفاصيل بيانات الحضانة",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 100),
                        child: Column(
                          children: [
                            Center(
                                child: Text(
                              " بيانات  الحضانة",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.orange,
                              ),
                            )),
                            Text(
                              " المستشفى ${widget.hosList.hosname}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "عدد الحضانات المتوفرة ${widget.hosList.nurnumber} ",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              " سعر الحضانة فى الليلة ${widget.hosList.nurprice}ج",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              " وصف الحضانة ${widget.hosList.nurdes}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 170,
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
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors
                                                        .blue.shade200)))),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Booking(
                                          name: '${widget.hosList.hosname}',
                                          id: '${widget.hosList.id}',
                                          number: widget.hosList.nurnumber!.toInt(),
                                        );
                                      }));
                                    },
                                    icon: Icon(Icons.assistant_outlined),
                                    label: Text(
                                      "حجز حضانة",
                                      style: TextStyle(fontSize: 20),
                                    )),
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
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors
                                                        .blue.shade200)))),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return PlaceLocation(
                                          latitude:
                                              '${widget.hosList.latitude}',
                                          longitude:
                                              '${widget.hosList.longitude}',
                                        );
                                      }));
                                    },
                                    icon: Icon(Icons.assistant_outlined),
                                    label: Text(
                                      "الموقع الجغرافى",
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
          ),
        ));
  }
}
