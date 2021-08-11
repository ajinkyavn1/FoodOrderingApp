import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fooddelivery/SplashScreen.dart';

import 'Page/Auth/LoginPage.dart';
import 'Utills/Universalvariable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery Application',
        theme: ThemeData(
          primarySwatch: UniversalVariables.orangeColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: SplashScreen(),
    );
  }
}


