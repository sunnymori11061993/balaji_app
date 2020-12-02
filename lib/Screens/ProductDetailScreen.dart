import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/RelatedProductComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/ViewCatalougeScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
  bool isGetCartLoading = true;
  bool isFavLoading = false;
  bool isCartLoading = false;
  bool isCatlogLoading = false;
  bool isRelatedProductLoading = true;
  bool isWishList = false;
  bool isCartList = false;
  bool isRateLoading = true;
  var productList;
  List relatedProductList = [];

  List imgList = [];
  List cartList = [];
  List rateList = [];
  double percentResult;
  int value;
  int a = 0;

  counter() {
    int b;
    b = a + 3;
    if (b <= rateList.length) {
      setState(() {
        a = b;
      });
      print(a);
    } else {
      setState(() {
        a = rateList.length;
      });
    }
  }

  percent() {
    setState(() {
      percentResult = value * 100 / int.parse(productList["ProductMrp"]);
    });
    print(percentResult);
  }

  discount() {
    setState(() {
      value = int.parse(productList["ProductMrp"]) -
          int.parse(productList["ProductSrp"]);
    });
  }

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

  String isShowcase = "false";

  @override
  void initState() {
    //total();
    _getProductDetail();
    _getRating();
  }

  Future<File> createFileOfPdfUrl(url) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    setState(() {
      isCatlogLoading = true;
    });
    try {
      //final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      setState(() {
        isCatlogLoading = false;
      });
    } catch (e) {
      setState(() {
        isCatlogLoading = false;
      });
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
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
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(
            color: appPrimaryMaterialColor,
          ),
          title: Text('Product_Detail'.tr().toString(),
              style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17)),
          actions: <Widget>[
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
            GestureDetector(
              onTap: () async {
                final result =
                    await Navigator.of(context).pushNamed('/CartScreen');
                if (result == "pop") _getProductDetail();
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
                  // IconButton(
                  //     icon: Icon(Icons.card_travel),
                  //     onPressed: () async {
                  //       final result =
                  //           await Navigator.of(context).pushNamed('/CartScreen');
                  //       if (result == "pop") _getProductDetail();
                  //     }),
                  provider.cartCount > 0
                      ? Padding(
                          padding: const EdgeInsets.only(
                              left: 1.0, top: 13, right: 15),
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
            )
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
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20),
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
                                "Total".tr().toString() +
                                    " : " +
                                    " ₹ " +
                                    "${res}",
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
                              if (isCartLoading == false &&
                                  isCartList == false) {
                                _addToCart();
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 40,

                              // color: appPrimaryMaterialColor,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: AssetImage("assets/backchange.png"),
                                    fit: BoxFit.cover),
                                // border: Border.all(color: Colors.grey[300]),
                                //    color: appPrimaryMaterialColor
                              ),
                              child: isCartLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
//                                        Icon(
//                                          Icons.shopping_cart,
//                                          color: Colors.white,
//                                        ),
                                        isCartList == true
                                            ? Text(
                                                'Already_in_Cart'
                                                    .tr()
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : Text(
                                                'Add_to_Cart'.tr().toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
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
            ? LoadingComponent()
            : Stack(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
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
                                            enableInfiniteScroll: false,
                                            enlargeCenterPage: true,
                                          ),
                                          items: imgList
                                              .map((item) => Container(
                                                    margin: EdgeInsets.all(5.0),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15.0)),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            FadeInImage
                                                                .assetNetwork(
                                                              image: Image_URL +
                                                                  item,
                                                              fit: BoxFit.fill,
                                                              width: 1000.0,
                                                              placeholder:
                                                                  'assets/BWB_Logo-02.jpg',
                                                            ),
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
                                                                            0.0,
                                                                        horizontal:
                                                                            0.0),
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              productList["ProductName"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0),
                                                    child: Text(
                                                      // "${widget.relatedProductData["ProductSrp"]}",
                                                      "(${percentResult.toStringAsFixed(0)}% OFF)",
                                                      style: TextStyle(
                                                          // color: Colors.grey[600],
                                                          color:
                                                              appPrimaryMaterialColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            _addToWishlist();
                                          },
                                          child: Container(
                                            child: isWishList == false
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 12.0,
                                                    ),
                                                    child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: Image.asset(
                                                          "assets/heart.png",
                                                          color:
                                                              appPrimaryMaterialColor,
                                                        )),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 12.0,
                                                    ),
                                                    child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: Image.asset(
                                                          "assets/020-heart.png",
                                                          color:
                                                              appPrimaryMaterialColor,
                                                        )),
                                                  ),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, bottom: 8),
                                        child: Text(
                                          'Select_Quantity'.tr().toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    minus();
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18, right: 11),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey[300],
                                                            blurRadius: 2.0,
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                        border: Border.all(
                                                            width: 1.4,
                                                            color:
                                                                appPrimaryMaterialColor)),
                                                    width: 25,
                                                    height: 25,
                                                    child: Center(
                                                      child: Icon(Icons.remove,
                                                          color:
                                                              appPrimaryMaterialColor,
                                                          size: 16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5),
                                                //child: Text("${widget.getCartData["CartQuantity"]}"),
                                                child: Text(
                                                  '$_m',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              ),
                                              // IconButton(
                                              //   icon: Icon(
                                              //     Icons.add_circle,
                                              //     size: 20,
                                              //   ),
                                              //   onPressed: () {
                                              //     add();
                                              //   },
                                              //   color: appPrimaryMaterialColor,
                                              // ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    add();
                                                  });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 11, right: 12),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey[300],
                                                            blurRadius: 2.0,
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                        border: Border.all(
                                                            width: 1.4,
                                                            color:
                                                                appPrimaryMaterialColor)),
                                                    width: 25,
                                                    height: 25,
                                                    child: Center(
                                                      child: Icon(Icons.add,
                                                          color:
                                                              appPrimaryMaterialColor,
                                                          size: 16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          productList["ProductCatlogPDF"] == ""
                                              ? Container()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          top: 5,
                                                          bottom: 8,
                                                          right: 8),
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 150,
                                                    child: FlatButton(
                                                      //color: appPrimaryMaterialColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      300])),
                                                      onPressed: () async {
                                                        // print(productList);
                                                        log(productList[
                                                            "ProductCatlogPDF"]);
                                                        if (productList[
                                                                "ProductCatlogPDF"] !=
                                                            "") {
                                                          await createFileOfPdfUrl(
                                                                  Image_URL +
                                                                      productList[
                                                                          "ProductCatlogPDF"])
                                                              .then((f) {
                                                            log(f.path);
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    new ViewCatalougeScreen(
                                                                  path: f.path,
                                                                  catData:
                                                                      productList[
                                                                          "ProductCatlogPDF"],
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                        } else
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Catalogue not found");
                                                      },
                                                      child: isCatlogLoading
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Center(
                                                                child: SizedBox(
                                                                  height: 15,
                                                                  width: 25,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        new AlwaysStoppedAnimation<Color>(
                                                                            appPrimaryMaterialColor),
                                                                  ),
                                                                ),
                                                              ))
                                                          : Text(
                                                              'View_Catalogue'
                                                                  .tr()
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                //color: Colors.white,
                                                                color: Colors
                                                                    .grey[700],
//                                                          fontWeight:
//                                                              FontWeight.bold
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Container(
                            height: 20,
                            color: Colors.grey[100],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Product_Description'.tr().toString(),
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
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20, right: 8),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'About_Products'.tr().toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, bottom: 0),
                                        child: Text(
                                          "Size",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 0),
                                        child: Text(
                                          productList["ProductAttributes"][0]
                                              ["Size"],
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, bottom: 0),
                                        child: Text(
                                          "Brand Name",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 0),
                                        child: Text(
                                          productList["ProductAttributes"][0]
                                              ["Brand Name"],
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 0),
                                          child: Text(
                                            "Fabric",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 0),
                                          child: Text(
                                            productList["ProductAttributes"][0]
                                                ["Material"],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 0),
                                          child: Text(
                                            "Colour",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 0),
                                          child: Text(
                                            productList["ProductAttributes"][0]
                                                ["Color"],
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15.0, bottom: 0),
                                child: Text(
                                  "Sku Code",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, bottom: 0),
                                child: Text(
                                  productList["ProductSKU"],
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            height: 20,
                            color: Colors.grey[100],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Related_Products'.tr().toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 10),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.4,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: relatedProductList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return RelatedProductComponent(
                                          relatedProductData:
                                              relatedProductList[index],
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            height: 20,
                            color: Colors.grey[100],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Rating_&_Reviews'.tr().toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        isRateLoading
                            ? LoadingComponent()
                            : rateList.length > 0
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25.0,
                                        left: 20,
                                        right: 20,
                                        bottom: 3),
                                    child: ListView.builder(
                                        //scrollDirection: Axis.horizontal,
                                        //  itemCount: rateList.length,
                                        itemCount: a,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // "4.5",
                                                  "${rateList[index]["RatingStar"]}",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey[700],
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SmoothStarRating(
                                                    allowHalfRating: false,
                                                    isReadOnly: true,
                                                    starCount: 5,
                                                    rating: rateList[index][
                                                                "RatingStar"] ==
                                                            ""
                                                        ? 0
                                                        : double.parse(
                                                            "${rateList[index]["RatingStar"]}",
                                                          ),
                                                    size: 20.0,
                                                    color:
                                                        appPrimaryMaterialColor,
                                                    borderColor:
                                                        appPrimaryMaterialColor,
                                                    spacing: 0.0),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0, right: 4),
                                                  child: Text(
                                                    // "First, to be 100% clear about what type of service we will be talking about, let's define what we mean under the reviews. A review is manual writing under the description of the application users can place at Google Play to evaluate the product they tried. This is a well-composed statement, of 2 or more sentences that show their experience with the application, attitude and plans (whether they will use it in the future or not).",
                                                    "${rateList[index]["RatingReview"]}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 25,
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey,
//                                                        fontWeight:
//                                                            FontWeight.w200
                                                    ),
                                                  ),
                                                ),
                                                Divider()
                                              ],
                                            ),
                                          );
                                        }))
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(
                                        child: Text(
                                      'norating'.tr().toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                        a < rateList.length
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      counter();
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.grey[300],
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              'See_more'.tr().toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container()
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
        setState(() {
          isLoading = true;
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
            log(productResponseList[0]["ProductImages"].toString());
            total();
            _getRelatedProduct();
            discount();
            percent();
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

  _getRating() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body =
            FormData.fromMap({"ProductId": "${widget.productDetail}"});
        setState(() {
          isRateLoading = true;
        });
        Services.PostForList(api_name: 'getRating', body: body).then(
            (responseList) async {
          if (responseList.length > 0) {
            setState(() {
              isRateLoading = false;
              rateList = responseList;
            });
            if (responseList.length >= 3) {
              setState(() {
                a = 3;
              });
            } else {
              setState(() {
                a = responseList.length;
              });
            }
          } else {
            setState(() {
              isRateLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isRateLoading = false;
          });
          print("error on call -> ${e.message}");
          Fluttertoast.showToast(msg: "Something Went Wrong");
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection.");
    }
  }

  _getRelatedProduct() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({
          "SubcategoryId": productList["SubcategoryId"],
        });
        setState(() {
          isRelatedProductLoading = true;
        });
        Services.PostForList(api_name: 'relatedProduct', body: body).then(
            (productResponseList) async {
          setState(() {
            isRelatedProductLoading = false;
          });
          if (productResponseList.length > 0) {
            setState(() {
              relatedProductList = productResponseList;
              //set "data" here to your variable
            });
            total();
          } else {
            Fluttertoast.showToast(msg: "Product Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isRelatedProductLoading = false;
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
        setState(() {
          isCartLoading = true;
        });
        Services.postForSave(apiname: 'insert_data_api/cart', body: body).then(
            (responseList) async {
          if (responseList.IsSuccess == true && responseList.Data == "1") {
            setState(() {
              isCartLoading = false;
              isCartList = !isCartList;
            });
            Provider.of<CartProvider>(context, listen: false).increaseCart(_m);
            if (isCartList == true) {
              Fluttertoast.showToast(msg: "Added to Cart");
            } else {
              Fluttertoast.showToast(msg: "Already in Cart");
            }
            total();
            // _getProductDetail();
          } else {
            setState(() {
              isCartLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
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
}
