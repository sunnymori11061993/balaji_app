import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistComponent extends StatefulWidget {
  var wishListData;
  Function onRemove;

  WishlistComponent({this.wishListData, this.onRemove});

  @override
  _WishlistComponentState createState() => _WishlistComponentState();
}

class _WishlistComponentState extends State<WishlistComponent> {
  bool isFavLoading = false;
  bool isCartLoading = false;
  double percentResult;
  int value;

  percent() {
    setState(() {
      percentResult =
          value * 100 / int.parse(widget.wishListData["ProductMrp"]);
    });
    print(percentResult);
  }

  discount() {
    setState(() {
      value = int.parse(widget.wishListData["ProductMrp"]) -
          int.parse(widget.wishListData["ProductSrp"]);
    });
  }

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
                fontWeight: FontWeight.w400
            ),
          ),
          content: new Text(
            "Are you sure want to remove from cart!!!",
            style: TextStyle(
                fontSize: 14, color: Colors.black,
                //fontWeight: FontWeight.w400
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
              child: new Text(
                "Ok",
                style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
              ),
              onPressed: () {
                _removeFromWishlist();
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
    discount();
    percent();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new ProductDetailScreen(
                          productDetail: widget.wishListData["ProductId"],
                        )));
          },
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Container(
                          height: 120,
                          width: 95,
                          child: Image.network(
                              Image_URL +
                                  "${widget.wishListData["ProductImages"]}",
                              fit: BoxFit.fill)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "${widget.wishListData["ProductName"]}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 4),
                              child: Text(
                                "${widget.wishListData["ProductDescription"]}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Price :",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "₹",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${widget.wishListData["ProductSrp"]}",
                                    style: TextStyle(
                                        // color: Colors.grey[600],
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      "₹" +
                                          "${widget.wishListData["ProductMrp"]}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                          fontSize: 15,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      // "${widget.relatedProductData["ProductSrp"]}",
                                      "(${percentResult.toStringAsFixed(0)}% OFF)",
                                      style: TextStyle(
                                          // color: Colors.grey[600],
                                          color: appPrimaryMaterialColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
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
                              _showDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
//                                Icon(Icons.delete_forever, color: Colors.white),
                                // color: Colors.grey[700],),
                                Text(
                                  "Remove",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      // color: Colors.grey[700],
                                      fontWeight: FontWeight.w400
                                  ),
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
                              _addToCart();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
//                                Icon(
//                                  Icons.shopping_cart,
//                                  color: Colors.white,
//                                ),
                                Text(
                                  "Move To Cart",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      //  color: Colors.grey[700],
                                      fontWeight: FontWeight.w400),
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
            ),
          ),
        ),
        isFavLoading ? LoadingComponent() : Container(),
        isCartLoading ? LoadingComponent() : Container()
      ],
    );
  }

  _addToCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          "ProductId": widget.wishListData["ProductId"],
          "CartQuantity": "1",
        });
        setState(() {
          isCartLoading = true;
        });
        Services.postForSave(apiname: 'insert_data_api/cart', body: body).then(
            (responseList) async {
          setState(() {
            isCartLoading = false;
          });
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            Fluttertoast.showToast(msg: "Added in Cart");
            _removeFromWishlist();
          } else {
            Fluttertoast.showToast(msg: "Already added in Cart");
          }
        }, onError: (e) {
          setState(() {
            isCartLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _removeFromWishlist() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          "ProductId": "${widget.wishListData["ProductId"]}",
        });
        setState(() {
          isFavLoading = true;
        });
        Services.postForSave(apiname: 'addRemoveWishlist', body: body).then(
            (responseList) async {
          setState(() {
            isFavLoading = false;
          });
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            widget.onRemove();
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isFavLoading = false;
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
