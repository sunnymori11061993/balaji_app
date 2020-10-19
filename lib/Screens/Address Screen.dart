import 'dart:io';

import 'package:balaji/Common/ClassList.dart';
import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/AddressComponent.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/Home.dart';
import 'package:balaji/Screens/SettingScreen.dart';
import 'package:balaji/Screens/UserProfileScreen.dart';
import 'package:balaji/Screens/Whishlist.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertFloating(onRefresh: () {
          _getAddress();
        });
      },
    );
  }

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Whishlist(),
    UserProfileScreen(),
    SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isDisplayLoading = true;
  List getAddressList = [];

  @override
  void initState() {
    // TODO: implement initState
    _getAddress();
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
            GestureDetector(
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
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 4, top: 18),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/CartScreen');
                    },
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/shopping-cart.png",
                          color: appPrimaryMaterialColor,
                        )),
                  ),
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
            )
          ],
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.grey),
          title: Text(
            'drw_manage_address'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: appPrimaryMaterialColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showDialog(context);
          },
        ),
        body: isDisplayLoading
            ? LoadingComponent()
            : getAddressList.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 30),
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: getAddressList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AddressComponent(
                            addressData: getAddressList[index],
                            onRefresh: () {
                              _getAddress();
                            },
                            onRemove: () {
                              setState(() {
                                getAddressList.removeAt(index);
                              });
                            },
                          );
                        }),
                  )
                : Center(
                    child: Text(
                    'Address_Not_Found'.tr().toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600),
                  )));
  }

  _getAddress() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isDisplayLoading = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
        });
        Services.PostForList(api_name: 'getAddress', body: body).then(
            (addResponseList) async {
          setState(() {
            isDisplayLoading = false;
          });
          if (addResponseList.length > 0) {
            setState(() {
              getAddressList = addResponseList;
            });
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isDisplayLoading = false;
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

class AlertFloating extends StatefulWidget {
  Function onRefresh;
  AlertFloating({this.onRefresh});

  @override
  _AlertFloatingState createState() => _AlertFloatingState();
}

class _AlertFloatingState extends State<AlertFloating> {
  TextEditingController txtHouseNo = TextEditingController();
  TextEditingController txtFullAddress = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtPincode = TextEditingController();
  TextEditingController txtLandmark = TextEditingController();

  final _formkey = new GlobalKey<FormState>();

  bool isLoading = false;
  bool isStateLoading = true, isCityLoading = false;

  List<StateClass> stateList = [];
  StateClass selectedState;

  List<CityClass> cityList = [];
  CityClass selectedCity;

  @override
  void initState() {
    _getState();
  }

  _getState() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getState().then((responseList) async {
          setState(() {
            isStateLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              stateList = responseList;
              selectedState = responseList[0];
            });
            //_getCity(selectedState.stateId);
            _getCity(responseList[0].stateId);
          } else {
            Fluttertoast.showToast(msg: "States Not Found");
          }
        }, onError: (e) {
          setState(() {
            isStateLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _getCity(stateId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({"StateId": stateId});
        Services.getCity(body: body).then((responseList) async {
          setState(() {
            isCityLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              cityList = responseList;
              selectedCity = responseList[0];
            });
          } else {
            Fluttertoast.showToast(msg: "City Not Found");
          }
        }, onError: (e) {
          setState(() {
            isCityLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        'Address_Details'.tr().toString(),
        style: TextStyle(
          fontSize: 22,
          color: appPrimaryMaterialColor,
          // fontWeight: FontWeight.bold
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          //height: 200,
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'House_No'.tr().toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 3),
                        child: TextFormField(
                          controller: txtHouseNo,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
                          validator: (homeNo) {
                            if (homeNo.length == 0) {
                              return 'Please enter your house Number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(5),
                            hintText: ' B-405,406',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.grey))),
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/012-house.png",
                                      color: appPrimaryMaterialColor,
                                    )),
                              ),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full_Address'.tr().toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 3),
                        child: TextFormField(
                          controller: txtFullAddress,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
                          validator: (address) {
                            if (address.length == 0) {
                              return 'Please enter your full address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(5),
                            hintText: ' ABC Textile Market ',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.grey))),
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/050-world-grid.png",
                                      color: appPrimaryMaterialColor,
                                    )),
                              ),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //'Full_Address'.tr().toString(),
                        'Landmark'.tr().toString(),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 3),
                        child: TextFormField(
                          controller: txtLandmark,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
                          validator: (address) {
                            if (address.length == 0) {
                              return 'Please enter your full address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(5),
                            hintText: ' Near abc hospital ',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                width: 43,
                                decoration: BoxDecoration(
                                    border: Border(
                                        right: BorderSide(
                                            width: 2, color: Colors.grey))),
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/038-placeholder.png",
                                      color: appPrimaryMaterialColor,
                                    )),
                              ),
                            ),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Pincode'.tr().toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 3),
                  child: TextFormField(
                    controller: txtPincode,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.black,
                    validator: (pincode) {
                      // Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                      // RegExp regExp = new RegExp(pattern);
                      if (pincode.length == 0) {
                        return 'Please enter your pincode';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5),
                      hintText: 'Pincode',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 43,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 2, color: Colors.grey))),
                          child: Icon(
                            Icons.code,
                            color: appPrimaryMaterialColor,
                          ),
                        ),
                      ),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                  child: Text(
                    //'Pincode'.tr().toString(),
                    'State'.tr().toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: isStateLoading
                          ? LoadingComponent()
                          : DropdownButton<StateClass>(
                              value: selectedState,
                              onChanged: (value) {
                                setState(() {
                                  selectedState = value;
                                  _getCity(selectedState.stateId);
                                });
                              },
                              items: stateList.map(
                                (StateClass state) {
                                  return DropdownMenuItem<StateClass>(
                                    child: Text(state.stateName),
                                    value: state,
                                  );
                                },
                              ).toList(),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 5),
                  child: Text(
                    'City'.tr().toString(),
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: isCityLoading
                          ? LoadingComponent()
                          : DropdownButton<CityClass>(
                              value: selectedCity,
                              onChanged: (value) {
                                setState(() {
                                  selectedCity = value;
                                });
                              },
                              items: cityList.map(
                                (CityClass city) {
                                  return DropdownMenuItem<CityClass>(
                                    child: Text(city.cityName),
                                    value: city,
                                  );
                                },
                              ).toList(),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
          child: isLoading
              ? LoadingComponent()
              : Text(
                  'Add'.tr().toString(),
                  style:
                      TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
                ),
          onPressed: () {
            _addAddress();
            //  Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  _addAddress() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();

          FormData body = FormData.fromMap({
            "CustomerId": prefs.getString(Session.CustomerId),
            "AddressCity": "",
            "AddressPincode": txtPincode.text,
            "AddressName": txtFullAddress.text,
            "AddressHouseNo": txtHouseNo.text,
            "StateId": selectedState.stateId,
            "CityId": selectedCity.cityId,
            "AddressLandmark": txtLandmark.text,
          }); //"key":"value"

          Services.postForSave(apiname: 'addAddress', body: body).then(
              (response) async {
            if (response.IsSuccess == true && response.Data == "1") {
              Navigator.of(context).pop("pop");
              widget.onRefresh();
              Fluttertoast.showToast(
                  msg: "Your Address Added Successfully",
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
