class Hosbital {
  Hosbital({
    String? id,
    String? hosname,
    String? hosadress,
    int? nurnumber,
    String? nurdes,
    String? nurprice, 
    String? latitude,
    String? longitude,


  })
  {
    _id = id!;
    _hosname = hosname!;
    _hosadress = hosadress!;
    _nurdes=nurdes!;
    _nurprice=nurprice!;
    _nurnumber=nurnumber!;
    _latitude=latitude!;
    _longitude=longitude!;

  }

  Hosbital.fromJson(dynamic json) {
    _id = json['id'];
    _hosname = json['hosname'];
    _hosadress = json['hosadress'];
    _nurdes = json['nurdes'];
    _nurnumber = json['nurnumber'];
    _nurprice = json['nurprice'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];

  }
  String ? _id;
  String ? _hosname;
  String ? _hosadress;
  int ? _nurnumber;
  String ? _nurdes;
  String ? _nurprice;
  String ? _latitude;
  String ? _longitude;

  String? get id => _id;
  String? get hosname => _hosname;
  String? get hosadress => _hosadress;
  int? get nurnumber => _nurnumber;
  String? get nurdes => _nurdes;
  String? get nurprice => _nurprice;
  String? get latitude => _latitude;
  String? get longitude => _longitude;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['hosname'] = _hosname;
    map['hosadress'] = _hosadress;
    map['nurnumber'] = _nurnumber;
    map['nurdes'] = _nurdes;
    map['nurprice'] = _nurprice;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;

    return map;
  }

}