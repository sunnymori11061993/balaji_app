import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/AboutUsScreen.dart';
import 'package:balaji/Screens/Address%20Screen.dart';
import 'package:balaji/Screens/FAQScreen.dart';
import 'package:balaji/Screens/SearchingScreen.dart';
import 'package:balaji/Screens/TermsAndCondition.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
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
        builder: Builder(builder: (context) => SettingScreen11()),
        autoPlay: true,
        autoPlayDelay: Duration(seconds: 3),
      ),
    );
  }
}

class SettingScreen11 extends StatefulWidget {
  @override
  _SettingScreen11State createState() => _SettingScreen11State();
}

class _SettingScreen11State extends State<SettingScreen11> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  GlobalKey _five = GlobalKey();
  GlobalKey _six = GlobalKey();
  GlobalKey _seven = GlobalKey();
  GlobalKey _eight = GlobalKey();

  bool isSearching = false;
  bool searchImage = true;
  bool isTermLoading = true;
  List termsConList = [];
  String msg, whatsapp;
  String txtname = "";
  String img;
  String language;

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtname = prefs.getString(Session.CustomerName);
      img = prefs.getString(Session.CustomerImage);
    });
  }

  TextEditingController txtSearch = TextEditingController();

  _showDialogLang(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return ALertLang();
      },
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertboxLogout();
      },
    );
  }

  @override
  void initState() {
    _settingApi();
    _profile();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context).startShowCase(
            [_one, _two, _three, _four, _five, _six, _seven, _eight]));
  }

  void launchwhatsapp({
    @required String whatsappNumber,
    @required String message,
  }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$whatsappNumber/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?phone=$whatsappNumber&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    Widget appBarTitle = Text(
      'Settings'.tr().toString(),
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
                          const EdgeInsets.only(right: 15.0, left: 8, top: 18),
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
        body: isTermLoading == true
            ? LoadingComponent()
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      color: appPrimaryMaterialColor,
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 20, bottom: 20),
                          child: Image.asset(
                            "assets/BWD-white.png",

                            // color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   color: appPrimaryMaterialColor,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 60.0, bottom: 20),
                    //     child: Row(
                    //       children: [
                    //         img != ""
                    //             ? Container(
                    //                 height: 95.0,
                    //                 width: 120.0,
                    //                 decoration: BoxDecoration(
                    //                     border:
                    //                         Border.all(color: Colors.white),
                    //                     // borderRadius: BorderRadius.circular(30),
                    //                     //color: Colors.white,
                    //                     shape: BoxShape.circle,
                    //                     image: DecorationImage(
                    //                         image:
                    //                             NetworkImage(Image_URL + img),
                    //                         fit: BoxFit.cover)),
                    //               )
                    //             : Container(
                    //                 height: 95.0,
                    //                 width: 120.0,
                    //                 decoration: BoxDecoration(
                    //                   border: Border.all(color: Colors.white),
                    //                   // borderRadius: BorderRadius.circular(30),
                    //                   //color: Colors.white,
                    //                   color: appPrimaryMaterialColor,
                    //                   shape: BoxShape.circle,
                    //                 ),
                    //                 child: Center(
                    //                   widthFactor: 40.0,
                    //                   heightFactor: 40.0,
                    //                   child: Image.asset(
                    //                       "assets/051-user.png",
                    //                       color: Colors.white,
                    //                       width: 40.0,
                    //                       height: 40.0),
                    //                 ),
                    //               ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(top: 50.0),
                    //           child: Text(
                    //             txtname != null ? txtname : "",
                    //             style: TextStyle(
                    //               fontSize: 22,
                    //               color: Colors.white,
                    //               //fontWeight: FontWeight.w600
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, bottom: 20),
                              child: Text(
                                'Settings_And_Help'.tr().toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: appPrimaryMaterialColor,
                                  //fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            //Divider(),
                            GestureDetector(
                              onTap: () {
                                // Navigator.of(context).pop();
                                _showDialogLang(context);
                              },
                              child: Showcase(
                                key: _two,
                                description: 'Tap to change language!',
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 4),
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          "assets/world-grid.png",
                                          color: appPrimaryMaterialColor,
                                        )),
                                  ),
                                  title: Text(
                                    'drw_change_Lang'.tr().toString(),
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
                                            new FAQScreen()));
                              },
                              child: Showcase(
                                key: _three,
                                description: 'Tap to see FAQs!',
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 4),
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          "assets/f.png",
                                          color: appPrimaryMaterialColor,
                                        )),
                                  ),
                                  title: Text(
                                    'drw_faq'.tr().toString(),
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
                                Share.share(termsConList[0]["SettingShareLink"],
                                    subject: '');
                              },
                              child: Showcase(
                                key: _four,
                                description: 'Tap to share app link!',
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 4),
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          "assets/share.png",
                                          color: appPrimaryMaterialColor,
                                        )),
                                  ),
                                  title: Text(
                                    'drw_share'.tr().toString(),
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
                                // Navigator.of(context).pop();
                                //launchwhatsapp(whatsappNumber: whatsapp, message: msg);
                                Navigator.of(context).pushNamed('/ContactUs');
                              },
                              child: Showcase(
                                key: _five,
                                description: 'Tap to contact with us!',
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 4),
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          "assets/phone-call.png",
                                          color: appPrimaryMaterialColor,
                                        )),
                                  ),
                                  title: Text(
                                    'drw_Contact'.tr().toString(),
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
                                //  Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new AboutUsScreen(
                                              aboutData: termsConList[0]
                                                  ["SettingAboutUsURL"],
                                            )));
                              },
                              child: Showcase(
                                key: _six,
                                description: 'Tap to see about us!',
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 4),
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          "assets/information.png",
                                          color: appPrimaryMaterialColor,
                                        )),
                                  ),
                                  title: Text(
                                    'About_Us'.tr().toString(),
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
                                //  Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new TermsAndCondition(
                                              termsConData: termsConList[0]
                                                  ["SettingTermsConditionURL"],
                                            )));
                              },
                              child: Showcase(
                                key: _seven,
                                description: 'Tap to see terms & conditions!',
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 4),
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          "assets/file.png",
                                          color: appPrimaryMaterialColor,
                                        )),
                                  ),
                                  title: Text(
                                    'drw_Terms'.tr().toString(),
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
                                // Navigator.of(context).pop();
                                _showDialog(context);
                              },
                              child: Showcase(
                                key: _eight,
                                description: 'Tap to logout from balaji!',
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, left: 4),
                                    child: Container(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          "assets/logout.png",
                                          color: appPrimaryMaterialColor,
                                        )),
                                  ),
                                  title: Text(
                                    'drw_logout'.tr().toString(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  _settingApi() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isTermLoading = true;
        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body =
            FormData.fromMap({"Language": prefs.getString(Session.langauge)});
        Services.PostForList(api_name: 'getSetting', body: body).then(
            (responseList) async {
          if (responseList.length > 0) {
            setState(() {
              isTermLoading = false;
              termsConList = responseList;
              msg = responseList[0]["SettingWhatsAppMessage"];
              whatsapp = "+91" + responseList[0]["SettingWhatsAppNumber"];

              //set "data" here to your variable
            });
          } else {
            setState(() {
              isTermLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isTermLoading = false;
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

class ALertLang extends StatefulWidget {
  @override
  _ALertLangState createState() => _ALertLangState();
}

class _ALertLangState extends State<ALertLang> {
  String lang;

  _language() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String lang1;
      lang1 = prefs.getString(Session.langauge);
      lang1 != null ? lang = lang1 : lang = "p1";
    });
  }

  @override
  void initState() {
    _language();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        'Select_Language'.tr().toString(),
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          //fontWeight: FontWeight.bold
        ),
      ),
      content: Wrap(
        children: [
          ListTile(
            title: Column(
              children: <Widget>[
                Container(
                  height: 40,
                  child: RadioListTile(
                    activeColor: appPrimaryMaterialColor,
                    groupValue: lang,
                    title: Text('English'.tr().toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    value: 'p1',
                    onChanged: (val) {
                      setState(() {
                        lang = val;
                      });
                    },
                  ),
                ),
                Container(
                  height: 40,
                  child: RadioListTile(
                    activeColor: appPrimaryMaterialColor,
                    groupValue: lang,
                    title: Text('Hindi'.tr().toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    value: 'p2',
                    onChanged: (val) {
                      setState(() {
                        lang = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            'Cancel'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text(
            'Ok'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () async {
            if (lang == 'p1') {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.setString(Session.langauge, lang);
              });
              EasyLocalization.of(context).locale = Locale('en', 'US');
            } else {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.setString(Session.langauge, lang);
              });
              EasyLocalization.of(context).locale = Locale('hi', 'HI');
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class AlertboxLogout extends StatefulWidget {
  @override
  _AlertboxLogoutState createState() => _AlertboxLogoutState();
}

class _AlertboxLogoutState extends State<AlertboxLogout> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        'drw_logout'.tr().toString(),
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          // fontWeight: FontWeight.bold
        ),
      ),
      content: new Text(
        'Are_you_sure_logout'.tr().toString(),
        style: TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            'Cancel'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text(
            'Ok'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.pushNamedAndRemoveUntil(
                context, '/LoginScreen', (route) => false);
          },
        ),
      ],
    );
  }
}
