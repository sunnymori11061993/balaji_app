import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Common/Services.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/Component/SubCategoriesComponent.dart';
import 'package:balaji/Providers/CartProvider.dart';
import 'package:balaji/Screens/FilterScreen.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class SubCategory extends StatelessWidget {
  var catId;

  SubCategory({this.catId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        onStart: (index, key) {
          log('onStart: $index, $key');
        },
        onComplete: (index, key) {
          log('onComplete: $index, $key');
        },
        builder: Builder(
            builder: (context) => SubCategory11(
                  catId: catId,
                )),
        autoPlay: true,
        autoPlayDelay: Duration(seconds: 3),
      ),
    );
  }
}

class SubCategory11 extends StatefulWidget {
  var catId;

  SubCategory11({this.catId});

  @override
  _SubCategory11State createState() => _SubCategory11State();
}

class _SubCategory11State extends State<SubCategory11>
    with TickerProviderStateMixin {
  TabController _tabController;
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();

  @override
  void initState() {
    super.initState();

    _subCatTab();
    print(widget.catId);
    _getFilter();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_one, _two, _three]));
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
  List selectedList = [];
  Map<String, dynamic> filterMap;
  bool isLoadingCat = true;
  bool isLoadingFilter = true;
  bool isLoadingPro = false;
  bool c1 = false;
  TextStyle tabStyle = TextStyle(fontSize: 16);
  List cartList = [];
  List filterList = [];
  bool isGetCartLoading = true;

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
                Navigator.of(context).pop();
              },
              child: Image.asset(
                "assets/backarrow.png",
                //color: appPrimaryMaterialColor,
              )),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: appPrimaryMaterialColor,
        ),
        title: Text('Sub_Category'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17)),
        actions: <Widget>[
          Showcase(
            key: _one,
            description: 'Tap_to_Filter_products'.tr().toString(),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _scaffoldKey.currentState.openEndDrawer();
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 4, top: 4),
                child: Container(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      "assets/fffffff.png",
                      //color: appPrimaryMaterialColor,
                    )),
              ),
            ),
          ),
          Showcase(
            key: _two,
            description: 'Tap_to_move_towards_home'.tr().toString(),
            child: GestureDetector(
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
          ),
          Showcase(
            key: _three,
            description: 'Tap_to_see_your_cart_products'.tr().toString(),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/CartScreen');
              },
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15.0, left: 12, top: 18),
                    child: Container(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          "assets/shopping-cart.png",
                          color: appPrimaryMaterialColor,
                        )),
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.card_travel),
                  //   onPressed: () {
                  //     Navigator.of(context).pushNamed('/CartScreen');
                  //   },
                  // ),
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
            ),
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
                  child: Text('Filter_Products'.tr().toString(),
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
            isLoadingFilter == true
                ? LoadingComponent()
                : ListView.builder(
                    itemCount: filterList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 20),
                            child: Text(
                              "${filterList[index]["Title"]}",
                              style: TextStyle(
                                  color: appPrimaryMaterialColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          ListView.builder(
                              itemCount: filterList[index]["values"].length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, vindex) {
                                return Container(
                                  height: 40,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      filterList[index]["values"][vindex],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    value: selectedList.contains(
                                        filterList[index]["values"][vindex] +
                                            "#${filterList[index]["Title"]}#"),
                                    //value: true,
                                    activeColor: appPrimaryMaterialColor,
                                    onChanged: (bool val1) {
                                      setState(() {
                                        String value = filterList[index]
                                                ["values"][vindex] +
                                            "#${filterList[index]["Title"]}#";
                                        if (val1) {
                                          selectedList.add(value);
                                        } else {
                                          selectedList.remove(value);
                                        }
                                      });
                                      print(selectedList);
                                    },
                                  ),
                                );
                              }),
                        ],
                      );
                    }),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8, top: 90, bottom: 15),
              child: Container(
                height: 40,
                child: RaisedButton(
                  color: appPrimaryMaterialColor,
                  onPressed: () {
                    //Navigator.of(context).pushNamed('/FilterScreen');
                    Map<String, String> map = {};
                    for (int i = 0; i < selectedList.length; i++) {
                      for (int j = 0; j < filterList.length; j++) {
                        String title = selectedList[i].toString().split("#")[1];
                        String txtValue =
                            selectedList[i].toString().split("#")[0];
                        if (title == filterList[j]["Title"]) {
                          if (map.containsKey(title)) {
                            map.update(
                                title, (value) => value + "," + txtValue);
                          } else {
                            map.addAll({title: txtValue});
                          }
                        }

                        /*if(!map.containsKey(title))
                        map.addAll({title});*/
                        //if(filterList[i]["Title"])
                      }
                    }
                    print(map);
                    if (map.isEmpty) {
                      Fluttertoast.showToast(msg: "Please select any one");
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new FilterScreen(
                                    filterData: map,
                                  )));
                    }
                  },
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
                                      // fontWeight: FontWeight.bold,
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
                            physics: BouncingScrollPhysics(),
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
                                      physics: BouncingScrollPhysics(),
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

  _getFilter() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //FormData body = FormData.fromMap({"categoryId": widget.catId});
        Services.PostForList(api_name: 'getFilter').then((ResponseList) async {
          setState(() {
            isLoadingFilter = false;
          });
          if (ResponseList.length > 0) {
            //print("anirudh");
            setState(() {
              filterList = ResponseList;
              //set "data" here to your variable
            });
          } else {
            setState(() {
              isLoadingFilter = false;
            });
            Fluttertoast.showToast(msg: "Product Not Found");
            //show "data not found" in dialog
          }
        }, onError: (e) {
          setState(() {
            isLoadingFilter = false;
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
