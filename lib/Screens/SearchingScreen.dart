import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/SubCategoriesComponent.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  }

  @override
  Widget build(BuildContext context) {
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
        iconTheme: new IconThemeData(color: Colors.grey),
        title: const Text(
          "Searched Products",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: isSearchLoading
          ? LoadingComponent()
          : Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GridView.builder(
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
        isSearchLoading = true;
        FormData body = FormData.fromMap({"ProductName": widget.searchData});
        Services.PostForList(api_name: 'search', body: body).then(
            (responseList) async {
          setState(() {
            isSearchLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              searchList = responseList; //set "data" here to your variable
            });
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
