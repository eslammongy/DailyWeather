import 'dart:io';

import 'package:daily_weather/models/weather_model.dart';
import 'package:daily_weather/services/weather_services.dart';
import 'package:daily_weather/utils/location_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/failure.dart';

class WeatherProvider extends ChangeNotifier {
  String? cityName;

  double _latitude = 0.0;
  double get latitude => _latitude;
  set setLatitude(double lat) {
    _latitude = lat;
  }

  double _longitude = 0.0;
  double get longitude => _longitude;
  set setLongitude(double longitude) {
    _longitude = longitude;
    notifyListeners();
  }

  WeatherServices services = WeatherServices();
  getUserLocationData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LocationPreferences locationPreferences =
        LocationPreferences(sharedPreferences: sharedPreferences);
    await locationPreferences.getLocationLatitude().then((value) {
      _latitude = value;
    });
    await locationPreferences.getLocationLatitude().then((value) {
      _longitude = value;
      print("Provider -> $_latitude..$_longitude");
      notifyListeners();
    });
  }

  List<WeatherModel> _listWeatherModel = [];
  List<WeatherModel> get listWeatherModel => _listWeatherModel;

  List<WeatherModel> _listWeatherModelLatLang = [];
  List<WeatherModel> get listWeatherModelLatLang => _listWeatherModelLatLang;

  getWeatherInfoByLatLang() async {
    _listWeatherModel.clear();
    try {
      _listWeatherModelLatLang = await services.getCurrentWeatherByLocation(
          lat: _latitude, long: _longitude);
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  getWeatherInfoByCityName(String city) async {
    try {
      _listWeatherModel = await services.getCurrentWeatherData(cityName: city);
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }
}
