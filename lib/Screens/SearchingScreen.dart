import 'dart:developer';
import 'dart:io';
import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/SubCategoriesComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:easy_localization/easy_localization.dart';

class SearchingScreen extends StatefulWidget {
  var searchData;

  SearchingScreen({this.searchData});

  @override
  _SearchingScreenState createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  List searchList = [];
  bool isSearchLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    _getSearching();
    print("======searchData :${widget.searchData}");
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
        iconTheme: new IconThemeData(color: appPrimaryMaterialColor),
        title: Text(
          'Product_Detail'.tr().toString(),
          style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/HomePage');
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
          )
        ],
      ),
      body: isSearchLoading
          ? LoadingComponent()
          : Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                //physics: NeverScrollableScrollPhysics(),
                //shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.58,
                    //widthScreen / heightScreen,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0),
                itemBuilder: (BuildContext context, int index) {
                  return SubCategoriesComponent(
                    subCat: searchList[index],
                  );
                },
                itemCount: searchList.length,
              )),
    );
  }

  _getSearching() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({
          "ProductName": widget.searchData,
          // "SubcategoryId": widget.searchData["SubcategoryId"]
        });

        Services.PostForList(api_name: 'search', body: body).then(
            (responseList) async {
          setState(() {
            isSearchLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              searchList = responseList; //set "data" here to your variable
            });
            log("body==========${responseList}");
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isSearchLoading = false;
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
