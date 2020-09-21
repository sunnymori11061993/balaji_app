import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/CartComponent.dart';
import 'package:balaji/Screens/PlaceOrderScreen.dart';
import 'package:dio/dio.dart';
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new PlaceOrderScreen(
                                              // productDetail: widget.wishListData["ProductId"],
                                              )));
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
                                  Icon(Icons.arrow_forward,color: Colors.white,)
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
              ),
      ),
    );
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
