import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/SubCategoriesComponent.dart';
import 'package:balaji/Screens/ProductDetailScreen.dart';
import 'package:flutter/material.dart';

class SearchingScreen extends StatefulWidget {
  List searchData;

  SearchingScreen({this.searchData});
  @override
  _SearchingScreenState createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
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
        iconTheme: new IconThemeData(color: Colors.grey),
        title: const Text(
          "Product Screen",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            //physics: NeverScrollableScrollPhysics(),
            //shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.58,
                //widthScreen / heightScreen,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0),
            itemBuilder: (BuildContext context, int index) {
              return SubCategoriesComponent(
                subCat: widget.searchData[index],
              );
            },
            itemCount: widget.searchData.length,
          )),
    );
  }
}
