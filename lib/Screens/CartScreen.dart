import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/CartComponent.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var isLoading = true;
  List getCartList = [];
  List updateCartList = [];

  int mainTotal = 0;
  String dropdownvalue = 'rinki';

  @override
  void initState() {
    _getCart();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop("pop");
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: appPrimaryMaterialColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop("pop");
                }),
            elevation: 1,
            backgroundColor: Colors.white,
            iconTheme: new IconThemeData(
              color: appPrimaryMaterialColor,
            ),
            title: const Text("My Cart",
                style: TextStyle(
                  color: Colors.black,
                )),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Whishlist');
                  }),
              // IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
            ],
          ),
          bottomNavigationBar: isLoading
              ? SizedBox()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  // "Total:₹ " + "${res}",
                                  "Total:₹ " + "$mainTotal",
                                  //"${res}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                _settingModalBottomSheet(context);
                              },
                              child: Container(
                                width: 170,
                                height: 40,
                                // color: appPrimaryMaterialColor,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    // border: Border.all(color: Colors.grey[300]),
                                    color: appPrimaryMaterialColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Select Address ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        appPrimaryMaterialColor),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                  child: ListView.separated(
                    itemCount: getCartList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CartComponent(
                        getCartData: getCartList[index],
                        onRemove: (total) {
                          setState(() {
                            getCartList.removeAt(index);
                            mainTotal = mainTotal - total;
                          });
                        },
                        onAdd: (total) {
                          setState(() {
                            mainTotal = mainTotal + total;
                          });
                        },
                        onMinus: (total) {
                          setState(() {
                            mainTotal = mainTotal - total;
                          });
                        },
                        // updateCartData: ,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                  ),
                )),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return showBottomSheet();
        });
  }

  _getCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isLoading = true;
        SharedPreferences pref = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap(
            {"customerId": pref.getString(Session.CustomerId)});
        Services.PostForList(api_name: 'get_data_where/tblcart', body: body)
            .then((responseList) async {
          setState(() {
            isLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              getCartList = responseList;
              //set "data" here to your variable
            });
            for (int i = 0; i < responseList.length; i++) {
              setState(() {
                mainTotal = mainTotal +
                    int.parse(responseList[i]["ProductSrp"]) *
                        int.parse(responseList[i]["CartQuantity"]);
              });
            }
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoading = false;
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

class AlertAdd extends StatefulWidget {
  @override
  _AlertAddState createState() => _AlertAddState();
}

class _AlertAddState extends State<AlertAdd> {
  TextEditingController txtHouseNo = TextEditingController();
  TextEditingController txtFullAddress = TextEditingController();
  TextEditingController txtCity = TextEditingController();
  TextEditingController txtPincode = TextEditingController();
  final _formkey = new GlobalKey<FormState>();

  bool isAddLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Address Details",
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(top: 8.0),
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
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "City",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 3),
                  child: TextFormField(
                    controller: txtCity,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 15),
                    cursorColor: Colors.black,
                    validator: (city) {
                      if (city.length == 0) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5),
                      hintText: 'City',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 43,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 2, color: Colors.grey))),
                          child: Icon(
                            Icons.location_city,
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
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Pincode",
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
              ],
            ),
          ),
        ),
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
          child: isAddLoading
              ? LoadingComponent()
              : Text(
                  "Add",
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
            isAddLoading = true;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();

          FormData body = FormData.fromMap({
            "CustomerId": prefs.getString(Session.CustomerId),
            "AddressCity": txtCity.text,
            "AddressPincode": txtPincode.text,
            "AddressName": txtFullAddress.text,
            "AddressHouseNo": txtHouseNo.text,
          }); //"key":"value"

          Services.postForSave(apiname: 'addAddress', body: body).then(
              (response) async {
            if (response.IsSuccess == true && response.Data == "1") {
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                  msg: "Your Address Added Successfully",
                  gravity: ToastGravity.BOTTOM);
            }

            setState(() {
              isAddLoading = false;
            });
          }, onError: (e) {
            setState(() {
              isAddLoading = false;
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

class AlertSelectAddress extends StatefulWidget {
  Function onSelect;

  AlertSelectAddress({this.onSelect});

  @override
  _AlertSelectAddressState createState() => _AlertSelectAddressState();
}

class _AlertSelectAddressState extends State<AlertSelectAddress> {
  List getAddressList = [];
  bool isSelectLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _getAddress();
  }

  onAddSend(var address) {
    address = getAddressList;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "Select Address",
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            fontWeight: FontWeight.bold),
      ),
      content: isSelectLoading
          ? LoadingComponent()
          : ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onSelect(getAddressList[index]);
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300],
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                      "${getAddressList[index]["AddressHouseNo"]}" +
                                          ",",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                        "${getAddressList[index]["AddressName"]}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                    "${getAddressList[index]["AddressCity"]}" +
                                        "  -",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      "${getAddressList[index]["AddressPincode"]}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: getAddressList.length,
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
      ],
    );
  }

  _getAddress() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isSelectLoading = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();

        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
        });
        Services.PostForList(api_name: 'getAddress', body: body).then(
            (addResponseList) async {
          setState(() {
            isSelectLoading = false;
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
            isSelectLoading = false;
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

class showBottomSheet extends StatefulWidget {
  @override
  _showBottomSheetState createState() => _showBottomSheetState();
}

class _showBottomSheetState extends State<showBottomSheet> {
  var selectedAddress;
  bool isOrderLoading = false;

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog

        return AlertAdd();
      },
    );
  }

  _showDialogSelect(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertSelectAddress(
          onSelect: (address) {
            setState(() {
              selectedAddress = address;
            });
          },
        );
      },
    );
  }

