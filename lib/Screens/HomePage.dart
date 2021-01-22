import 'package:balaji/Screens/Home.dart';
import 'package:balaji/Screens/SettingScreen.dart';
import 'package:balaji/Screens/UserProfileScreen.dart';
import 'package:balaji/Screens/Whishlist.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Whishlist(),
    UserProfileScreen(),
    SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backchange.png"), fit: BoxFit.cover)),
        height: MediaQuery.of(context).size.height * 0.1,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 4),
                child: FittedBox(
                  child: Container(
                    height: 27,
                    width: 27,
                    child: Image.asset(
                      _selectedIndex == 0
                          ? "assets/homefill.png"
                          : "assets/homeunfill2.png",
                      //color: Colors.white,
                    ),
                  ),
                ),
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    _selectedIndex == 1
                        ? "assets/020-heart.png"
                        : "assets/heart.png",
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    _selectedIndex == 2
                        ? "assets/051-user.png"
                        : "assets/user.png",
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    _selectedIndex == 3
                        ? "assets/018-settings.png"
                        : "assets/settings.png",
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(''),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
