import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = Provider<SharedPrefHelper>((ref) {
  return SharedPrefHelper();
});

class SharedPrefHelper{
  late final SharedPreferences _sharedPref;

  Future init() async{
    _sharedPref = await SharedPreferences.getInstance();
  }

  Future<bool> setUserUID(String uid) async{
    return await _sharedPref.setString('uid', uid);
  }

  String? getUserUID(){
    return _sharedPref.getString('uid');
  }
}