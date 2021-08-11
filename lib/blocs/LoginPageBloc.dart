import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/Services/auth_Methods.dart';

class LoginPageBloc with ChangeNotifier{
  AuthMethods mAuthMethods=AuthMethods();
  bool isLogedInPreesed=false;
  String validateEmail(String email){
    if(email.isEmpty&&EmailValidator.validate(email))
      {
        return "Please Enter Valid email";
      }
    return null;
  }
  String validatePassword(String password) {
    if (password.isEmpty && password.length<6) {
      return 'Password should atleast contain 6 character';
    }
    return null;
  }
  Future<void> validateFromAndLogin(GlobalKey<FormState> formkey,String username,String password)async{
    isLogedInPreesed=true;
    notifyListeners();
    if(formkey.currentState.validate()){
      await mAuthMethods.SignIn(username, password);
      isLogedInPreesed=false;
      notifyListeners();
    }
  }
}