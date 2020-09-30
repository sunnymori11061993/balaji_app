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

class ManuHomeScreen extends StatefulWidget {
  @override
  _ManuHomeScreenState createState() => _ManuHomeScreenState();
}

class _ManuHomeScreenState extends State<ManuHomeScreen> {
  bool isLoading = true;
  bool isTermLoading = false;
  List termsConList = [];
  List contactList = [];
  String txtName = "";
  Completer<WebViewController> _webView = Completer<WebViewController>();

  Icon actionIcon = Icon(
    Icons.search,
    //color: Colors.white,
  );
  Widget appBarTitle = Text(
    "HOME",
    style: TextStyle(
        // color: appPrimaryMaterialColor,
        color: Colors.black,
        fontSize: 17),
  );
  TextEditingController txtSearch = TextEditingController();

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertManuLogout();
      },
    );
  }

  _showDialogLang(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return ALertLang();
      },
    );
  }

  userName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtName = prefs.getString(Session.ManufacturerName);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _termsCon();
    userName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appBarTitle,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: new IconThemeData(color: appPrimaryMaterialColor),
        actions: <Widget>[
          IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = Icon(
                      Icons.close,
                      //color: Colors.white,
                    );
                    this.appBarTitle = Container(
                      child: TextField(
                        controller: txtSearch,
                        style: TextStyle(
                            //color: Colors.white,
                            ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            prefixIcon: new Icon(
                              Icons.search,
                              color: appPrimaryMaterialColor,

                              //    color: Colors.white
                            ),
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            )),
                      ),
                    );
                  } else {
                    this.actionIcon = Icon(
                      Icons.search,
                      //color: Colors.white,
                    );

                    this.appBarTitle = Text(
                      "HOME",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    );
                    // txtSearch.clear();
                  }
                });
              }),
//          actionIcon.icon == Icons.close
//              ? Container()
//              : IconButton(
//                  icon: Icon(
//                    Icons.favorite_border,
//                  ),
//                  onPressed: () {
//                    Navigator.of(context).pushNamed('/Whishlist');
//                  },
//                ),
//          actionIcon.icon == Icons.close
//              ? Container()
//              : IconButton(
//                  icon: Icon(Icons.card_travel),
//                  onPressed: () {
//                    Navigator.of(context).pushNamed('/CartScreen');
//                  },
//                ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
//          padding: EdgeInsets.zero,
          children: <Widget>[
//            DrawerHeader(
//                child:),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/ManuProfileScreen');
              },
              child: Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: CircleAvatar(
                            radius: 40.0,
                            backgroundColor: appPrimaryMaterialColor,
                            foregroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Image.asset(
                                "assets/051-user.png",
                                color: Colors.white,
                                height: 40,
                              ),
                            )),
                      ),
                      Text(
                        "${txtName}",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 5),
                              child: Container(
                                  height: 14,
                                  width: 14,
                                  child: Image.asset(
                                    "assets/052-edit.png",
                                    color: Colors.grey,
                                  )),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 5.0),
                            //   child: Icon(
                            //     Icons.edit,
                            //     color: Colors.grey,
                            //     size: 14,
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/ManuHomeScreen');
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/home.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "Home",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/OrderHistoryScreen');
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/history.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "Order History",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //  Navigator.of(context).pushNamed('/ContactUs');
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (BuildContext context) =>
//                            new ()));
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/location.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "Add Addresses",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                _showDialogLang(context);
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/world-grid.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "Change Language",
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => new FAQScreen()));
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/f.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "FAQ",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Share.share('check out my website https://balaji.com',
                    subject: 'Look what An Amazing Clothes!');
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/share.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "Share",
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                //  Navigator.of(context).pushNamed('/ContactUs');

//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (BuildContext context) => new ContactUs(
//                      contactData: contactList[0],
//                    ),
//                  ),
//                );
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/phone-call.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "Contact Us",
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new TermsAndCondition(
                              termsConData: termsConList[0]
                                  ["SettingTermsConditionURL"],
                            )));
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/file.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "Terms & Conditions",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showDialog(context);
              },
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 4),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/logout.png",
                        color: appPrimaryMaterialColor,
                      )),
                ),
                title: Text(
                  "Logout",
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: WebView(
                initialUrl: "https://webnappmaker.in/Balaji/",
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
