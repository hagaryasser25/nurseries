import 'package:nurseries/main.dart';
import 'package:nurseries/utils/data/data_helper.dart';
import 'cache_date.dart';

class Cache_Data_imp extends Cachedate{
  @override
  String getemail() {
if(prefs.containsKey(data_helper.EMAIL_KEY)){
  return prefs.getString(data_helper.EMAIL_KEY)?? "";
}else{
  return "";
}
  }
  @override
  void setemail(String email) {
    prefs.setString(data_helper.EMAIL_KEY, email);
  }

  @override
  String getpassword() {
if(prefs.containsKey(data_helper.PASSWORD_KEY)){
  return prefs.getString(data_helper.PASSWORD_KEY)??"";
}else{
  return "";
}
  }
  @override
  void setpassword(String password) {
    prefs.setString(data_helper.PASSWORD_KEY, password);
  }



  
}