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
      String Type = prefs.getString(Session.type);
      if (MobileNumber == null) {
        Navigator.pushReplacementNamed(context, '/WalkThroughScreen');
      } else {
        //Navigator.pushReplacementNamed(context, '/Home');
        if (Type == "retailer") {
          Navigator.pushReplacementNamed(context, '/Home');
        } else {
          Navigator.pushReplacementNamed(context, '/ManuHomeScreen');
        }
      }
    });
  }
}
