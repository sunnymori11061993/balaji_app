import 'package:flutter/material.dart';

class CartSelectionComponent extends StatefulWidget {
  var colors;
  var category;
  CartSelectionComponent(this.colors, this.category);

  @override
  _CartSelectionComponentState createState() => _CartSelectionComponentState();
}

class _CartSelectionComponentState extends State<CartSelectionComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: colors[index],
      color: widget.colors,
      height: 150,
      child: Center(
          child: Text(
        widget.category,
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      )),
    );
  }
}
