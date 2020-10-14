import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Screens/TermsAndCondition.dart';
import 'package:balaji/Screens/VerificationScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtLogin = TextEditingController();
  bool isLoading = false;
  String msg, whatsapp;

  bool isTermLoading = false;
  List termsConList = [];

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

  final _formkey = new GlobalKey<FormState>();

  _showDialog(BuildContext context) {
    //show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Login",
            style: TextStyle(
                fontSize: 22,
                color: appPrimaryMaterialColor,
                fontWeight: FontWeight.bold),
          ),
          content: new Text(
            "You are not Register, please contact to your Admin!!!",
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          actions: <Widget>[
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
              onPressed: () {
                Navigator.of(context).pop();
                //launchwhatsapp(whatsappNumber: whatsapp, message: msg);
                Navigator.of(context).pushNamed('/ContactUs');
              },
            ),
          ],
        );
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

  @override
  void initState() {
    // TODO: implement initState
    _settingApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top +
                  MediaQuery.of(context).size.height / 11,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showDialogLang(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 5, right: 10, left: 10, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey[300])),
                        child: Text("Select Language",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              //color: appPrimaryMaterialColor,
                              // / fontWeight: FontWeight.w800
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 20,
                  ),
                  Text(
                    "SIGN IN / SIGN UP",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      children: <Widget>[
                        Text("Welcome to",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w400)),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text("Balaji",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: appPrimaryMaterialColor,
                                  //color: appPrimaryMaterialColor,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).padding.top + 20,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                child: Text(
                  "Enter Your Mobile Number to Continue",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 12, right: 12),
                child: Container(
                  child: TextFormField(
                    controller: txtLogin,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.black,
                    maxLength: 10,
                    validator: (phone) {
                      Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                      RegExp regExp = new RegExp(pattern);
                      if (phone.length == 0) {
                        return 'Please enter mobile number';
                      } else if (!regExp.hasMatch(phone)) {
                        return 'Please enter valid mobile number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        counterText: "",
                        contentPadding: const EdgeInsets.all(15),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 2, color: Colors.grey))),
                            child: Icon(
                              Icons.call,
                              color: appPrimaryMaterialColor,
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        hintText: "Enter 10 digit Mobile Number"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.top + 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 20.0),
            //   child: Center(
            //     child: Container(
            //         height: 35,
            //         width: MediaQuery.of(context).size.width - 100,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             border: Border.all(
            //               color: Colors.grey,
            //             )),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Flexible(
            //                 child: GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   toggle = "User";
            //                 });
            //               },
            //               child: Container(
            //                 color: toggle == "User"
            //                     ? appPrimaryMaterialColor
            //                     : Colors.white,
            //                 width: MediaQuery.of(context).size.width / 2,
            //                 child: Center(
            //                   child: Text(
            //                     "User",
            //                     style: TextStyle(
            //                         fontSize: 16,
            //                         color: toggle == "User"
            //                             ? Colors.white
            //                             : Colors.black,
            //                         fontWeight: FontWeight.w600),
            //                   ),
            //                 ),
            //               ),
            //             )),
            //             Flexible(
            //                 child: GestureDetector(
            //               onTap: () {
            //                 setState(() {
            //                   toggle = "Manufacturer";
            //                 });
            //               },
            //               child: Container(
            //                 color: toggle == "Manufacturer"
            //                     ? appPrimaryMaterialColor
            //                     : Colors.white,
            //                 child: Center(
            //                   child: Text(
            //                     "Manufacturer",
            //                     style: TextStyle(
            //                         fontSize: 16,
            //                         color: toggle == "Manufacturer"
            //                             ? Colors.white
            //                             : Colors.black,
            //                         fontWeight: FontWeight.w600),
            //                   ),
            //                 ),
            //               ),
            //             )),
            //           ],
            //         )),
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).padding.top + 15,
            // ),

            Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "By continuing you are accepting the",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new TermsAndCondition(
                                        termsConData: termsConList[0]
                                            ["SettingTermsConditionURL"],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            "Terms & Conditions",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 13.0, right: 13, bottom: 10, top: 40),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: RaisedButton(
                    color: appPrimaryMaterialColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {
                      if (isLoading == false) _login();
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text("CONTINUE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _settingApi() async {
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

  _login() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          FormData body = FormData.fromMap({
            "PhoneNo": txtLogin.text,
            // "type": toggle.toLowerCase()
          }); //"key":"value"
          Services.PostForList(api_name: 'OTP_login_api', body: body).then(
              (responseList) async {
            setState(() {
              isLoading = false;
            });
            if (responseList.length > 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => new VerificationScreen(
                    mobile: txtLogin.text,
                    // loginType: toggle.toLowerCase(),
                    loginData: responseList[0],
                    //loginType: responseList[0]["Type"],
                  ),
                ),
              );
            } else {
              _showDialog(context);
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => new VerificationScreen(
              //       loginType: toggle.toLowerCase(),
              //       mobile: txtLogin.text,
              //     ),
              //   ),
              // );
            }
          }, onError: (e) {
            setState(() {
              isLoading = false;
            });
            print("error on call -> ${e.message}");
            Fluttertoast.showToast(msg: "Something Went Wrong");
            //showMsg("something went wrong");
          });
        }
      } on SocketException catch (_) {
        Fluttertoast.showToast(msg: "No Internet Connection.");
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill the Field");
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
