import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  TextEditingController txtPincode = TextEditingController();
  final _formkey = new GlobalKey<FormState>();

  bool isRemoveLoading = false;
  bool isUpdateLoading = false;

  _showDialog(BuildContext context) {
    //show alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Remove",
            style: TextStyle(
                fontSize: 22,
                color: appPrimaryMaterialColor,
                fontWeight: FontWeight.bold),
          ),
          content: new Text(
            "Are you sure want to remove the address!!!",
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
    setState(() {
      txtHouseNo.text = widget.addressData["AddressHouseNo"];
      txtFullAddress.text = widget.addressData["AddressName"];
      txtCity.text = widget.addressData["AddressCity"];
      txtPincode.text = widget.addressData["AddressPincode"];
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
                    "Address",
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
                      Text(
                        "House No",
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
                      Text(
                        "Full Address",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
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
                            "City",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                              width: 150,
                              height: 40,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: txtCity,
                                style: TextStyle(fontSize: 15),
                                validator: (city) {
                                  if (city.length == 0) {
                                    return 'Please enter your city';
                                  }
                                  return null;
                                },
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
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Pincode",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Container(
                              width: 150,
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
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          height: 45,
                          width: 150,
                          child: FlatButton(
                            color: appPrimaryMaterialColor,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0, left: 4),
                                  child: Icon(Icons.delete_forever,
                                      color: Colors.white),
                                ),
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
                                  "Remove",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      //color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
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
                        child: SizedBox(
                          width: 150,
                          height: 45,
                          child: FlatButton(
                            color: appPrimaryMaterialColor,
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 4),
                                  child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                        "assets/052-edit.png",
                                        color: Colors.white,
                                      )),
                                ),
                                Text(
                                  "Update",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      //color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
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
            "AddressCity": txtCity.text,
            "AddressPincode": txtPincode.text,
            "AddressName": txtFullAddress.text,
            "AddressHouseNo": txtHouseNo.text,
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
