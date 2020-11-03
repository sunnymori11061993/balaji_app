import 'package:balaji/Screens/Home.dart';
import 'package:balaji/Screens/SubCategory.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 0;

  List<Widget> widgetOptions = <Widget>[
    Home(),
    //SubCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      /*bottomNavigationBar: Theme(
        data:  Theme.of(context).copyWith(
          canvasColor: appPrimaryMaterialColor,
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,color: Colors.white,
                size: 20,
              ),
              title: Text(
                "Home",
                style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,color: Colors.white,
                  size: 20,
                ),
                title: Text(
                  "Categories",
                  style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),
                ),),
            BottomNavigationBarItem(
                icon:
                 SizedBox(
                   height: 23,
                     width: 23,
                     child: Image.asset("assets/filter.png",color: Colors.white)),
                title: Text(
                  "Filters",
                  style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_shopping_cart,
                  size: 20,
                ),
                title: Text(
                  "Orders",
                  style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 20,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600),
                )),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.white,
          unselectedIconTheme: IconThemeData(color: Colors.white),
          // fixedColor: appPrimaryMaterialColor,
          onTap: onItemTapped,
        ),
      ),*/
    );
  }
}
