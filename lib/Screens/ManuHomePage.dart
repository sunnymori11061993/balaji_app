import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Screens/ManuHomeScreen.dart';
import 'package:balaji/Screens/ManuProfile.dart';
import 'package:balaji/Screens/ManuSetting.dart';
import 'package:flutter/material.dart';

class ManuHomePage extends StatefulWidget {
  @override
  _ManuHomePageState createState() => _ManuHomePageState();
}

class _ManuHomePageState extends State<ManuHomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ManuHomeScreen(),
    ManuProfile(),
    ManuSetting(),
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
        height: 70,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/backchange.png"), fit: BoxFit.cover)),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
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
                        ? "assets/trend.png"
                        : "assets/trendunfill.png",
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
                    _selectedIndex == 2
                        ? "assets/018-settings.png"
                        : "assets/settings.png",
                    color: Colors.white,
                  ),
                ),
              ),
              label: '',
            ),

            // BottomNavigationBarItem(
            //   icon: Padding(
            //     padding: const EdgeInsets.only(top: 10.0),
            //     child: Container(
            //       height: 20,
            //       width: 20,
            //       child: Image.asset(
            //         _selectedIndex == 3
            //             ? "assets/018-settings.png"
            //             : "assets/settings.png",
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            //   label: '',
            // ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
