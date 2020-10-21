import 'dart:convert';
import 'dart:developer';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:ui';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class ProfileScreen extends StatelessWidget {
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
        builder: Builder(builder: (context) => ProfileScreen11()),
        autoPlay: true,
        autoPlayDelay: Duration(seconds: 3),
      ),
    );
  }
}

class ProfileScreen11 extends StatefulWidget {
  @override
  _ProfileScreen11State createState() => _ProfileScreen11State();
}

class _ProfileScreen11State extends State<ProfileScreen11> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtCName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();
  TextEditingController txtGstNumber = TextEditingController();
  String img, userName = "";
  final _formkey = new GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    _profile();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_one, _two]));
  }

  File _Image;

  Future getFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _Image = image;
      });
    }
  }

  Future getFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _Image = image;
      });
    }
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15, bottom: 10),
                      child: Text(
                        "Add Photo",
                        style: TextStyle(
                          fontSize: 22,
                          color: appPrimaryMaterialColor,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromCamera();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/camera.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Take Photo",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Divider(),
                    ),
                    GestureDetector(
                      onTap: () {
                        getFromGallery();
                        Navigator.of(context).pop();
                      },
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 15),
                          child: Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/gallery.png",
                                color: appPrimaryMaterialColor,
                              )),
                        ),
                        title: Text(
                          "Choose from Gallery",
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0, bottom: 5),
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 18,
                              color: appPrimaryMaterialColor,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  "assets/backarrow.png",
                  //color: appPrimaryMaterialColor,
                )),
          ),
          actions: [
            Showcase(
              key: _one,
              description: 'Tap to move towards Home!',
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/HomePage', (route) => false);
                },
                child: Container(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      "assets/home.png",
                      color: appPrimaryMaterialColor,
                    )),
              ),
            ),
            Showcase(
              key: _two,
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
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
          title: Text(
            'Edit_Profile'.tr().toString(),
            //"Edit Profile",
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17),
          ),
        ),
        body: Stack(
          //alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, left: 15, right: 15, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: GestureDetector(
                              onTap: () {
                                _settingModalBottomSheet();
                              },
                              child: _Image != null || img != ""
                                  ? _Image != null
                                      ? Container(
                                          height: 130.0,
                                          width: 150.0,
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.circular(30),

                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: appPrimaryMaterialColor[
                                                    600]),
                                            image: DecorationImage(
                                                image: FileImage(
                                                  _Image,
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        )
                                      : img != ""
                                          ? Container(
                                              height: 130.0,
                                              width: 150.0,
                                              decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.circular(30),

                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color:
                                                        appPrimaryMaterialColor[
                                                            600]),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      Image_URL + img,
                                                    ),
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                          : Container(
                                              height: 130.0,
                                              width: 150.0,
                                              decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.circular(30),

                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color:
                                                        appPrimaryMaterialColor[
                                                            600]),
                                                image: DecorationImage(
                                                    image: FileImage(
                                                      _Image,
                                                    ),
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                  : Container(
                                      height: 130.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(30),
                                        color: appPrimaryMaterialColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color:
                                                appPrimaryMaterialColor[600]),
                                      ),
                                      child: Center(
                                        widthFactor: 40.0,
                                        heightFactor: 40.0,
                                        child: Image.asset(
                                            "assets/051-user.png",
                                            color: Colors.white,
                                            width: 80.0,
                                            height: 80.0),
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              userName != null ? userName : "",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: appPrimaryMaterialColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          'Name'.tr().toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextFormField(
                          controller: txtName,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
                          validator: (name) {
                            if (name.length == 0) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'assets/051-user.png',
                                    color: appPrimaryMaterialColor,
                                  ),
                                ),
                              ),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          'Shop_Name'.tr().toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextFormField(
                          controller: txtCName,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
                          validator: (name) {
                            if (name.length == 0) {
                              return 'Please enter company name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.work,
                                    color: appPrimaryMaterialColor,
                                  ),
                                ),
                              ),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          children: [
                            Text(
                              'Email'.tr().toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              " (" + 'Optional'.tr().toString() + ")",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: appPrimaryMaterialColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextFormField(
                          controller: txtEmail,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
//                          validator: (email) {
//                            Pattern pattern =
//                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                            RegExp regex = new RegExp(pattern);
//                            print(email);
//                            if (email.isEmpty) {
//                              return 'Please enter email';
//                            } else {
//                              if (!regex.hasMatch(email))
//                                return 'Enter valid Email Address';
//                              else
//                                return null;
//                            }
//                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.all(11.0),
                                  child: Image.asset(
                                    'assets/026-email.png',
                                    color: appPrimaryMaterialColor,
                                  ),
                                ),
                              ),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          'GST_Number'.tr().toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextFormField(
                          controller: txtGstNumber,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
                          validator: (name) {
                            if (name.length == 0) {
                              return 'Please enter gst number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'assets/031-newspaper.png',
                                    color: appPrimaryMaterialColor,
                                  ),
                                ),
                              ),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          'Mobile_Number'.tr().toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextFormField(
                          controller: txtMobileNumber,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
                          enabled: false,
                          maxLength: 10,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 45,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.grey))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Image.asset(
                                    'assets/022-phone-call.png',
                                    color: appPrimaryMaterialColor,
                                  ),
                                ),
                              ),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: RaisedButton(
                            color: appPrimaryMaterialColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onPressed: () {
                              _updateProfile();
                              // Navigator.of(context).pushNamed('/Home');
                            },
                            child: Text(
                              'UPDATE_PROFILE'.tr().toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isLoading ? LoadingComponent() : Container()
          ],
        ));
  }

  _profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      txtName.text = prefs.getString(Session.CustomerName);
      userName = prefs.getString(Session.CustomerName);
      txtCName.text = prefs.getString(Session.CustomerCompanyName);
      txtEmail.text = prefs.getString(Session.CustomerEmailId);
      txtGstNumber.text = prefs.getString(Session.CustomerGSTNo);
      txtMobileNumber.text = prefs.getString(Session.CustomerPhoneNo);
      img = prefs.getString(Session.CustomerImage);
      print(img);
    });
  }

  _updateProfile() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          String filename = "";
          String filePath = "";
          File compressedFile;
          if (_Image != null) {
            ImageProperties properties =
                await FlutterNativeImage.getImageProperties(_Image.path);

            compressedFile = await FlutterNativeImage.compressImage(
              _Image.path,
              quality: 80,
              targetWidth: 600,
              targetHeight:
                  (properties.height * 600 / properties.width).round(),
            );

            filename = _Image.path.split('/').last;
            filePath = compressedFile.path;
          }
          SharedPreferences prefs = await SharedPreferences.getInstance();

          FormData body = FormData.fromMap({
            "CustomerId": prefs.getString(Session.CustomerId),
            "CustomerName": txtName.text,
            "CustomerCompanyName": txtCName.text,
            "CustomerEmailId": txtEmail.text,
            "CustomerGSTNo": txtGstNumber.text,
            "CustomerPhoneNo": txtMobileNumber.text,
            "CustomerImage": (filePath != null && filePath != '')
                ? await MultipartFile.fromFile(filePath,
                    filename: filename.toString())
                : null,
          }); //"key":"value"

          Services.PostForList(api_name: 'update_profile', body: body).then(
              (responseList) async {
            setState(() {
              isLoading = false;
            });
            if (responseList.length > 0) {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              setState(() {
                prefs.setString(Session.CustomerName, txtName.text);
                prefs.setString(Session.CustomerCompanyName, txtCName.text);
                prefs.setString(Session.CustomerEmailId, txtEmail.text);
                prefs.setString(Session.CustomerPhoneNo, txtMobileNumber.text);
                prefs.setString(
                    Session.CustomerImage, responseList[0]["CustomerImage"]);
              });
              Navigator.of(context).pushNamed('/HomePage');
              Fluttertoast.showToast(
                  msg: "Profile Updated Successfully",
                  gravity: ToastGravity.BOTTOM);
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
    } else {
      Fluttertoast.showToast(msg: "Please Fill the Field");
    }
  }
}
