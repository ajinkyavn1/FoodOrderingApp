import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Page/Auth/LoginPage.dart';
import 'package:fooddelivery/Page/HomePage.dart';
import 'package:fooddelivery/blocs/RegisterPageBloc.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_)=> RegisterPageBloc(),
      child: RegisterPageContent(),
    );
  }
}

class RegisterPageContent extends StatefulWidget {

  final FirebaseApp app;

  RegisterPageContent({this.app});
  @override
  _RegisterPageContentState createState() => _RegisterPageContentState();
}

class _RegisterPageContentState extends State<RegisterPageContent> {
  TextEditingController textUsernameController = TextEditingController();
  TextEditingController textPasswordControllar = TextEditingController();
  TextEditingController textMobaileControllar = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  RegisterPageBloc registerPageBloc;

  @override
  void dispose() {
    // TODO: implement dispose
    textMobaileControllar.dispose();
    textPasswordControllar.dispose();
    textUsernameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    registerPageBloc=Provider.of<RegisterPageBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
         reverse: true,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width,
              maxHeight: MediaQuery
                  .of(context)
                  .size
                  .height
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.orange[800],
              Colors.deepPurpleAccent[200]
            ],
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 24, horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/logo/logo.png", scale: 4,),
                        SizedBox(height: 15,),
                        Text(
                          "Welcome To World's Best Food Ordering Portal",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontSize: 15
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(135),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(135))
                    ),
                    child: Form(
                      key: _fromKey,
                      child: BuildForm(),
                    ),
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
  BuildForm() {
    return Padding(
      padding: EdgeInsets.all(60),
      child: Column(
        children: [
          TextFormField(
            controller: textUsernameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                filled: true,

                prefixIcon: Icon(CupertinoIcons.mail_solid),
                labelText: "Email"
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: textMobaileControllar,
            decoration: InputDecoration(
                filled: true,
                counterText: "",
                fillColor: Color(0xFFe7edeb),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                prefixIcon: Icon(CupertinoIcons.phone),
                labelText: "Mobile"
            ),
            keyboardType: TextInputType.number,
            maxLength: 10,
            maxLengthEnforced: true,
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: textPasswordControllar,
            obscuringCharacter: '*',
            obscureText: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFe7edeb),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                ),
                prefixIcon: Icon(CupertinoIcons.lock_fill),
                labelText: "Password"
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: ()=>registerPageBloc.validateFormAndRegister(_fromKey,textUsernameController.text,textPasswordControllar.text,textMobaileControllar.text)
              .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()))),
            child: Text("Register"),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
            child: Text(
              "Already Have any Account ?",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  decorationColor: Colors.blue,
                  decoration: TextDecoration.underline
              ),
            ),
          ),
          registerPageBloc.isRegisterPressed
              ? Center(
              child: CircularProgressIndicator())
              : Container(),
        ],
      ),
    );
  }
}
