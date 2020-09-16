import 'package:balaji/Common/Constants.dart';
import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
      ),
    );
  }
}
