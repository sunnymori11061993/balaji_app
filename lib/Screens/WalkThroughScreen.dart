import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_slider/image_slider.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen>
    with SingleTickerProviderStateMixin {
  List<Slide> slides = [];

  int skip;
  TabController tabController;

  List imgEng = [
    AssetImage("assets/w1.png"),
    AssetImage("assets/w2.png"),
    AssetImage("assets/w3.png"),
    AssetImage("assets/w4.png"),
    AssetImage("assets/w5.png"),
  ];

  List imgHindi = [
    AssetImage("assets/wh1.png"),
    AssetImage("assets/wh2.png"),
    AssetImage("assets/wh3.png"),
    AssetImage("assets/wh4.png"),
    AssetImage("assets/wh5.png"),
  ];
  Function goToTab;

  String lang1;

  _slide() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lang1 = prefs.getString(Session.langauge);
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    _slide();
  }

  Widget renderSkipBtn() {
    return Text(
      "Skip",
      style: TextStyle(color: appPrimaryMaterialColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(tabController.index);
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backchange.png"), fit: BoxFit.cover)),
        child: Stack(
          children: [
            Carousel(
              boxFit: BoxFit.cover,
              autoplay: false,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 6.0,
              dotIncreasedColor: Color(0xFF9f782d),
              dotBgColor: Colors.transparent,
              dotPosition: DotPosition.bottomCenter,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 7.0,
              dotColor: Colors.grey,
              onImageChange: (a, b) {
                log(a.toString());
                log(b.toString());
                setState(() {
                  skip = b;
                });
              },
              images: lang1 == "p1" ? imgEng : imgHindi,
            ),
            skip == 4
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, bottom: 5),
                      child: FlatButton(
                        color: Color(0xFF9f782d),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/LoginScreen');
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}
