import 'dart:async';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Screens/FAQScreen.dart';
import 'package:balaji/Screens/TermsAndCondition.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class ManuHomeScreen extends StatefulWidget {
  @override
  _ManuHomeScreenState createState() => _ManuHomeScreenState();
}

class _ManuHomeScreenState extends State<ManuHomeScreen> {
  TextEditingController txtSearch = TextEditingController();
  bool isLoading = true;
  bool isTermLoading = false;
  List termsConList = [];
  List contactList = [];
  String txtName = "";
  String manufactureId = "";
  Completer<WebViewController> _webView = Completer<WebViewController>();

  getLocadata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      manufactureId = prefs.getString(Session.ManufacturerId);
    });
  }

  Icon actionIcon = Icon(
    Icons.search,
    //color: Colors.white,
  );

  //   // 'Dashboard'.tr().toString(),
  //   style: TextStyle(
  //       color: appPrimaryMaterialColor,
  //       //fontFamily: 'RobotoSlab',
  //       // color: Colors.black,
  //       fontSize: 17),

  @override
  Widget build(BuildContext context) {
    Widget appBarTitle = Container(
        child: Image.asset(
      "assets/BWD-white.png",
      fit: BoxFit.cover,
      height: 55,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backchange.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: appBarTitle,
          centerTitle: true,
          // backgroundColor: Colors.white,
          // iconTheme: new IconThemeData(color: appPrimaryMaterialColor),
          actions: <Widget>[],
        ),
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: WebView(
                initialUrl: "https://webnappmaker.in/Balaji/$manufactureId",
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onWebViewCreated: (WebViewController webViewController) {
                  _webView.complete(webViewController);
                },
              )),
          isLoading
              ? Center(
                  child: LoadingComponent(),
                )
              : Stack(),
        ],
      ),
    );
  }

  _termsCon() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isTermLoading = true;
        Services.PostForList(api_name: 'get_all_data_api/?tblName=tblsetting')
            .then((responseList) async {
          if (responseList.length > 0) {
            setState(() {
              isTermLoading = false;
              termsConList = responseList;
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

class AlertManuLogout extends StatefulWidget {
  @override
  _AlertManuLogoutState createState() => _AlertManuLogoutState();
}

class _AlertManuLogoutState extends State<AlertManuLogout> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Logout",
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            fontWeight: FontWeight.bold),
      ),
      content: new Text(
        "Are you sure want to Logout!!!",
        style: TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text(
            "Ok",
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

class ALertLang extends StatefulWidget {
  @override
  _ALertLangState createState() => _ALertLangState();
}

class _ALertLangState extends State<ALertLang> {
  String lang = 'p1';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Change Language",
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            fontWeight: FontWeight.bold),
      ),
      content: new Wrap(
        children: [
          Column(
            children: [
              Text(
                "Select Language",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600),
              ),
              ListTile(
                title: Column(
                  children: <Widget>[
                    Container(
                      height: 40,
                      child: RadioListTile(
                        activeColor: appPrimaryMaterialColor,
                        groupValue: lang,
                        title: Text('English',
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
                        title: Text('Hindi',
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
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        FlatButton(
          child: new Text(
            "Cancel",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        new FlatButton(
          child: new Text(
            "Ok",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
          ),
          onPressed: () async {},
        ),
      ],
    );
  }
}
