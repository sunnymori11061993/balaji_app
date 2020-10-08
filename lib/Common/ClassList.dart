class SaveDataClass {
  String Message;
  bool IsSuccess;
  String Data;

  SaveDataClass({this.Message, this.IsSuccess, this.Data});
}

class StateClassData {
  String Message;
  bool IsSuccess;
  List<StateClass> Data;

  StateClassData({
    this.Message,
    this.IsSuccess,
    this.Data,
  });

  factory StateClassData.fromJson(Map<String, dynamic> json) {
    return StateClassData(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        Data: json['Data']
            .map<StateClass>((singleJson) => StateClass.fromJson(singleJson))
            .toList());
  }
}

class StateClass {
  String stateId;
  String stateName;

  StateClass({this.stateId, this.stateName});

  factory StateClass.fromJson(Map<String, dynamic> json) {
    return StateClass(
        stateId: json['StateId'] as String,
        stateName: json['StateName'] as String);
  }
}

class CityClassData {
  String Message;
  bool IsSuccess;
  List<CityClass> Data;

  CityClassData({
    this.Message,
    this.IsSuccess,
    this.Data,
  });

  factory CityClassData.fromJson(Map<String, dynamic> json) {
    return CityClassData(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        Data: json['Data']
            .map<CityClass>((singleJson) => CityClass.fromJson(singleJson))
            .toList());
  }
}

class CityClass {
  String cityId;
  String cityName;

  CityClass({this.cityId, this.cityName});

  factory CityClass.fromJson(Map<String, dynamic> json) {
    return CityClass(
        cityId: json['CityId'] as String, cityName: json['CityName'] as String);
  }
}
