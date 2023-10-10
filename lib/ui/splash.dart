import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'bottomnavigationar.dart';
import 'login.dart';

class SplasgScreen extends StatefulWidget {
  const SplasgScreen({super.key});

  @override
  State<SplasgScreen> createState() => _SplasgScreenState();
}

class _SplasgScreenState extends State<SplasgScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      autologin();
    });
  }

  String? isLoggedIn;
  void autologin() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getString("login");
    print(isLoggedIn);
    if (isLoggedIn != null) {
      if (isLoggedIn == "islogin") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return BottomNavigation(
            index: 0,
          );
        }));
        print("is true");
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
        print("is false");
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
      print("is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        "assets/images/processed-d0329553-44b7-4ef9-9544-c3fb9b91e6f2_uOHMkHvv (2).jpeg",
        fit: BoxFit.cover,
      ),
    );
  }
}
