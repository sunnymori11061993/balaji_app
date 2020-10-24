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

  Function goToTab;

  // List walhList = [];
  // bool iswalkLoading = true;

  _slide() async {
    String lang1;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lang1 = await prefs.getString(Session.langauge);
    if (lang1 == "p1") {
      log("trueeeeee");
      slides.add(
        new Slide(
          title: "",
          styleTitle: TextStyle(
            color: appPrimaryMaterialColor,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            //fontFamily: 'RobotoMono'
          ),
          description: " ",
          styleDescription: TextStyle(
            color: Colors.grey[700],
            fontSize: 16.0,
            //fontStyle: FontStyle.italic,
            // fontFamily: 'Raleway'
          ),
          pathImage: "assets/w1.png",
        ),
      );
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
          pathImage: "assets/w2.png",
        ),
      );
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
          pathImage: "assets/w3.png",
        ),
      );
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
          pathImage: "assets/w4.png",
        ),
      );
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
          pathImage: "assets/w5.png",
        ),
      );
    } else {
      log("falseeeee");
      slides.add(
        new Slide(
          title: "",
          styleTitle: TextStyle(
            color: appPrimaryMaterialColor,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            //fontFamily: 'RobotoMono'
          ),
          description: " ",
          styleDescription: TextStyle(
            color: Colors.grey[700],
            fontSize: 16.0,
            //fontStyle: FontStyle.italic,
            // fontFamily: 'Raleway'
          ),
          pathImage: "assets/wh1.png",
        ),
      );
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
          pathImage: "assets/wh2.png",
        ),
      );
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
          pathImage: "assets/wh3.png",
        ),
      );
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
          pathImage: "assets/wh4.png",
        ),
      );
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
          pathImage: "assets/wh5.png",
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    _slide();
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
            child: Image.asset(
              currentSlide.pathImage,
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
              // loadingBuilder: (context, child, loading) {
              //   if (loading == null) return child;
              //   return LoadingComponent();
              // },
            ),
          ),
        ),
      ));
    }
    return tabs;
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
              images: [
                AssetImage("assets/w1.png"),
                AssetImage("assets/w2.png"),
                AssetImage("assets/w3.png"),
                AssetImage("assets/w4.png"),
                AssetImage("assets/w5.png"),
              ],
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 30.0, right: 5, left: 10),
            //     child: FlatButton(
            //       onPressed: () {},
            //       child: Text(
            //         skip == 4 ? "" : "Skip",
            //         style: TextStyle(
            //             color: Color(0xFF9f782d),
            //             fontSize: 15,
            //             decoration: TextDecoration.none),
            //       ),
            //     ),
            //   ),
            // ),
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
    // Stack(
    //   children: [
    //     Container(
    //       height: MediaQuery.of(context).size.height,
    //       width: MediaQuery.of(context).size.width,
    //       child: ImageSlider(
    //         /// Shows the tab indicating circles at the bottom
    //         showTabIndicator: true,
    //
    //         /// Cutomize tab's colors
    //         tabIndicatorColor: Colors.grey,
    //
    //         /// Customize selected tab's colors
    //         tabIndicatorSelectedColor: Color(0xFF9f782d),
    //
    //         /// Height of the indicators from the bottom
    //         tabIndicatorHeight: 16,
    //
    //         /// Size of the tab indicator circles
    //         tabIndicatorSize: 12,
    //
    //         /// tabController for walkthrough or other implementations
    //         tabController: tabController,
    //
    //         /// Animation curves of sliding
    //         curve: Curves.fastOutSlowIn,
    //
    //         /// Width of the slider
    //         width: MediaQuery.of(context).size.width,
    //
    //         /// Height of the slider
    //         height: MediaQuery.of(context).size.width,
    //
    //         allowManualSlide: true,
    //
    //         /// Children in slideView to slide
    //         children: links.map((String link) {
    //           return Image.asset(
    //             link,
    //             width: MediaQuery.of(context).size.width,
    //             height: MediaQuery.of(context).size.height,
    //             fit: BoxFit.fill,
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //     Align(
    //       alignment: Alignment.topRight,
    //       child: Padding(
    //         padding: const EdgeInsets.only(top: 30.0, right: 5, left: 10),
    //         child: FlatButton(
    //           onPressed: () {
    //             tabController.animateTo(4);
    //           },
    //           child: Text(
    //             tabController.index == 4 ? "" : "Skip",
    //             style: TextStyle(
    //                 color: Color(0xFF9f782d),
    //                 fontSize: 15,
    //                 decoration: TextDecoration.none),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Align(
    //       alignment: Alignment.bottomRight,
    //       child: Padding(
    //         padding: const EdgeInsets.only(right: 15, bottom: 5),
    //         child: FlatButton(
    //           color: Color(0xFF9f782d),
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(20)),
    //           onPressed: () {
    //             Navigator.pushReplacementNamed(context, '/LoginScreen');
    //           },
    //           child: Text(
    //             "Done",
    //             style: TextStyle(
    //                 color: appPrimaryMaterialColor,
    //                 fontSize: 15,
    //                 decoration: TextDecoration.none),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // ));
  }
