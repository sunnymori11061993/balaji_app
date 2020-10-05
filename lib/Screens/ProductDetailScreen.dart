import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/RelatedProductComponent.dart';
import 'package:balaji/Screens/ViewCatalougeScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
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
  bool isGetCartLoading = true;
  bool isFavLoading = false;
  bool isCartLoading = false;
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
  int i;

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

  @override
  void initState() {
    //total();
    _getProductDetail();
    _getCart();
    _getRating();
  }

  _showDialogView(BuildContext context, var data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertViewCatalogue(
            viewCatData: data,
          );
        });
  }

  Future<File> createFileOfPdfUrl(url) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
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
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
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
          title: Text('Product_Detail'.tr().toString(),
              style: TextStyle(
                color: Colors.black,
              )),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                left: 8,
              ),
              child: Container(
                  height: 20,
                  width: 20,
                  child: GestureDetector(
                      onTap: () async {
                        final result =
                            await Navigator.of(context).pushNamed('/Whishlist');
                        if (result == "pop") _getProductDetail();
                      },
                      child: Image.asset(
                        "assets/heart.png",
                        color: appPrimaryMaterialColor,
                      ))),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 4, top: 18),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: GestureDetector(
                          onTap: () async {
                            final result = await Navigator.of(context)
                                .pushNamed('/CartScreen');
                            if (result == "pop") _getProductDetail();
                          },
                          child: Image.asset(
                            "assets/shopping-cart.png",
                            color: appPrimaryMaterialColor,
                          ))),
                ),
                // IconButton(
                //     icon: Icon(Icons.card_travel),
                //     onPressed: () async {
                //       final result =
                //           await Navigator.of(context).pushNamed('/CartScreen');
                //       if (result == "pop") _getProductDetail();
                //     }),
                if (cartList.length > 0)
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 18.0, left: 4, top: 13),
                    child: CircleAvatar(
                      radius: 6.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        cartList.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
              ],
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
                                  // border: Border.all(color: Colors.grey[300]),
                                  color: appPrimaryMaterialColor),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : Text(
                                                "Add to Cart",
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
                                                                    15.0)),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Text(
                                              'Select_Quantity'.tr().toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: <Widget>[
                                                IconButton(
                                                  icon:
                                                      Icon(Icons.remove_circle),
                                                  onPressed: () {
                                                    minus();
                                                  },
                                                  color:
                                                      appPrimaryMaterialColor,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, right: 8),
                                                  child: Text('$_m'),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.add_circle),
                                                  onPressed: () {
                                                    add();
                                                  },
                                                  color:
                                                      appPrimaryMaterialColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Text(
                                              'View_Catalogue'.tr().toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0,
                                                top: 5,
                                                bottom: 8,
                                                right: 8),
                                            child: SizedBox(
                                              height: 30,
                                              width: 90,
                                              child: FlatButton(
                                                //color: appPrimaryMaterialColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    side: BorderSide(
                                                        color:
                                                            Colors.grey[300])),
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
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                  } else
                                                    Fluttertoast.showToast(
                                                        msg: "file not found");
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 2.0),
                                                      child: Icon(
                                                        Icons.details,
                                                        //color: Colors.white),
                                                        color: Colors.grey[700],
                                                        size: 16,
                                                      ),
                                                    ),
                                                    Text(
                                                      "View",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        //color: Colors.white,
                                                        color: Colors.grey[700],
//                                                          fontWeight:
//                                                              FontWeight.bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 20,
                          color: Colors.grey[100],
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
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
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
                                        // itemCount: 5,
                                        itemCount: rateList.length,
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
                                                      fontSize: 30,
                                                      color: Colors.grey[700],
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 15,
                                                  color:
                                                      appPrimaryMaterialColor,
                                                ),
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
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                      "No Rating &  Review Found!!!",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 25,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey[300],
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        "See more",
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

  _getCart() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isGetCartLoading = true;
        SharedPreferences pref = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap(
            {"customerId": pref.getString(Session.CustomerId)});
        Services.PostForList(api_name: 'get_data_where/tblcart', body: body)
            .then((responseList) async {
          setState(() {
            isGetCartLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              cartList = responseList; //set "data" here to your variable
            });
          } else {
            setState(() {
              isGetCartLoading = false;
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isGetCartLoading = false;
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
            if (isCartList == true) {
              Fluttertoast.showToast(msg: "Added to Cart");
            } else {
              Fluttertoast.showToast(msg: "Already in Cart");
            }
            total();
            _getCart();
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

class AlertViewCatalogue extends StatefulWidget {
  var viewCatData;

  AlertViewCatalogue({this.viewCatData});

  @override
  _AlertViewCatalogueState createState() => _AlertViewCatalogueState();
}

class _AlertViewCatalogueState extends State<AlertViewCatalogue> {
  List getCatalogue = [];

  //bool isSelectLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    // _getAddress();
    print(widget.viewCatData);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        "View Catalogue",
        style: TextStyle(
            fontSize: 22,
            color: appPrimaryMaterialColor,
            fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Text("${widget.viewCatData["ProductCatlogPDF"]}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            )),
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

//  _getAddress() async {
//    try {
//      final result = await InternetAddress.lookup('google.com');
//      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        isSelectLoading = true;
//
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//
//        FormData body = FormData.fromMap({
//          "CustomerId": prefs.getString(Session.CustomerId),
//        });
//        Services.PostForList(api_name: 'getAddress', body: body).then(
//            (addResponseList) async {
//          setState(() {
//            isSelectLoading = false;
//          });
//          if (addResponseList.length > 0) {
//            setState(() {
//              getAddressList = addResponseList;
//            });
//          } else {
//            Fluttertoast.showToast(msg: "Data Not Found");
//            //show "data not found" in dialog
//          }
//        }, onError: (e) {
//          setState(() {
//            isSelectLoading = false;
//          });
//          print("error on call -> ${e.message}");
//          Fluttertoast.showToast(msg: "Something Went Wrong");
//        });
//      }
//    } on SocketException catch (_) {
//      Fluttertoast.showToast(msg: "No Internet Connection.");
//    }
//  }
}
