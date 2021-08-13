import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/Services/Firebase_Helper.dart';
import 'package:fooddelivery/Services/auth_Methods.dart';

class HomePageBloc with ChangeNotifier{
  Firebasehelper mfirebasehelper=Firebasehelper();
  AuthMethods mAuthmethods=AuthMethods();
  
}