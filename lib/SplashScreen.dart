import 'package:flutter/material.dart';
import 'dart:async';

import 'Page/Auth/LoginPage.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  AnimationController scaleController;
  Animation<double> scaleAnimation;
  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addStatusListener(
          (status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushReplacement(
            ThisIsFadeRoute(
              route: LoginPage(),
            ),
          );
          Timer(
            Duration(milliseconds: 300),
                () {
              scaleController.reset();
            },
          );
        }
      },
    );
    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    scaleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(seconds: 6),
                opacity: _opacity,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(

                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: Duration(seconds: 2),
                      height: _value ? 50 : 200,
                      width: _value ? 50 : 200,

                      child: Image.asset("assets/logos/logo.png"),
                    ),
                    SizedBox(height: 25,),
                    Text(
                      "India's Best Food Ordering Platform",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontSize: 25,

                      ),textAlign: TextAlign.center,
                    )
                  ],
                )
            ),

          ),
        ],
      ),
    );
  }
}
class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({this.page, this.route})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: route,
        ),
  );
}