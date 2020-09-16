import 'package:flutter/material.dart';

class BottomCategory extends StatefulWidget {
  @override
  _BottomCategoryState createState() => _BottomCategoryState();
}

class _BottomCategoryState extends State<BottomCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: new IconThemeData(color: Colors.grey),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Navigator.of(context).pushNamed('/Whishlist');
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
