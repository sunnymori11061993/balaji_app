import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String lang;

  _language() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String lang1;
      lang1 = prefs.getString(Session.langauge);
      lang1 != null ? lang = lang1 : lang = "p1";
      prefs.setString(Session.langauge, lang);
    });
  }

  @override
  void initState() {
    _language();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryMaterialColor,
      body: Stack(
        children: [
          Positioned.fill(
            //
            child: Image(
              image: AssetImage('assets/backchange.png'),
              fit: BoxFit.fill,
            ),
          ),
          Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 90,
              ),
              Center(
                child: Text("Select your preferred language ",
                    style: TextStyle(
                        color: Color(0xFF9f782d),
                        fontSize: 19,
                        fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.0, left: 10, right: 10),
                child: Text(
                    "To change it later, go to Settings -> Change Language",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: ListTile(
                  title: Theme(
                    data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white,
                        disabledColor: Colors.white),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 43,
                          child: RadioListTile(
                            activeColor: Colors.white,
                            groupValue: lang,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('English'.tr().toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                Text('English',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            value: 'p1',
                            onChanged: (val) {
                              setState(() {
                                lang = val;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: Container(
                            height: 45,
                            child: RadioListTile(
                              activeColor: Colors.white,
                              groupValue: lang,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hindi'.tr().toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                  Text("हिंदी",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              value: 'p2',
                              onChanged: (val) {
                                setState(() {
                                  lang = val;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 65.0),
                child: Container(
                  height: 40,
                  width: 160,
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Text(
                          'CONTINUE'.tr().toString(),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                    onPressed: () async {
                      if (lang == 'p1') {
                        EasyLocalization.of(context).locale =
                            Locale('en', 'US');
                      } else {
                        EasyLocalization.of(context).locale =
                            Locale('hi', 'HI');
                      }
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString(Session.langauge, lang);
                      Navigator.pushReplacementNamed(
                          context, '/WalkThroughScreen');
                    },
                    color: Color(0xFF9f782d),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
