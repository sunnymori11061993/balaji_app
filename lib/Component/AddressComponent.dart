import 'dart:io';

import 'package:balaji/Common/ClassList.dart';
import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';

class AddressComponent extends StatefulWidget {
  var addressData;
  Function onRemove;
  Function onRefresh;

  AddressComponent({this.addressData, this.onRemove, this.onRefresh});

  @override
  _AddressComponentState createState() => _AddressComponentState();
}

class _AddressComponentState extends State<AddressComponent> {
  TextEditingController txtHouseNo = TextEditingController();
  TextEditingController txtFullAddress = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtState = TextEditingController();
  TextEditingController txtPincode = TextEditingController();
  TextEditingController txtLandmark = TextEditingController();
  String dropdownvalue = 'Gujarat';
  String dropdownvaluecity = 'Surat';
  final _formkey = new GlobalKey<FormState>();

  bool isRemoveLoading = false;
  bool isUpdateLoading = false;
  bool isStateLoading = true, isCityLoading = false;

  List<StateClass> stateList = [];
  StateClass selectedState;

  List<CityClass> cityList = [];
  CityClass selectedCity;

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
            });

            for (int i = 0; i < responseList.length; i++) {
              if (responseList[i].stateId == widget.addressData["StateId"]) {
                setState(() {
                  selectedState = responseList[i];
                });
              }
            }

            //_getCity(selectedState.stateId);
            _getCity(selectedState.stateId);
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
              for (int i = 0; i < responseList.length; i++) {
                if (responseList[i].cityId == widget.addressData["CityId"]) {
                  setState(() {
                    selectedCity = responseList[i];
                  });
                }
              }
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

  _showDialog(BuildContext context) {
    //show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            'Remove'.tr().toString(),
            style: TextStyle(
              fontSize: 22,
              color: appPrimaryMaterialColor,
              // fontWeight: FontWeight.bold
            ),
          ),
          content: new Text(
            'Are_you_sure_add'.tr().toString(),
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
              onPressed: () {
                _removeFromAddress();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _getState();
    setState(() {
      txtHouseNo.text = widget.addressData["AddressHouseNo"];
      txtFullAddress.text = widget.addressData["AddressName"];
      txtLandmark.text = widget.addressData["AddressLandmark"];
      txtPincode.text = widget.addressData["AddressPincode"];
      txtState.text = widget.addressData["StateName"];
      txtCity.text = widget.addressData["CityName"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          //height: 200,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                  child: Text(
                    'Address'.tr().toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Text(
                          'House_No'.tr().toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 3),
                        child: TextFormField(
                          controller: txtHouseNo,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          validator: (homeNo) {
                            if (homeNo.length == 0) {
                              return 'Please enter your house Number';
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
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
                                child: Icon(
                                  Icons.home,
                                  color: appPrimaryMaterialColor,
                                ),
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
                  padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Text(
                          'Full_Address'.tr().toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 3),
                        child: TextFormField(
                          controller: txtFullAddress,
                          validator: (address) {
                            if (address.length == 0) {
                              return 'Please enter your full address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 15),
                          cursorColor: Colors.black,
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
                                child: Icon(
                                  Icons.location_on,
                                  color: appPrimaryMaterialColor,
                                ),
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
                  padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Landmark'.tr().toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 40,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: txtLandmark,
                                style: TextStyle(fontSize: 15),
                                validator: (city) {
                                  if (city.length == 0) {
                                    return 'Please enter your city';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText: 'near abc hospital ',
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
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Pincode'.tr().toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 40,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: txtPincode,
                                validator: (pincode) {
                                  // Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                                  // RegExp regExp = new RegExp(pattern);
                                  if (pincode.length == 0) {
                                    return 'Please enter your pincode';
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText: 'Pincode ',
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'State'.tr().toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 40,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: txtState,
                                validator: (pincode) {
                                  // Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                                  // RegExp regExp = new RegExp(pattern);
                                  if (pincode.length == 0) {
                                    return 'Please enter your state';
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText: 'State ',
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
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 5.0),
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width / 2.3,
                          //     height: 45,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: Colors.grey,
                          //         ),
                          //         borderRadius: BorderRadius.circular(5)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 8.0),
                          //       child: DropdownButtonHideUnderline(
                          //         child: isStateLoading
                          //             ? LoadingComponent()
                          //             : DropdownButton<StateClass>(
                          //                 value: selectedState,
                          //                 onChanged: (value) {
                          //                   setState(() {
                          //                     selectedState = value;
                          //                     selectedCity = null;
                          //                     _getCity(selectedState.stateId);
                          //                   });
                          //                 },
                          //                 items: stateList.map(
                          //                   (StateClass state) {
                          //                     return DropdownMenuItem<
                          //                         StateClass>(
                          //                       child: Text(state.stateName),
                          //                       value: state,
                          //                     );
                          //                   },
                          //                 ).toList(),
                          //               ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'City'.tr().toString(),
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 40,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: txtCity,
                                validator: (pincode) {
                                  // Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                                  // RegExp regExp = new RegExp(pattern);
                                  if (pincode.length == 0) {
                                    return 'Please enter your city';
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(5),
                                  hintText: 'City ',
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
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 5.0),
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width / 2.3,
                          //     height: 45,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: Colors.grey,
                          //         ),
                          //         borderRadius: BorderRadius.circular(5)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 8.0),
                          //       child: DropdownButtonHideUnderline(
                          //         child: isCityLoading
                          //             ? LoadingComponent()
                          //             : DropdownButton<CityClass>(
                          //                 value: selectedCity,
                          //                 onChanged: (value) {
                          //                   setState(() {
                          //                     selectedCity = value;
                          //                   });
                          //                 },
                          //                 hint: Text("Select City"
                          //                     ""),
                          //                 items: cityList.map(
                          //                   (CityClass city) {
                          //                     return DropdownMenuItem<
                          //                         CityClass>(
                          //                       child: Text(city.cityName),
                          //                       value: city,
                          //                     );
                          //                   },
                          //                 ).toList(),
                          //               ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage("assets/backchange.png"),
                                  fit: BoxFit.cover)),
                          height: 45,
                          width: 150,
                          child: FlatButton(
                            // color: appPrimaryMaterialColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.grey[300])),
                            onPressed: () {
                              _showDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      right: 5.0, left: 4),
//                                  child: Icon(Icons.delete_forever,
//                                      color: Colors.white),
//                                ),
                                // color: Colors.grey[700],
                                //),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       right: 5.0, left: 4),
                                //   child: Container(
                                //       height: 20,
                                //       width: 20,
                                //       child: GestureDetector(
                                //           onTap: () {},
                                //           child: Image.asset(
                                //             "assets/filter.png",
                                //             color: Colors.white,
                                //           ))),
                                // ),
                                Text(
                                  'Remove'.tr().toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      //color: Colors.grey[700],
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: AssetImage("assets/backchange.png"),
                                  fit: BoxFit.cover)),
                          width: 150,
                          height: 45,
                          child: FlatButton(
                            //color: appPrimaryMaterialColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.grey[300])),
                            onPressed: () {
                              _updateAddress();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
//                                Padding(
//                                  padding: const EdgeInsets.only(
//                                      right: 10.0, left: 4),
//                                  child: Container(
//                                      height: 20,
//                                      width: 20,
//                                      child: Image.asset(
//                                        "assets/052-edit.png",
//                                        color: Colors.white,
//                                      )),
//                                ),
                                Text(
                                  'Update'.tr().toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      //color: Colors.grey[700],
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Container(
                      height: 10,
                      color: Colors.grey[100],
                    )),
              ],
            ),
          ),
        ),
        isRemoveLoading ? LoadingComponent() : Container(),
        isUpdateLoading ? LoadingComponent() : Container()
      ],
    );
  }

  _removeFromAddress() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({
          "AddressId": "${widget.addressData["AddressId"]}",
        });
        setState(() {
          isRemoveLoading = true;
        });
        Services.postForSave(apiname: 'deleteAddress', body: body).then(
            (responseList) async {
          setState(() {
            isRemoveLoading = false;
          });
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            widget.onRemove();
            Fluttertoast.showToast(
                msg: "Your Address Removed Successfully",
                gravity: ToastGravity.BOTTOM);
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isRemoveLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _updateAddress() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            isUpdateLoading = true;
          });

          FormData body = FormData.fromMap({
            "AddressId": "${widget.addressData["AddressId"]}",
            "AddressPincode": txtPincode.text,
            "AddressName": txtFullAddress.text,
            "AddressHouseNo": txtHouseNo.text,
            "AddressLandmark": txtLandmark.text,
            "StateName": txtState.text,
            "CityName": txtCity.text,
            // "StateId": selectedState.stateId,
            // "CityId": selectedCity.cityId,
          }); //"key":"value"

          Services.postForSave(apiname: 'updateAddress', body: body).then(
              (response) async {
            setState(() {
              isUpdateLoading = false;
            });
            if (response.IsSuccess == true && response.Data == "1") {
              widget.onRefresh();
              Fluttertoast.showToast(
                  msg: "Address Updated Successfully",
                  gravity: ToastGravity.BOTTOM);
            }
          }, onError: (e) {
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