// IntroSlider(
// // List slides
// slides: this.slides,
//
// // Skip button
// // renderSkipBtn: this.renderSkipBtn(),
// // colorSkipBtn: Colors.white,
// // highlightColorSkipBtn: Colors.white,
//
// // Next button
// renderNextBtn: this.renderNextBtn(),
//
// // Done button
// renderDoneBtn: this.renderDoneBtn(),
// onDonePress: this.onDonePress,
// colorDoneBtn: Color(0xFF9f782d),
// highlightColorDoneBtn: Color(0xFF9f782d),
//
// // Dot indicator
// colorDot: Colors.grey,
// colorActiveDot: Color(0xFF9f782d),
// sizeDot: 13.0,
// //typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
// // typeDotAnimation:
//
// // Tabs
// listCustomTabs: this.renderListCustomTabs(),
// //backgroundColorAllSlides: appPrimaryMaterialColor,
//
// refFuncGoToTab: (refFunc) {
// this.goToTab = refFunc;
// },
//
// // Show or hide status bar
// shouldHideStatusBar: false,
//
// // On tab change completed
// onTabChangeCompleted: this.onTabChangeCompleted,
// ),
// _walkthrough() async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       iswalkLoading = true;
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       FormData body =
//           FormData.fromMap({"Language": prefs.getString(Session.langauge)});
//       Services.PostForList(api_name: 'getWalkthrough', body: body).then(
//           (responseList) async {
//         if (responseList.length > 0) {
//           setState(() {
//             iswalkLoading = false;
//             walhList = responseList;
//
//             //set "data" here to your variable
//           });
//           for (int i = 0; i < walhList.length; i++) {
//             slides.add(
//               new Slide(
//                 title: "",
//                 styleTitle: TextStyle(
//                   color: appPrimaryMaterialColor,
//                   fontSize: 25.0,
//                   fontWeight: FontWeight.bold,
//                   //fontFamily: 'RobotoMono'
//                 ),
//                 description: "",
//                 styleDescription: TextStyle(
//                   color: Colors.grey[700],
//                   fontSize: 16.0,
//                   //fontStyle: FontStyle.italic,
//                   // fontFamily: 'Raleway'
//                 ),
//                 pathImage: walhList[i]["WalkthroughImage"],
//               ),
//             );
//           }
//         } else {
//           setState(() {
//             iswalkLoading = false;
//           });
//           Fluttertoast.showToast(msg: "Data Not Found");
//           //show "data not found" in dialog
//         }
//       }, onError: (e) {
//         setState(() {
//           iswalkLoading = false;
//         });
//         print("error on call -> ${e.message}");
//         Fluttertoast.showToast(msg: "Something Went Wrong");
//       });
//     }
//   } on SocketException catch (_) {
//     Fluttertoast.showToast(msg: "No Internet Connection.");
//   }
// }
}
