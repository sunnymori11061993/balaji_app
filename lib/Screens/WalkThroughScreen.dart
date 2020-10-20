import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  List<Slide> slides = new List();

  Function goToTab;
  List walhList = [];
  bool iswalkLoading = true;

  @override
  void initState() {
    super.initState();
    _walkthrough();

    // slides.add(
    //   new Slide(
    //     title: "",
    //     styleTitle: TextStyle(
    //       color: appPrimaryMaterialColor,
    //       fontSize: 25.0,
    //       fontWeight: FontWeight.bold,
    //       //fontFamily: 'RobotoMono'
    //     ),
    //     description: " ",
    //     styleDescription: TextStyle(
    //       color: Colors.grey[700],
    //       fontSize: 16.0,
    //       //fontStyle: FontStyle.italic,
    //       // fontFamily: 'Raleway'
    //     ),
    //     pathImage: "assets/2.png",
    //   ),
    // );
    // slides.add(
    //   new Slide(
    //     title: "",
    //     styleTitle: TextStyle(
    //       color: appPrimaryMaterialColor,
    //       fontSize: 25.0,
    //       fontWeight: FontWeight.bold,
    //       //fontFamily: 'RobotoMono'
    //     ),
    //     description: "",
    //     styleDescription: TextStyle(
    //       color: Colors.grey[700],
    //       fontSize: 16.0,
    //       //fontStyle: FontStyle.italic,
    //       // fontFamily: 'Raleway'
    //     ),
    //     pathImage: "assets/3.png",
    //   ),
    // );
    // slides.add(
    //   new Slide(
    //     title: "",
    //     styleTitle: TextStyle(
    //       color: appPrimaryMaterialColor,
    //       fontSize: 25.0,
    //       fontWeight: FontWeight.bold,
    //       //fontFamily: 'RobotoMono'
    //     ),
    //     description: "",
    //     styleDescription: TextStyle(
    //       color: Colors.grey[700],
    //       fontSize: 16.0,
    //       //fontStyle: FontStyle.italic,
    //       // fontFamily: 'Raleway'
    //     ),
    //     pathImage: "assets/4.png",
    //   ),
    // );
    // slides.add(
    //   new Slide(
    //     title: "",
    //     styleTitle: TextStyle(
    //       color: appPrimaryMaterialColor,
    //       fontSize: 25.0,
    //       fontWeight: FontWeight.bold,
    //       //fontFamily: 'RobotoMono'
    //     ),
    //     description: "",
    //     styleDescription: TextStyle(
    //       color: Colors.grey[700],
    //       fontSize: 16.0,
    //       //fontStyle: FontStyle.italic,
    //       // fontFamily: 'Raleway'
    //     ),
    //     pathImage: "assets/5.png",
    //   ),
    // );
  }

  void onDonePress() {
    //login Screen
    Navigator.pushReplacementNamed(context, '/LoginScreen');
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: appPrimaryMaterialColor,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Text(
      "Done",
      style: TextStyle(color: appPrimaryMaterialColor),
    );

//      Icon(
//      Icons.done,
//      color: appPrimaryMaterialColor,
//    );
  }

  Widget renderSkipBtn() {
    return Text(
      "Skip",
      style: TextStyle(color: appPrimaryMaterialColor),
    );

//      Icon(
//      Icons.skip_next,
//      color: appPrimaryMaterialColor,
//    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: GestureDetector(
            child: Image.network(
              Image_URL + currentSlide.pathImage,
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loading) {
                if (loading == null) return child;
                return LoadingComponent();
              },
            ),
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return iswalkLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
            ),
          )
        : IntroSlider(
            // List slides
            slides: this.slides,

            // Skip button
            renderSkipBtn: this.renderSkipBtn(),
            colorSkipBtn: Colors.white,
            highlightColorSkipBtn: Colors.white,

            // Next button
            renderNextBtn: this.renderNextBtn(),

            // Done button
            renderDoneBtn: this.renderDoneBtn(),
            onDonePress: this.onDonePress,
            colorDoneBtn: Colors.white,
            highlightColorDoneBtn: Colors.white,

            // Dot indicator
            colorDot: Colors.grey,
            colorActiveDot: Colors.white,
            sizeDot: 13.0,
            //typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
            // typeDotAnimation:

            // Tabs
            listCustomTabs: this.renderListCustomTabs(),
            backgroundColorAllSlides: appPrimaryMaterialColor,
            refFuncGoToTab: (refFunc) {
              this.goToTab = refFunc;
            },

            // Show or hide status bar
            shouldHideStatusBar: false,

            // On tab change completed
            onTabChangeCompleted: this.onTabChangeCompleted,
          );
  }

  _walkthrough() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        iswalkLoading = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body =
            FormData.fromMap({"Language": prefs.getString(Session.langauge)});
        Services.PostForList(api_name: 'getWalkthrough', body: body).then(
            (responseList) async {
          if (responseList.length > 0) {
            setState(() {
              iswalkLoading = false;
              walhList = responseList;

              //set "data" here to your variable
            });
            for (int i = 0; i < walhList.length; i++) {
              slides.add(
                new Slide(
                  title: "",
                  styleTitle: TextStyle(
                    color: appPrimaryMaterialColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    //fontFamily: 'RobotoMono'
                  ),
                  description: "",
                  styleDescription: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16.0,
                    //fontStyle: FontStyle.italic,
                    // fontFamily: 'Raleway'
                  ),
                  pathImage: walhList[i]["WalkthroughImage"],
                ),
              );
            }
          } else {
            setState(() {
              iswalkLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            iswalkLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }
}
