import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: appPrimaryMaterialColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/Splash_Screen-02.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String MobileNumber = prefs.getString(Session.CustomerPhoneNo);
      String ManufactureMobileNo = prefs.getString(Session.ManufacturerPhoneNo);
      String Type = prefs.getString(Session.type);
      print(Type);
      print("Id-----------------$ManufactureMobileNo");

      if (Type == "retailer") {
        if (MobileNumber == null)
          Navigator.pushReplacementNamed(context, '/ChangeLanguage');
        else
          Navigator.pushReplacementNamed(context, '/HomePage');
      } else {
        if (ManufactureMobileNo == null)
          Navigator.pushReplacementNamed(context, '/ChangeLanguage');
        else
          Navigator.pushReplacementNamed(context, '/ManuHomePage');
      }
    });
  }
}
