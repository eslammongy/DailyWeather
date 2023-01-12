import 'package:daily_weather/models/weather_model.dart';
import 'package:daily_weather/services/weather_services.dart';
import 'package:daily_weather/utils/location_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherProvider extends ChangeNotifier {
  double _latitude = 0.0;
  double get latitude => _latitude;

  double _longitude = 0.0;
  double get longitude => _longitude;

  getUserLocationData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LocationPreferences locationPreferences =
        LocationPreferences(sharedPreferences: sharedPreferences);
    _latitude = await locationPreferences.getLocationLatitude();
    _longitude = await locationPreferences.getLocationLatitude();
    // print("Provider -> $_latitude..$_longitude");
    notifyListeners();
  }

  List<WeatherModel>? _weatherModels = [];
  List<WeatherModel> get weatherModels => _weatherModels!;

  getWeatherInfo() async {
    WeatherServices services = WeatherServices();
    _weatherModels = await services.getCurrentWeatherByLocation(
        lat: _latitude, long: _longitude);
  }
}
