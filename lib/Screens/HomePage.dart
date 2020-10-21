import 'dart:developer';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Screens/Home.dart';
import 'package:balaji/Screens/SettingScreen.dart';
import 'package:balaji/Screens/UserProfileScreen.dart';
import 'package:balaji/Screens/Whishlist.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class HomePage extends StatelessWidget {
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
        builder: Builder(builder: (context) => HomePage1()),
        autoPlay: true,
        autoPlayDelay: Duration(seconds: 3),
        autoPlayLockEnable: true,
      ),
    );
  }
}

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  GlobalKey _five = GlobalKey();

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
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context)
            .startShowCase([_one, _two, _three, _four, _five]));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: appPrimaryMaterialColor,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    _selectedIndex == 0
                        ? "assets/012-house.png"
                        : "assets/home.png",
                    color: Colors.white,
                  ),
                ),
              ),
              label: '',
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
              label: '',
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
              label: '',
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
              label: '',
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
