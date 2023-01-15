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
    _latitude = await locationPreferences.getLocationLatitude();
    _longitude = await locationPreferences.getLocationLatitude();
    print("Provider -> $_latitude..$_longitude");
  }

  List<WeatherModel> _listWeatherModel = [];
  List<WeatherModel> get listWeatherModel => _listWeatherModel;

  getWeatherInfoByLatLang() async {
    _listWeatherModel.clear();
    try {
      _listWeatherModel = await services.getCurrentWeatherByLocation(
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
