import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/SubCategoriesComponent.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubCategory extends StatefulWidget {
  var catId;

  SubCategory({this.catId});

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory>
    with TickerProviderStateMixin {
  TabController _tabController;

  List filterList = [
    {
      "title": "Prices",
      "type": "radio",
      "values": [
        "100",
        "200",
        "300",
      ],
    },
    {
      "title": "Fabrics",
      "type": "checkbox",
      "values": [
        "cotton",
        "silk",
        "other",
      ],
    },
    {
      "title": "Offers",
      "type": "radio",
      "values": [
        "5%",
        "20%",
        "30%",
      ],
    },
  ];

  @override
  void initState() {
    super.initState();

    _subCatTab();
    print(widget.catId);
    _getCart();
  }

  _tabCon() {
    _tabController = TabController(
      vsync: this,
      length: subCategoriesTab.length,
    );
    _tabController.addListener(() {
      _subCategory(subCategoriesTab[_tabController.index]["SubcategoryId"]);
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String pricefilter = '';
  String fabricfilter = '';
  List subCategoriesList = [];
  List subCategoriesTab = [];
  bool isLoadingCat = true;
  bool isLoadingPro = false;
  TextStyle tabStyle = TextStyle(fontSize: 16);
  List cartList = [];
  bool isGetCartLoading = true;

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(
              "assets/backarrow.png",
              //color: appPrimaryMaterialColor,
            )),

//        IconButton(
//            icon: Icon(
//              Icons.arrow_back_ios,
//              color: appPrimaryMaterialColor,
//            ),
//            onPressed: () {
//              Navigator.of(context).pop();
//            }),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: appPrimaryMaterialColor,
        ),
        title: Text('Sub_Category'.tr().toString(),
            style: TextStyle(
              color: appPrimaryMaterialColor,
            )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
              left: 8,
            ),
            child: Container(
                height: 20,
                width: 20,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Whishlist');
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
                padding: const EdgeInsets.only(right: 10.0, left: 8, top: 18),
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
              // IconButton(
              //   icon: Icon(Icons.card_travel),
              //   onPressed: () {
              //     Navigator.of(context).pushNamed('/CartScreen');
              //   },
              // ),
              if (cartList.length > 0)
                Padding(
                  padding: const EdgeInsets.only(left: 0.0, top: 13, right: 5),
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
          ),

          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 4),
            child: Container(
                height: 20,
                width: 20,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _scaffoldKey.currentState.openEndDrawer();
                      });
                    },
                    child: Image.asset(
                      "assets/filter.png",
                      color: appPrimaryMaterialColor,
                    ))),
          ),
