
class Bookings {
  Bookings({
    String? id,
    String? age,
    String? date,
    String? notes,
    String? userPhone,
    String? userName,
    String? uid,
    String? hospitalName,
    String? hospitalId,
    int? nurnumber,
  }) {
    _id = id;
    _age = age;
    _date = date;
    _notes = notes;
    _userPhone = userPhone;
    _userName = userName;
    _uid = uid;
    _hospitalName = hospitalName;
    _hospitalId = hospitalId;
    _nurnumber = nurnumber;
  }

  Bookings.fromJson(dynamic json) {
    _id = json['id'];
    _age = json['age'];
    _notes = json['notes'];
    _userName = json['userName'];
    _userPhone = json['userPhone'];
    _date = json['date'];
    _uid = json['uid'];
    _hospitalName = json['hospitalName'];
    _hospitalId = json['hospitalId'];
    _nurnumber = json['nurnumber'];
  }

  String? _id;
  String? _age;
  String? _notes;
  String? _date;
  String? _userPhone;
  String? _userName;
  String? _uid;
  String? _hospitalName;
  String? _hospitalId;
  int? _nurnumber;

  String? get id => _id;
  String? get age => _age;
  String? get notes => _notes;
  String? get date => _date;
  String? get userPhone => _userPhone;
  String? get userName => _userName;
  String? get uid => _uid;
  String? get hospitalName => _hospitalName;
  String? get hospitalId => _hospitalId;
  int? get nurnumber => _nurnumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['age'] = _age;
    map['notes'] = _notes;
    map['date'] = _date;
    map['userPhone'] = _userPhone;
    map['userName'] = _userName;
    map['uid'] = _uid;
    map['hospitalName'] = _hospitalName;
    map['hospitalId'] = _hospitalId;
    map['nurnumber'] = _nurnumber;

    return map;
  }
}