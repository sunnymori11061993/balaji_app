import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String pricefilter = '';
  String fabricfilter = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: appPrimaryMaterialColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(
          color: appPrimaryMaterialColor,
        ),
        title: const Text('Filter',
            style: TextStyle(
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: ListView(
//          padding: EdgeInsets.zero,
        children: <Widget>[
//            DrawerHeader(
//              child:
//            ),

          ListTile(
            title: Text(
              "Price Filter",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
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
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
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
            padding:
                const EdgeInsets.only(left: 8.0, right: 8, top: 60, bottom: 30),
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
    );
  }
}
