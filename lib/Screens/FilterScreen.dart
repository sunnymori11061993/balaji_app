import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/SubCategoriesComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List filterList = [];
  bool isFilterLoading = true;

  @override
  void initState() {
    _setFilter();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider provider = Provider.of<CartProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop("pop");
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
        title: Text(
          //'My_Cart'.tr().toString(),
          'Product_Detail'.tr().toString(),
          style: TextStyle(
              color: appPrimaryMaterialColor,
              //fontFamily: 'RobotoSlab',
              // color: Colors.black,
              fontSize: 17),
        ),
        actions: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 8, top: 18),
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
                      padding:
                          const EdgeInsets.only(left: 1.0, top: 13, right: 10),
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
      ),
      body: isFilterLoading
          ? LoadingComponent()
          : Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
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
                    subCat: filterList[index],
                  );
                },
                itemCount: filterList.length,
              )),
    );
  }

  _setFilter() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({
          // "ProductName": widget.searchData
        });
        Services.PostForList(api_name: 'search', body: body).then(
            (responseList) async {
          setState(() {
            isFilterLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              filterList = responseList; //set "data" here to your variable
            });
          } else {
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isFilterLoading = false;
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
