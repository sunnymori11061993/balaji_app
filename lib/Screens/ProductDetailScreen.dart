import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Component/LoadingComponent.dart';

//slider

class ProductDetailScreen extends StatefulWidget {
  var productDetail;

  ProductDetailScreen({this.productDetail});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  TextEditingController controller = new TextEditingController();

  int _m = 1;
  int res = 0;
  bool isLoading = true;
  bool isPLoading = true;
  bool isFavLoading = false;
  bool isWishList = false;
  bool isCartList = false;
  var productList;
  List imgList = [];

  void add() {
    setState(() {
      _m++;
    });
    total();
  }

  void minus() {
    setState(() {
      if (_m != 1) _m--;
    });
    total();
  }

  void total() {
    setState(() {
      res = int.parse(productList["ProductSrp"]) * _m;
    });
  }

  @override
  void initState() {
    //total();
    _getProductDetail();
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
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(
            color: appPrimaryMaterialColor,
          ),
          title: const Text('Product Detail',
              style: TextStyle(
                color: Colors.black,
              )),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  Navigator.of(context).pushNamed('/Whishlist');
                }),
            IconButton(
                icon: Icon(Icons.card_travel),
                onPressed: () {
                  Navigator.of(context).pushNamed('/CartScreen');
                }),
          ],
        ),
        bottomNavigationBar: isLoading
            ? SizedBox()
            : Padding(
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
                            "Total:₹ " + "${res}",
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
                          if (isCartList == false) {
                            _addToCart();
                          }
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          // color: appPrimaryMaterialColor,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // border: Border.all(color: Colors.grey[300]),
                              color: appPrimaryMaterialColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              isCartList == true
                                  ? Text(
                                      "Already in Cart",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        body: isLoading
            ? LoadingComponent()
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        //slider
                                        child: Column(
                                      children: <Widget>[
                                        CarouselSlider(
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            aspectRatio: 1.0,
                                            enlargeCenterPage: true,
                                          ),
                                          items: imgList
                                              .map((item) => Container(
                                                    margin: EdgeInsets.all(5.0),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Image.network(
                                                                Image_URL +
                                                                    item,
                                                                fit:
                                                                    BoxFit.fill,
                                                                width: 1000.0),
                                                            Positioned(
                                                              bottom: 0.0,
                                                              left: 0.0,
                                                              right: 0.0,
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color.fromARGB(
                                                                          200,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                      Color
                                                                          .fromARGB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0)
                                                                    ],
                                                                    begin: Alignment
                                                                        .bottomCenter,
                                                                    end: Alignment
                                                                        .topCenter,
                                                                  ),
                                                                ),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            10.0,
                                                                        horizontal:
                                                                            40.0),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                                //slider
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 20, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            productList["ProductName"],
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                    "₹" +
                                                        productList[
                                                            "ProductSrp"],
                                                    // "${widget.productDetail["ProductSrp"]}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: Text(
                                                      "₹" +
                                                          productList[
                                                              "ProductMrp"],

                                                      //  "${widget.productDetail["ProductMrp"]}",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 16,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _addToWishlist();
                                        },
                                        child: Container(
                                            child: isWishList == false
                                                ? Icon(
                                                    Icons.favorite_border,
                                                    color:
                                                        appPrimaryMaterialColor,
                                                  )
                                                : Icon(
                                                    Icons.favorite,
                                                    color:
                                                        appPrimaryMaterialColor,
                                                  )),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      "Select Quantity",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.remove_circle),
                                          onPressed: () {
                                            minus();
                                          },
                                          color: appPrimaryMaterialColor,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Text('$_m'),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add_circle),
                                          onPressed: () {
                                            add();
                                          },
                                          color: appPrimaryMaterialColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 20,
                          color: Colors.grey[200],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Product Description",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 10),
                                child: Text(
                                  productList["ProductDescription"],
                                  //  "${widget.productDetail["ProductDescription"]}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Divider()
                            ],
                          ),
                        ),
//            Container(
//              height: 20,
//              color: Colors.grey[200],
//            ),
//            Padding(
//              padding: const EdgeInsets.only(top: 10.0, left: 20, right: 8),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    "About Product",
//                    style: TextStyle(
//                        fontSize: 15,
//                        color: Colors.black,
//                        fontWeight: FontWeight.w600),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 15.0),
//                    child: Text(
//                      "Product Id",
//                      style: TextStyle(
//                          fontSize: 13,
//                          color: Colors.black,
//                          fontWeight: FontWeight.w600),
//                    ),
//                  ),
//                  Text(
//                    "PD005820",
//                    style: TextStyle(
//                        fontSize: 15,
//                        color: Colors.grey,
//                        fontWeight: FontWeight.w400),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 15.0),
//                    child: Row(
//                      children: <Widget>[
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              "Saree Colour",
//                              style: TextStyle(
//                                  fontSize: 13,
//                                  color: Colors.black,
//                                  fontWeight: FontWeight.w600),
//                            ),
//                            Text(
//                              "Red",
//                              style: TextStyle(
//                                  fontSize: 15,
//                                  color: Colors.grey,
//                                  fontWeight: FontWeight.w400),
//                            ),
//                          ],
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 70.0),
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text(
//                                "Fabric of Saree",
//                                style: TextStyle(
//                                    fontSize: 13,
//                                    color: Colors.black,
//                                    fontWeight: FontWeight.w600),
//                              ),
//                              Text(
//                                "Cotton",
//                                style: TextStyle(
//                                    fontSize: 15,
//                                    color: Colors.grey,
//                                    fontWeight: FontWeight.w400),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                  Divider()
//                ],
//              ),
//            ),
                      ],
                    ),
                  ),
                  isFavLoading ? LoadingComponent() : Container()
                ],
              ));
  }

  _getProductDetail() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          "ProductId": "${widget.productDetail}"
        });
        Services.PostForList(
                api_name: 'getProductDetailByCustomerId', body: body)
            .then((productResponseList) async {
          if (productResponseList.length > 0) {
            setState(() {
              isLoading = false;
              productList = productResponseList[0];
              imgList = productResponseList[0]["ProductImages"];
              isCartList = productResponseList[0]["isCart"];
              isWishList = productResponseList[0]["isFav"];
              //set "data" here to your variable
            });
            total();
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

  _addToWishlist() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          "ProductId": "${widget.productDetail}",
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
            setState(() {
              isWishList = !isWishList;
            });
            if (isWishList == true) {
              Fluttertoast.showToast(msg: "Added to Wishlist");
            } else {
              Fluttertoast.showToast(msg: "Remove from Wishlist");
            }
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

  _addToCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap({
          "CustomerId": prefs.getString(Session.CustomerId),
          "ProductId": "${widget.productDetail}",
          "CartQuantity": _m
        });
        Services.postForSave(apiname: 'insert_data_api/cart', body: body).then(
            (responseList) async {
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            setState(() {
              isLoading = false;
              isCartList = !isCartList;
            });
            if (isCartList == true) {
              Fluttertoast.showToast(msg: "Added to Cart");
            } else {
              Fluttertoast.showToast(msg: "Already in Cart");
            }
            total();
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
