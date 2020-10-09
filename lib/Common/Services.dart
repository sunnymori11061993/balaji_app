import 'package:balaji/Common/Constants.dart';
import 'package:dio/dio.dart';

import 'ClassList.dart';

Dio dio = new Dio();

class Services {
  static Future<List> PostForList({api_name, body}) async {
    String url = API_URL + '$api_name';
    print("$api_name url : " + url);
    var response;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }

      if (response.statusCode == 200) {
        List list = [];
        print("$api_name Response: " + response.data.toString());
        var responseData = response.data;
        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          list = responseData["Data"];
        }
        return list;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> postForSave({apiname, body}) async {
    print(body.toString());
    String url = API_URL + '$apiname';
    print("$apiname url : " + url);
    var response;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      if (response.statusCode == 200) {
        SaveDataClass savedata =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: null);
        print("$apiname Response: " + response.data.toString());
        var responseData = response.data;
        savedata.Message = responseData["Message"];
        savedata.IsSuccess = responseData["IsSuccess"];
        savedata.Data = responseData["Data"].toString();

        return savedata;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List<StateClass>> getState() async {
    String url = API_URL + 'getState';
    try {
      Response response = await dio.post(url);
      if (response.statusCode == 200) {
        StateClassData stateClassData =
            new StateClassData.fromJson(response.data);
        return stateClassData.Data;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List<CityClass>> getCity({body}) async {
    print(body.toString());
    String url = API_URL + 'getCity';

    Response response;
    try {
      if (body == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body);
      }
      // Response response = await dio.post(url);
      if (response.statusCode == 200) {
        CityClassData cityClassData = new CityClassData.fromJson(response.data);
        return cityClassData.Data;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
