// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:daily_weather/models/weather_model.dart';
import 'package:daily_weather/utils/utils.dart';
import 'package:http/http.dart' as http_client;

class WeatherServices {
  void getCurrentWeatherData({required String cityName}) async {
    Uri url = Uri.parse(
        "${baseUrl}forecast?q=$cityName&cnt=7&units=metric&appid=$ApiKey");
    http_client.Response response = await http_client.get(url);

    Map<String, dynamic> result = jsonDecode(response.body);
  }

  Future<List<WeatherModel>> getCurrentWeatherByLocation(
      {required lat, required long}) async {
    Uri url = Uri.parse(
        "${baseUrl}forecast?lat=$lat&lon=$long&cnt=6&units=metric&appid=$ApiKey");
    http_client.Response response = await http_client.get(url);

    Map<String, dynamic> result = jsonDecode(response.body);
    List<WeatherModel> dailyWeather = WeatherModel.fromForecastJson(result);
    return dailyWeather;
  }
}
