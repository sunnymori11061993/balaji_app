import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Screens/SubCategory.dart';
import 'package:flutter/material.dart';

class CategoriesComponent extends StatefulWidget {
  var catData;

  CategoriesComponent(this.catData);

  @override
  _CategoriesComponentState createState() => _CategoriesComponentState();
}

class _CategoriesComponentState extends State<CategoriesComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                new SubCategory(catId: widget.catData["CategoryId"])));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 70,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[300]),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  Image_URL + "${widget.catData["CategoryImage"]}",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "${widget.catData["CategoryName"]}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
