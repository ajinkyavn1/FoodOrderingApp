
import 'dart:async';
import 'dart:async';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fooddelivery/Model/UserData.dart';

class AuthMethods{
  //code is Used to initialized Database
  final FirebaseAuth    _auth=FirebaseAuth.instance;
  static final FirebaseDatabase _database=FirebaseDatabase.instance;
  static final DatabaseReference _userRefrence=_database.reference().child("Users");
  //code use for get currunt user
  Future<FirebaseUser> getCurruntUser()async{
    FirebaseUser user;
    user=await _auth.currentUser();
    return user;
  }
  //signin user
Future<FirebaseUser> SignIn(String email, String password )async{
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      assert(user!=null);
      assert(await user.getIdToken()!=null);
    FirebaseUser curruntuser=await _auth.currentUser();
      assert(user.uid==curruntuser.uid);
      print("Sign in Successfully done $user");
      return user;
}
Future<FirebaseUser> SignUp(String email,String password,String mobile)async{
    final AuthResult user=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    assert(user!=null);
    print("called before token");
    assert(await user.user.getIdToken()!=null);
    print("called  after token");
    await addDataDb(user.user,email,password,mobile);
    print("called after Db saved token");
    return user.user;
}
Future<Void> addDataDb(FirebaseUser user,String email,String password,String mobile)async{
    print("called in addd DB");
    Users users=Users(user.uid,user.email, mobile,password);

   _userRefrence.child(user.uid).set(users.toMap(users));
    print (users.toMap(users));
}
}