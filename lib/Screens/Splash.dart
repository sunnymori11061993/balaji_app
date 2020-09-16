import 'dart:async';

import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        body: Stack(
          children: <Widget>[
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SvgPicture.asset(
                  'assets/Splash.svg',
                  fit: BoxFit.cover,
                )),
            /* Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 0,
                child: Image.asset("assets/Side1.png"),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 0,
                child: Image.asset("assets/Side3.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Image.asset("assets/Side2.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                child: Image.asset("assets/Side2.png"),
              ),
            ),*/
            Center(
              child: Container(
                child: Image.asset("assets/balajiLogo.png"),
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String MobileNumber = prefs.getString(Session.CustomerPhoneNo);
      if (MobileNumber == null) {
        Navigator.pushReplacementNamed(context, '/LoginScreen');
      } else {
        Navigator.pushReplacementNamed(context, '/Home');
      }
    });
  }
}
