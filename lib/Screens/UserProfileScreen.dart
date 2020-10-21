import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/Address%20Screen.dart';
import 'package:balaji/Screens/SearchingScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
        },
        builder: Builder(builder: (context) => UserProfileScreen1()),
        autoPlay: true,
        autoPlayDelay: Duration(seconds: 3),
      ),
    );
  }
}

class UserProfileScreen1 extends StatefulWidget {
  @override
  _UserProfileScreen1State createState() => _UserProfileScreen1State();
}

class _UserProfileScreen1State extends State<UserProfileScreen1> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  bool isSearching = true;
  String txtname = "";
  String img;
  TextEditingController txtSearch = TextEditingController();

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtname = prefs.getString(Session.CustomerName);
      img = prefs.getString(Session.CustomerImage);
    });
    print("-------------------" + img);
  }

  @override
  void initState() {
    _profile();
    _settingApi();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase([_one, _two, _three, _four]));
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    Widget appBarTitle = Text(
      'Profile'.tr().toString(),
      //"Profile",
      style: TextStyle(
          color: appPrimaryMaterialColor,
          //fontFamily: 'RobotoSlab',
          // color: Colors.black,
          fontSize: 17),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: appBarTitle,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: new IconThemeData(color: appPrimaryMaterialColor),
          actions: <Widget>[
            Showcase(
              key: _one,
              description: 'Tap to see your cart products!',
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/CartScreen');
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 15.0, left: 10, top: 18),
                      child: Container(
                          height: 20,
                          width: 20,
                          child: Image.asset(
                            "assets/shopping-cart.png",
                            color: appPrimaryMaterialColor,
                          )),
                    ),
                    provider.cartCount > 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 1.0, top: 13, right: 10),
                            child: CircleAvatar(
                              radius: 7.0,
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              child: Text(
                                provider.cartCount.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.0,
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
        body: isSearching == true
            ? LoadingComponent()
            : Stack(
                children: [
                  Container(
                    color: appPrimaryMaterialColor,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.8,
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 140.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/ProfileScreen');
                                },
                                child: Showcase(
                                  key: _two,
                                  description:
                                      'Tap to see your profile and update your profile!',
                                  child: ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, left: 4),
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                            "assets/edit.png",
                                            color: appPrimaryMaterialColor,
                                          )),
                                    ),
                                    title: Text(
                                      'drw_edit_profile'.tr().toString(),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Divider(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new AddressScreen()));
                                },
                                child: Showcase(
                                  key: _three,
                                  description:
                                      'Tap to manage your address- add ,update or delete!',
                                  child: ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, left: 4),
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                            "assets/location.png",
                                            color: appPrimaryMaterialColor,
                                          )),
                                    ),
                                    title: Text(
                                      'drw_manage_address'.tr().toString(),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Divider(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/HistoryScreen');
                                },
                                child: Showcase(
                                  key: _four,
                                  description:
                                      'Tap to see your ordered product history!',
                                  child: ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 10.0, left: 4),
                                      child: Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                            "assets/history.png",
                                            color: appPrimaryMaterialColor,
                                          )),
                                    ),
                                    title: Text(
                                      'drw_order_history'.tr().toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 65.0),
                    child: Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 3.3,
                        width: MediaQuery.of(context).size.width - 70,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            img != ""
                                ? Container(
                                    height: 180.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(30),
                                        //color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                appPrimaryMaterialColor[600]),
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(Image_URL + img),
                                            fit: BoxFit.cover)),
                                  )
                                : Container(
                                    height: 180.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(30),
                                      //color: Colors.white,
                                      color: appPrimaryMaterialColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: appPrimaryMaterialColor[600]),
                                    ),
                                    child: Center(
                                      widthFactor: 40.0,
                                      heightFactor: 40.0,
                                      child: Image.asset("assets/051-user.png",
                                          color: Colors.white,
                                          width: 80.0,
                                          height: 80.0),
                                    ),
                                  ),
                            Text(
                              txtname != null ? txtname : "",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: appPrimaryMaterialColor,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }

  _settingApi() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isSearching = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body =
            FormData.fromMap({"Language": prefs.getString(Session.langauge)});
        Services.PostForList(api_name: 'getSetting', body: body).then(
            (responseList) async {
          if (responseList.length > 0) {
            setState(() {
              isSearching = false;
            });
          } else {
            setState(() {
              isSearching = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isSearching = false;
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
