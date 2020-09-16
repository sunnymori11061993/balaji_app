import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/CartSelectionComponent.dart';
import 'package:flutter/material.dart';

class CartSelectionScreen extends StatefulWidget {
  @override
  _CartSelectionScreenState createState() => _CartSelectionScreenState();
}

class _CartSelectionScreenState extends State<CartSelectionScreen> {
  final List category = [
    'Stone Work',
    'Embrodiary',
    'Jari',
    'Shiffon',
    'Silk',
    'CottonSilk',
    'Cotton'
  ];
  final List<Color> colors = <Color>[
    Colors.deepPurple[300],
    Colors.pink[300],
    Colors.green[300],
    Colors.brown[300],
    Colors.red[300],
    Colors.deepPurple[300],
    Colors.pink[300],
  ];

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
        title: const Text("Categories",
            style: TextStyle(
              color: Colors.black,
            )),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/CartScreen');
        },
        child: ListView.separated(
          itemCount: category.length,
          itemBuilder: (BuildContext context, int index) {
            return CartSelectionComponent(colors[index], category[index]);
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
    );
  }
}
