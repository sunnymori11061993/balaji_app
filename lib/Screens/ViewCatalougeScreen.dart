import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';

class ViewCatalougeScreen extends StatefulWidget {
  var path, catData;

  ViewCatalougeScreen({this.path, this.catData});

  @override
  _ViewCatalougeScreenState createState() => _ViewCatalougeScreenState();
}

class _ViewCatalougeScreenState extends State<ViewCatalougeScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  var imageUrl;

  bool downloading = false;
  String downloadingStr = "No data";
  double download = 0.0;
  File f;

  Future<void> downloadFile() async {
    try {
      Dio dio = Dio();
      var dir = await getApplicationDocumentsDirectory();
      f = File("${dir.path}/myimagepath.jpg");
      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
      dio.download(imageUrl, "${dir.path}/$fileName",
          onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          download = (rec / total) * 100;
          downloadingStr =
              "Downloading Image : " + (download).toStringAsFixed(0);
        });

        setState(() {
          downloading = false;
          downloadingStr = "Completed";
        });
      });
    } catch (e) {
      setState(() {
        downloading = false;
      });
      print(e.getMessage());
    }
  }

  @override
  void initState() {
    log(widget.path);
    imageUrl = widget.catData;
    //downloadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Catalogue'.tr().toString(),
            style: TextStyle(color: appPrimaryMaterialColor, fontSize: 17)),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 5, bottom: 8),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Image.asset(
                "assets/backarrow.png",
                //color: appPrimaryMaterialColor,
              )),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              downloadFile();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                left: 13,
              ),
              child: Container(
                  height: 20,
                  width: 20,
                  child: downloading
                      ? LoadingComponent()
                      : Image.asset(
                          "assets/download.png",
                          color: appPrimaryMaterialColor,
                        )),
            ),
          ),
        ],
      ),
      body: PDFView(
        filePath: widget.path,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onRender: (_pages) {
          setState(() {
            pages = _pages;
            isReady = true;
          });
        },
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController pdfViewController) {
          _controller.complete(pdfViewController);
        },
        onPageChanged: (int page, int total) {
          print('page change: $page/$total');
        },
      ),
    );
  }
}
