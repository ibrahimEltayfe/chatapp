import 'dart:developer';

import 'package:email_validator/email_validator.dart';

class Validation {
  String? emailValidator(String email){

    if(email.isEmpty) {
      return "من فضلك أدخل البريد الإلكترونى".toString();
    }else if(!EmailValidator.validate(email)){
        return "البريد الإلكترونى غير صالح";
    }

    return null;
  }

  String? registerPasswordValidator(String password){

    if(password.isEmpty) {
      return "من فضلك أدخل كلمة السر";
    }else if(password.length < 6) {
      return "من فضلك أدخل على الأقل 6 أرقام أو حروف";
    }
    return null;
  }

  String? nameValidator(String? name){

    if(name == null || name.isEmpty) {
      return "من فضلك أدخل الاسم";
    }else if(name.length>=25) {
      return "الاسم يجب أن لا يتعدى 25 حرف";
    }
    return null;
  }

  String? passwordValidator(String password){

    if(password.isEmpty){
      return "من فضلك أدخل كلمة السر";
    }else if(password.length < 6){
      return "أقل عدد لطول كلمة السر هو 6";
    }
    return null;

  }
/*
  Future<String?>? registerEmail(String email) async {

    String? errorMsg = _localEmailValidator(email);
    if(errorMsg != null){
      return errorMsg;
    }

    try {
      var isEmailInUse =
      await _auth.fetchSignInMethodsForEmail(email).then((value) => value);
      if (isEmailInUse.isNotEmpty) {
        return "This email already Registered";
      }
    } catch (e) {
      log(e.toString());
      return "something went wrong,please try again";
    }

    return null;
  }
*/

  /*
  Future<String?> loginEmail(String email) async {
    //} else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){

    String? errorMsg = _localEmailValidator(email);
    if(errorMsg != null){
      return errorMsg;
    }

    try {
      var isEmailInUse =
      await _auth.fetchSignInMethodsForEmail(email).then((value) => value);
      if (isEmailInUse.isEmpty) {
        return "This email is not exist";
      }
    } catch (e) {
      log(e.toString());
      return "something went wrong,please try again";
    }

    return null;
  }*/
}
