class Parents {
  Parents({
    String? email,
    String? name,
    String? adress,
    String? password,
    String? Uid,
    String? phone,

  })
  {
    _name = name!;
    _phone = phone;
    _email = email;
    _password = password;
    _Uid = Uid;
    _adress = adress;

  }

  Parents.fromJson(dynamic json) {
    _email = json['email'];
    _name = json['name'];
    _adress = json['adress'];
    _phone = json['phone'];
    _password = json['password'];
    _Uid = json['Uid'];
  }
  String ? _email;
  String ? _name;
  String ? _adress;
  String ? _phone;
  String ? _password;
  String ? _Uid;


  String? get name => _name;
  String? get phone => _phone;
  String? get email => _email;
  String? get password => _password;
  String? get Uid => _Uid;
  String? get adress => _adress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['name'] = _name;
    map['adress'] = _adress;
    map['phone'] = _phone;
    map['password'] = _password;
    map['Uid'] = _Uid;
    return map;
  }

}