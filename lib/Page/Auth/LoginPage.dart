import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Page/Auth/Register.dart';
import 'package:fooddelivery/SplashScreen.dart';
import 'package:fooddelivery/Utills/Universalvariable.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textUsernameController = TextEditingController();
  TextEditingController textPasswordControllar = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        // reverse: true,

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
                  flex: 3,
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
              fillColor: Color(0xFFe7edeb),
              prefixIcon: Icon(CupertinoIcons.person_alt_circle),
              labelText: "Email"
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: textPasswordControllar,
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
              onPressed: (){},
            child: Text("Login"),
          ),
          SizedBox(height: 19,),
          InkWell(
            onTap: (){
              print("hiii");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
            },
            child: Text(
              "Don't Have any Account ?",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decorationColor: Colors.blue,
                decoration: TextDecoration.underline
              ),
            ),
          )
        ],
      ),
    );
  }
}
