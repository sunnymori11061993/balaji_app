import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Screens/VerificationScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtLogin = TextEditingController();
  bool isLoading = false;

  String toggle = "User";

  final _formkey = new GlobalKey<FormState>();

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
              height: MediaQuery.of(context).padding.top + 50,
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              toggle = "User";
                            });
                          },
                          child: Container(
                            color: toggle == "User"
                                ? appPrimaryMaterialColor
                                : Colors.white,
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Text(
                                "User",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: toggle == "User"
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )),
                        Flexible(
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              toggle = "Manufacturer";
                            });
                          },
                          child: Container(
                            color: toggle == "Manufacturer"
                                ? appPrimaryMaterialColor
                                : Colors.white,
                            child: Center(
                              child: Text(
                                "Manufacturer",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: toggle == "Manufacturer"
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )),
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 13.0, right: 13, bottom: 10, top: 50),
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
            SizedBox(
              height: MediaQuery.of(context).padding.top + 15,
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "By continuing i accept the",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
            "type": toggle.toLowerCase()
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
                    loginType: toggle.toLowerCase(),
                    loginData: responseList[0],
                  ),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => new VerificationScreen(
                    loginType: toggle.toLowerCase(),
                    mobile: txtLogin.text,
                  ),
                ),
              );
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
