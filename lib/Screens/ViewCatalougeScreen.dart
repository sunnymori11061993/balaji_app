import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:balaji/Common/Constants.dart';
import 'package:balaji/Component/LoadingComponent.dart';
import 'package:balaji/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
  var URL;
  bool _permissionReady;

  // List<_TaskInfo> _tasks;
  ReceivePort _port = ReceivePort();
  String _localPath;

  @override
  void initState() {
    log(widget.path);
    URL = Image_URL + widget.catData;
    log(URL);
    _permissionReady = false;
    //localFun();

    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            'Grant_Permission'.tr().toString(),
            style: TextStyle(
              fontSize: 22,
              color: appPrimaryMaterialColor,
              //fontWeight: FontWeight.bold
            ),
          ),
          content: Wrap(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Permission'.tr().toString(),
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text(
                'Cancel'.tr().toString(),
                style: TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
                onPressed: () {
                  _checkPermission().then((hasGranted) {
                    setState(() {
                      _permissionReady = hasGranted;
                    });
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Ok'.tr().toString(),
                  style:
                      TextStyle(color: appPrimaryMaterialColor, fontSize: 18),
                ))
          ],
        );
        ;
      },
    );
  }

  Future<bool> _checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  localFun() async {
    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _requestDownload() async {
    String _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'Download';
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    log(_localPath);
    await FlutterDownloader.enqueue(
      url: URL,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      showNotification: true,
    ).then((value) {
      Fluttertoast.showToast(msg: "Pdf Downloaded Successfully!");
    });
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
              _requestDownload();
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                left: 13,
              ),
              child: Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
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
