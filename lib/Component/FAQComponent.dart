import 'package:flutter/material.dart';

class FAQComponent extends StatefulWidget {
  var faqdata;

  FAQComponent({this.faqdata});

  @override
  _FAQComponentState createState() => _FAQComponentState();
}

class _FAQComponentState extends State<FAQComponent> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: Icon(
        Icons.keyboard_arrow_down,
        size: 30,
        color: Colors.grey,
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.crop_square,
                  color: Colors.grey,
                  size: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "${widget.faqdata["FaqQuestion"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            // Padding(
            //   padding: const EdgeInsets.only(top: 15.0),
            //   child: Container(
            //     height: 0.5,
            //     color: Colors.grey,
            //   ),
            // ),
          ],
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 7, right: 5),
          child: Text(
            "-   " + "${widget.faqdata["FaqAnswer"]}",
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}
