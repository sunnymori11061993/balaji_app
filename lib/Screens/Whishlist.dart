import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/WishlistComponent.dart';
import 'package:balaji/Screens/SearchingScreen.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Whishlist extends StatefulWidget {
  @override
  _WhishlistState createState() => _WhishlistState();
}

class _WhishlistState extends State<Whishlist> {
  bool isLoading = true;
  List wishList = [];
  TextEditingController txtSearch = TextEditingController();
  bool searchImage = true;

  @override
  void initState() {
    _wishList();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBarTitle = Text(
      'Wishlist'.tr().toString(),
      style: TextStyle(
          color: appPrimaryMaterialColor,
          //fontFamily: 'RobotoSlab',
          // color: Colors.black,
          fontSize: 17),
    );
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop("pop");
      },
      child: Scaffold(
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
            title: appBarTitle,
            actions: <Widget>[
              if (searchImage == false)
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        "assets/search.png",
                        color: appPrimaryMaterialColor,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 120,
                      height: 50,
                      child: TextFormField(
                        controller: txtSearch,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (aa) {
                          //  _getSearching();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                  new SearchingScreen(
                                    searchData: txtSearch.text,
                                  )));
                          txtSearch.clear();
                          //Navigator.pop(context, this.txtSearch.text);
                        },
                        style: TextStyle(
                          //color: Colors.white,
                        ),
                        cursorColor: appPrimaryMaterialColor,
                        decoration: InputDecoration(
                          // prefixIcon: SizedBox(
                          //   height: 20,
                          //   width: 10,
                          //   child: Image.asset(
                          //     "assets/search.png",
                          //     color: appPrimaryMaterialColor,
                          //   ),
                          // ),

                            hintText: "    Search...",
                            hintStyle: TextStyle(color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            )),
                      ),
                    ),
                  ],
                ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    searchImage = !searchImage;
                  });
                },
                child: searchImage
                    ? Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      "assets/search.png",
                      color: appPrimaryMaterialColor,
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      "assets/025-cancel.png",
                      color: appPrimaryMaterialColor,
                    ),
                  ),
                ),
              ),
              searchImage
                  ? Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                  left: 8,
                ),
                child:Container(
                        height: 20,
                        width: 20,
                        child: GestureDetector(
                            onTap: () {
                              //Navigator.of(context).pushNamed('/Whishlist');
                            },
                            child: Image.asset(
                              "assets/020-heart.png",
                              color: appPrimaryMaterialColor,
                            ))),
              )
                  : Container(),
              searchImage
                  ? Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(right: 15.0, left: 8, top: 18),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/CartScreen');
                            },
                            child: Image.asset(
                              "assets/shopping-cart.png",
                              color: appPrimaryMaterialColor,
                            ))),
                  ),
                  // if (cartList.length > 0)
                  //   Padding(
                  //     padding: const EdgeInsets.only(
                  //         left: 0.0, top: 13, right: 10),
                  //     child: CircleAvatar(
                  //       radius: 6.0,
                  //       backgroundColor: Colors.red,
                  //       foregroundColor: Colors.white,
                  //       child: Text(
                  //         cartList.length.toString(),
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 10.0,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                ],
              )
                  : Container(),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     right: 10.0,
              //     left: 8,
              //   ),
              //   child: Container(
              //       height: 20,
              //       width: 20,
              //       child: GestureDetector(
              //           onTap: () {
              //             //Navigator.of(context).pushNamed('/Whishlist');
              //           },
              //           child: Image.asset(
              //             "assets/020-heart.png",
              //             color: appPrimaryMaterialColor,
              //           ))),
              // ),
              // Stack(
              //   alignment: Alignment.topCenter,
              //   children: [
              //     Padding(
              //       padding:
              //           const EdgeInsets.only(right: 15.0, left: 8, top: 18),
              //       child: Container(
              //           height: 20,
              //           width: 20,
              //           child: GestureDetector(
              //               onTap: () {
              //                 Navigator.of(context).pushNamed('/CartScreen');
              //               },
              //               child: Image.asset(
              //                 "assets/shopping-cart.png",
              //                 color: appPrimaryMaterialColor,
              //               ))),
              //     ),
              //
              //     // if (cartList.length > 0)
              //     //   Padding(
              //     //     padding: const EdgeInsets.only(
              //     //         left: 0.0, top: 13, right: 10),
              //     //     child: CircleAvatar(
              //     //       radius: 6.0,
              //     //       backgroundColor: Colors.red,
              //     //       foregroundColor: Colors.white,
              //     //       child: Text(
              //     //         cartList.length.toString(),
              //     //         style: TextStyle(
              //     //           fontWeight: FontWeight.bold,
              //     //           fontSize: 10.0,
              //     //         ),
              //     //       ),
              //     //     ),
              //     //   ),
              //   ],
              // )
            ],
          ),
          body: isLoading
              ? LoadingComponent()
              : wishList.length > 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                      child: ListView.separated(
                        itemCount: wishList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return WishlistComponent(
                            wishListData: wishList[index],
                            onRemove: () {
                              setState(() {
                                wishList.removeAt(index);
                              });
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          thickness: 2,
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                      "Wishlist Data Not Found!!!",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600),
                    ))),
    );
  }

  _wishList() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });

        SharedPreferences pref = await SharedPreferences.getInstance();
        FormData body = FormData.fromMap(
            {"customerId": pref.getString(Session.CustomerId)});
        Services.PostForList(api_name: 'get_data_where/tblwishlist', body: body)
            .then((responseList) async {
          setState(() {
            isLoading = false;
          });
          if (responseList.length > 0) {
            setState(() {
              wishList = responseList;
              //set "data" here to your variable
            });
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
