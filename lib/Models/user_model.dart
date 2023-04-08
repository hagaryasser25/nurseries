import 'package:firebase_database/firebase_database.dart';

class Users {
  String? email;
  String? uid;
  String? phone;
  String? name;
  String? password;
  String? address;

  Users({this.email, this.uid, this.phone, this.name, this.password, this.address});

  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    uid = (dataSnapshot.child("uid").value.toString());
    email = (dataSnapshot.child("email").value.toString());
    name = (dataSnapshot.child("name").value.toString());
    phone = (dataSnapshot.child("phone").value.toString());
    password = (dataSnapshot.child("password").value.toString());
    address = (dataSnapshot.child("address").value.toString());
  }
}
