import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Screens/RegistrationScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  var mobile, loginData;
  Function onLoginSuccess;

  VerificationScreen({this.mobile, this.loginData, this.onLoginSuccess});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool isLoading = false;
  bool isVerifyLoading = false;
  String rndNumber;
  TextEditingController txtOTP = new TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _verificationId;

  @override
  void initState() {
    _onVerifyCode();
  }

  void _onVerifyCode() async {
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      setState(() {
        isVerifyLoading = true;
      });
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        setState(() {
          isVerifyLoading = false;
        });
        if (value.user != null) {
          print(value.user);

          if (widget.loginData != null) {
            saveDataToSession();
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => RegistrationScreen(
                          Mobile: widget.mobile,
                        )),
                (route) => false);
          }
        } else {
          Fluttertoast.showToast(msg: "Error validating OTP, try again");
        }
      }).catchError((error) {
        Fluttertoast.showToast(msg: " $error");
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Fluttertoast.showToast(msg: authException.message);
    };
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91${widget.mobile}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    setState(() {
      isLoading = true;
    });
    AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: txtOTP.text);
    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential value) {
      setState(() {
        isLoading = false;
      });
      if (value.user != null) {
        print(value.user);
        saveDataToSession();
      } else {
        Fluttertoast.showToast(msg: "Invalid OTP");
      }
    }).catchError((error) {
      Fluttertoast.showToast(msg: "$error Something went wrong");
    });
  }

  saveDataToSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //  prefs.setString(Session.v, responseList[0]["__v"].toString());
    print(widget.loginData["Type"]);
    if (widget.loginData["Type"] == "retailer") {
      await prefs.setString(Session.CustomerId, widget.loginData["CustomerId"]);
      await prefs.setString(
          Session.CustomerGSTNo, widget.loginData["CustomerGSTNo"]);
      await prefs.setString(Session.type, widget.loginData["Type"]);
      await prefs.setString(
          Session.CustomerName, widget.loginData["CustomerName"]);
      await prefs.setString(
          Session.CustomerCompanyName, widget.loginData["CustomerCompanyName"]);
      await prefs.setString(
          Session.CustomerEmailId, widget.loginData["CustomerEmailId"]);
      await prefs.setString(
          Session.CustomerImage, widget.loginData["CustomerImage"]);

      await prefs.setString(
          Session.CustomerPhoneNo, widget.loginData["CustomerPhoneNo"]);
      Navigator.pushNamedAndRemoveUntil(context, '/HomePage', (route) => false);
    } else {
      await prefs.setString(
          Session.ManufacturerId, widget.loginData["ManufacturerId"]);
      await prefs.setString(
          Session.ManufacturerGSTNo, widget.loginData["ManufacturerGSTNo"]);
      await prefs.setString(Session.type, widget.loginData["Type"]);
      await prefs.setString(
          Session.ManufacturerName, widget.loginData["ManufacturerName"]);
      await prefs.setString(Session.ManufacturerCompanyName,
          widget.loginData["ManufacturerCompanyName"]);
      await prefs.setString(
          Session.ManufacturerEmailId, widget.loginData["ManufacturerEmailId"]);
      await prefs.setString(
          Session.ManuCustomerImage, widget.loginData["ManufacturerImage"]);
      await prefs.setString(
          Session.ManufacturerPhoneNo, widget.loginData["ManufacturerPhoneNo"]);
      Navigator.pushNamedAndRemoveUntil(
          context, '/ManuHomePage', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: Padding(
      //     padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
      //     child: GestureDetector(
      //         onTap: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: Image.asset(
      //           "assets/backarrow.png",
      //           //color: appPrimaryMaterialColor,
      //         )),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backchange.png"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).padding.top + 30),
              SizedBox(
                height: MediaQuery.of(context).padding.top +
                    MediaQuery.of(context).size.height / 25,
              ),
              Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'enter_ver_code'.tr().toString(),
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF9f782d),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text('code_send'.tr().toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      "${widget.mobile}",
                      style: TextStyle(color: Colors.white),
                    ),
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
                      pinBoxHeight: 38,
                      pinBoxWidth: 38,
                      highlightColor: Colors.white,
                      defaultBorderColor: Colors.white,
                      pinBoxRadius: 5,
                      hasTextBorderColor: Color(0xFF9f782d),
                      maxLength: 6,
                      pinBoxDecoration:
                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle:
                          TextStyle(fontSize: 17, color: Color(0xFF9f782d)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text('enter_code'.tr().toString(),
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
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
                        color: Color(0xFF9f782d),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: () {
                          if (txtOTP.text.length == 6) {
                            _onFormSubmitted();
                          } else {
                            Fluttertoast.showToast(msg: "OTP is wrong");
                          }
                        },
                        child: Text(
                          'VERIFY'.tr().toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _onVerifyCode();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: isVerifyLoading == true
                          ? LoadingComponent()
                          : Text('Resend_OTP'.tr().toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF9f782d),
                                  fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // _sendOTP() async {
  //   var rnd = new Random();
  //   setState(() {
  //     rndNumber = "";
  //   });
  //
  //   for (var i = 0; i < 4; i++) {
  //     rndNumber = rndNumber + rnd.nextInt(9).toString();
  //   }
  //   print(rndNumber);
  //
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       FormData body = FormData.fromMap({
  //         "PhoneNo": "${widget.mobile}",
  //         "OTP": "$rndNumber",
  //       }); //"key":"value"
  //       Services.postForSave(apiname: 'SMS_API', body: body).then(
  //           (response) async {
  //         if (response.IsSuccess == true && response.Data == "1") {
  //           Fluttertoast.showToast(
  //               msg: "OTP send successfully", gravity: ToastGravity.BOTTOM);
  //         }
  //
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }, onError: (e) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         print("error on call -> ${e.message}");
  //         Fluttertoast.showToast(msg: "Something Went Wrong");
  //         //showMsg("something went wrong");
  //       });
  //     }
  //   } on SocketException catch (_) {
  //     Fluttertoast.showToast(msg: "No Internet Connection.");
  //   }
  // }
}
