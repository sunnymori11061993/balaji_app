import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  List<Slide> slides = new List();

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Online Shopping",
        styleTitle: TextStyle(
          color: appPrimaryMaterialColor,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          //fontFamily: 'RobotoMono'
        ),
        description:
            "If you would like to experience the best of online shopping for men, women and kids in India, you are at the right place.Online Shopping Site for Fashion & Lifestyle in India.",
        styleDescription: TextStyle(
          color: Colors.grey[700],
          fontSize: 16.0,
          //fontStyle: FontStyle.italic,
          // fontFamily: 'Raleway'
        ),
        pathImage: "assets/intro1.jpeg",
      ),
    );
    slides.add(
      new Slide(
        title: "Buy Products",
        styleTitle: TextStyle(
          color: appPrimaryMaterialColor,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          //fontFamily: 'RobotoMono'
        ),
        description:
            "  Buy Dresses, Clothing, Kurta and lifestyle products for women & men.Our online store brings you the latest in designer products straight out of fashion houses.",
        styleDescription: TextStyle(
          color: Colors.grey[700],
          fontSize: 16.0,
          //fontStyle: FontStyle.italic,
          // fontFamily: 'Raleway'
        ),
        pathImage: "assets/intro2.jpeg",
      ),
    );
    slides.add(
      new Slide(
        title: "Online Payment",
        styleTitle: TextStyle(
          color: appPrimaryMaterialColor,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          //fontFamily: 'RobotoMono'
        ),
        description:
            "Online payment refers to money that is exchanged electronically.You can shop online at Balaji from the comfort of your Home ",
        styleDescription: TextStyle(
          color: Colors.grey[700],
          fontSize: 16.0,
          //fontStyle: FontStyle.italic,
          // fontFamily: 'Raleway'
        ),
        pathImage: "assets/intro3.jpeg",
      ),
    );
    slides.add(
      new Slide(
        title: "Delivering Products",
        styleTitle: TextStyle(
          color: appPrimaryMaterialColor,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          //fontFamily: 'RobotoMono'
        ),
        description:
            "You can shop online at Balaji from the comfort of your Home and get your favourites delivered right to your doorstep.",
        styleDescription: TextStyle(
          color: Colors.grey[700],
          fontSize: 16.0,
          //fontStyle: FontStyle.italic,
          // fontFamily: 'Raleway'
        ),
        pathImage: "assets/intro4.jpeg",
      ),
    );
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
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 0.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
//                width: MediaQuery.of(context).size.width,
//                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                height: 500.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 00.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: appPrimaryMaterialColor[100],
      highlightColorSkipBtn: appPrimaryMaterialColor,

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: appPrimaryMaterialColor[100],
      highlightColorDoneBtn: appPrimaryMaterialColor,

      // Dot indicator
      colorDot: appPrimaryMaterialColor[100],
      colorActiveDot: appPrimaryMaterialColor,
      sizeDot: 13.0,
      //typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      // typeDotAnimation:

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Show or hide status bar
      shouldHideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
