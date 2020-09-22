import 'dart:io';
import 'dart:math';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Screens/RegistrationScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  var mobile, loginData,loginType;

  VerificationScreen({this.mobile, this.loginData,this.loginType});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isLoading = false;
  String rndNumber;
  TextEditingController txtOTP = new TextEditingController();

  @override
  void initState() {
    _sendOTP();
  }

  saveDataToSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Session.CustomerId, widget.loginData["CustomerId"]);
    await prefs.setString(
        Session.CustomerName, widget.loginData["CustomerName"]);
    await prefs.setString(
        Session.CustomerCompanyName, widget.loginData["CustomerCompanyName"]);
    await prefs.setString(
        Session.CustomerEmailId, widget.loginData["CustomerEmailId"]);

    await prefs.setString(
        Session.CustomerPhoneNo, widget.loginData["CustomerPhoneNo"]);
    //  prefs.setString(Session.v, responseList[0]["__v"].toString());
    Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: appPrimaryMaterialColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top +
                  MediaQuery.of(context).size.height / 25,
            ),
            Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Enter Verification Code",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text("We have sent the verification code on",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("${widget.mobile}"),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 80),
                  child: PinCodeTextField(
                    controller: txtOTP,
                    autofocus: false,
                    wrapAlignment: WrapAlignment.center,
                    highlight: true,
                    pinBoxHeight: 50,
                    pinBoxWidth: 50,
                    highlightColor: Colors.grey,
                    defaultBorderColor: Colors.grey,
                    hasTextBorderColor: Colors.black,
                    maxLength: 4,
                    pinBoxDecoration:
                        ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                    pinTextStyle: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Text("Enter verification code you received on SMS",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: RaisedButton(
                      color: appPrimaryMaterialColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () {
                        rndNumber == txtOTP.text
                            ? widget.loginData == null
                                ? Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext contex) =>
                                            RegistrationScreen(
                                              signupType: widget.loginType,
                                              Mobile: widget.mobile,
                                            )),
                                    (route) => false)
                                : saveDataToSession()
                            : Fluttertoast.showToast(msg: "OTP is wrong");
                      },
                      child: Text(
                        "VERIFY",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: Text("Resend PIN 00:30",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _sendOTP() async {
    var rnd = new Random();
    setState(() {
      rndNumber = "";
    });

    for (var i = 0; i < 4; i++) {
      rndNumber = rndNumber + rnd.nextInt(9).toString();
    }
    print(rndNumber);

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        FormData body = FormData.fromMap({
          "PhoneNo": "${widget.mobile}",
          "OTP": "$rndNumber",
        }); //"key":"value"
        Services.postForSave(apiname: 'SMS_API', body: body).then(
            (response) async {
          if (response.IsSuccess == true && response.Data == "1") {
            Fluttertoast.showToast(
                msg: "OTP send successfully", gravity: ToastGravity.BOTTOM);
          }

          setState(() {
            isLoading = false;
          });
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
  }
}
