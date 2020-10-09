import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Screens/Address%20Screen.dart';
import 'package:balaji/Screens/SearchingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isSearching = false;
  bool searchImage = true;
  TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget appBarTitle = Text(
      //'home1'.tr().toString(),
      "Profile",
      style: TextStyle(
          color: appPrimaryMaterialColor,
          //fontFamily: 'RobotoSlab',
          // color: Colors.black,
          fontSize: 17),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedIconTheme: IconThemeData(color: appPrimaryMaterialColor),
        //   unselectedIconTheme: IconThemeData(color: Colors.grey),
        //   items:  <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //
        //         icon:Container(
        //           height: 20,
        //           width: 20,
        //           child: Image.asset(
        //             "assets/012-house.png",
        //             color: appPrimaryMaterialColor,
        //           ),
        //         ),
        //         title: Text("Home")),
        //     BottomNavigationBarItem(
        //         icon: Container(
        //           height: 20,
        //           width: 20,
        //           child: Image.asset(
        //             "assets/020-heart.png",
        //             color: appPrimaryMaterialColor,
        //           ),
        //         ),
        //         title: Text("Wishlist")),
        //     BottomNavigationBarItem(
        //         icon: Container(
        //           height: 20,
        //           width: 20,
        //           child: Image.asset(
        //             "assets/051-user.png",
        //             color: appPrimaryMaterialColor,
        //           ),
        //         ),
        //         title: Text("Profile")),
        //     BottomNavigationBarItem(
        //         icon: Container(
        //           height: 20,
        //           width: 20,
        //           child: Image.asset(
        //             "assets/018-settings.png",
        //             color: appPrimaryMaterialColor,
        //           ),
        //         ),
        //         title: Text("Setting")),
        //   ],
        //   //currentIndex: _selectedIndex,
        //   selectedItemColor: appPrimaryMaterialColor,
        //  // onTap: _onItemTapped,
        // ),
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: appBarTitle,
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: new IconThemeData(color: appPrimaryMaterialColor),
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
                    width: MediaQuery.of(context).size.width - 80,
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
            // searchImage
            //     ? Padding(
            //         padding: const EdgeInsets.only(
            //           right: 10.0,
            //           left: 8,
            //         ),
            //         child: Container(
            //             height: 20,
            //             width: 20,
            //             child: GestureDetector(
            //                 onTap: () {
            //                   Navigator.of(context).pushNamed('/Whishlist');
            //                 },
            //                 child: Image.asset(
            //                   "assets/heart.png",
            //                   color: appPrimaryMaterialColor,
            //                 ))),
            //       )
            //     : Container(),
            searchImage
                ? Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15.0, left: 8, top: 18),
                        child: Container(
                            height: 20,
                            width: 20,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/CartScreen');
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
          ],
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.7,
              child: Container(
                color: appPrimaryMaterialColor,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.8,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 140.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/ProfileScreen');
                          },
                          child: ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 4),
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    "assets/edit.png",
                                    color: appPrimaryMaterialColor,
                                  )),
                            ),
                            title: Text(
                              'drw_edit_profile'.tr().toString(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new AddressScreen()));
                          },
                          child: ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 4),
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    "assets/location.png",
                                    color: appPrimaryMaterialColor,
                                  )),
                            ),
                            title: Text(
                              'drw_manage_address'.tr().toString(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Divider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/HistoryScreen');
                          },
                          child: ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 4),
                              child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    "assets/history.png",
                                    color: appPrimaryMaterialColor,
                                  )),
                            ),
                            title: Text(
                              'drw_order_history'.tr().toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 65.0),
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height / 3.3,
                  width: MediaQuery.of(context).size.width - 70,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 200.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(30),
                            //color: Colors.white,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: appPrimaryMaterialColor[600]),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://static1.bigstockphoto.com/8/2/3/large1500/328918366.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        "Rinki Sharma",
                        style: TextStyle(
                            fontSize: 18,
                            color: appPrimaryMaterialColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
