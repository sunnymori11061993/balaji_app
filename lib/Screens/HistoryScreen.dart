import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/HistoryComponent.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text("Order History",
            style: TextStyle(
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView.separated(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return HistoryComponent();
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            thickness: 2,
          ),
        ),
      ),
    );
  }
}