//          IconButton(
//            icon: Icon(Icons.filter),
//            onPressed: () {
//              _scaffoldKey.currentState.openEndDrawer();
//            },
//          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
//          padding: EdgeInsets.zero,
          children: <Widget>[
//            DrawerHeader(
//              child:
//            ),

            ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 20,
                    color: appPrimaryMaterialColor,
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Text("Filter Products",
                      style: TextStyle(
                          color: appPrimaryMaterialColor, fontSize: 18)),
                ),
              ),
            ),
            Divider(
              indent: 10,
              thickness: 1,
              endIndent: 10,
            ),
            ListTile(
              title: Text(
                "Price Filter",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            ListTile(
              title: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: pricefilter,
                      title: Text('100 - 350',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      value: 'p1',
                      onChanged: (val) {
                        setState(() {
                          pricefilter = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: pricefilter,
                      title: Text('350 - 560',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      value: 'p2',
                      onChanged: (val) {
                        setState(() {
                          pricefilter = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: pricefilter,
                      title: Text('560 - 850',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      value: 'p3',
                      onChanged: (val) {
                        setState(() {
                          pricefilter = val;
                        });
                      },
                    ),
                  ),
                  RadioListTile(
                    activeColor: appPrimaryMaterialColor,
                    groupValue: pricefilter,
                    title: Text('850 - Above',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    value: 'p4',
                    onChanged: (val) {
                      setState(() {
                        pricefilter = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "Fabric Filter",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            ListTile(
              title: Column(
                children: <Widget>[
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: fabricfilter,
                      title: Text('Dhakai',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      value: 'f1',
                      onChanged: (val) {
                        setState(() {
                          fabricfilter = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: fabricfilter,
                      title: Text('Litchi',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      value: 'f2',
                      onChanged: (val) {
                        setState(() {
                          fabricfilter = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: fabricfilter,
                      title: Text('Cotton / Slab',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      value: 'f3',
                      onChanged: (val) {
                        setState(() {
                          fabricfilter = val;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    child: RadioListTile(
                      activeColor: appPrimaryMaterialColor,
                      groupValue: fabricfilter,
                      title: Text('Digital',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      value: 'f4',
                      onChanged: (val) {
                        setState(() {
                          fabricfilter = val;
                        });
                      },
                    ),
                  ),
                  RadioListTile(
                    activeColor: appPrimaryMaterialColor,
                    groupValue: fabricfilter,
                    title: Text('Fancy',
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    value: 'f5',
                    onChanged: (val) {
                      setState(() {
                        fabricfilter = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 90),
              child: Container(
                height: 40,
                child: RaisedButton(
                  color: appPrimaryMaterialColor,
                  onPressed: () {},
                  child: Text(
                    "APPLY",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: isLoadingCat
          ? LoadingComponent()
          : Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            unselectedLabelColor: appPrimaryMaterialColor[700],
                            labelColor: Colors.white,
                            indicatorColor: appPrimaryMaterialColor,
                            indicator: new BubbleTabIndicator(
                              indicatorHeight: 35.0,
                              indicatorColor: appPrimaryMaterialColor,
                              tabBarIndicatorSize: TabBarIndicatorSize.tab,
                            ),
                            onTap: (index) {
                              _subCategory(
                                  subCategoriesTab[index]["SubcategoryId"]);
                            },
                            tabs: List<Widget>.generate(subCategoriesTab.length,
                                (int index) {
                              return Tab(
                                child: Text(
                                  subCategoriesTab[index]["SubcategoryName"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Divider(),
                      Flexible(
                        child: TabBarView(
                            controller: _tabController,
                            children: List<Widget>.generate(
                                subCategoriesTab.length, (int index) {
                              return isLoadingPro
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          appPrimaryMaterialColor),
                                    ))
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.56,
                                              //widthScreen / heightScreen,
                                              crossAxisSpacing: 2.0,
                                              mainAxisSpacing: 2.0),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SubCategoriesComponent(
                                          subCat: subCategoriesList[index],
                                        );
                                      },
                                      itemCount: subCategoriesList.length,
                                    );
                            })),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  _subCategory(var subcatId) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoadingPro = true;
        });
        FormData body = FormData.fromMap({"subcategoryId": "${subcatId}"});
        print(body.fields);
        Services.PostForList(api_name: 'get_data_where/tblproduct', body: body)
            .then((subCatResponseList) async {
          setState(() {
            isLoadingPro = false;
          });
          if (subCatResponseList.length > 0) {
            setState(() {
              subCategoriesList = subCatResponseList;
              //set "data" here to your variable
            });
          } else {
            setState(() {
              subCategoriesList = [];
            });
            Fluttertoast.showToast(msg: "Data Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoadingPro = false;
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

  _subCatTab() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        FormData body = FormData.fromMap({"categoryId": widget.catId});
        Services.PostForList(
                api_name: 'get_data_where/tblsubcategory', body: body)
            .then((tabResponseList) async {
          setState(() {
            isLoadingCat = false;
          });
          if (tabResponseList.length > 0) {
            print("anirudh");
            setState(() {
              subCategoriesTab = tabResponseList;
              //set "data" here to your variable
            });

            _subCategory(tabResponseList[0]["SubcategoryId"]);
            _tabCon();
          } else {
            setState(() {
              isLoadingCat = false;
            });
            Fluttertoast.showToast(msg: "Product Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoadingCat = false;
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