//  @override
//  void initState() {
//    // TODO: implement initState
//    _placeOrder();
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Wrap(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15, bottom: 10),
                child: Text(
                  "Select Address",
                  style: TextStyle(
                      fontSize: 22,
                      color: appPrimaryMaterialColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: SizedBox(
                  height: 35,
                  width: 140,
                  child: FlatButton(
                    //olor: appPrimaryMaterialColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.grey[300])),
                    onPressed: () {
                      _showDialogSelect(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.my_location,
                          size: 18,
                          //color: Colors.white),
                          color: Colors.grey[700],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(
                            "Select",
                            style: TextStyle(
                                fontSize: 16,
                                //color: Colors.white,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              selectedAddress != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20, bottom: 5),
                      child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300],
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                        "${selectedAddress["AddressHouseNo"]}" +
                                            ",",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                          "${selectedAddress["AddressName"]}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                        "${selectedAddress["AddressCity"]}" +
                                            " -",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                          "${selectedAddress["AddressPincode"]}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    )
                  : Container(),
              GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Icon(
                        Icons.add,
                        color: Colors.grey[700],
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0, bottom: 15),
                      child: Text(
                        "Add Address",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: 45,
                        width: 150,
                        child: FlatButton(
                          color: appPrimaryMaterialColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey[300])),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.delete_forever, color: Colors.white),
                              // color: Colors.grey[700],),
                              Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    //  color: Colors.grey[700],
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
                      padding: const EdgeInsets.only(right: 20.0),
                      child: SizedBox(
                        width: 150,
                        height: 45,
                        child: FlatButton(
                          color: appPrimaryMaterialColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: Colors.grey[300])),
                          onPressed: () {
                            _placeOrder();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (BuildContext context) =>
                            //           PlaceOrderScreen()),
                            // );
                          },
                          child: isOrderLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_shopping_cart,
                                        color: Colors.white),
                                    Text(
                                      "Place Order",
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
              )
            ],
          )
        ],
      ),
    );
  }

  _placeOrder() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          "AddressId": "${selectedAddress["AddressId"]}",
        });
        setState(() {
          isOrderLoading = true;
        });
        Services.postForSave(apiname: 'placeOrder', body: body).then(
            (responseList) async {
          setState(() {
            isOrderLoading = false;
          });
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            Navigator.of(context).pop();
            Fluttertoast.showToast(msg: "Order Placed Successfully!!!");
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isOrderLoading = false;
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
