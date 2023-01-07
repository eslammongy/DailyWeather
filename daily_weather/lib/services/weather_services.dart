import 'dart:convert';

import 'package:daily_weather/utils/utils.dart';
import 'package:http/http.dart' as http_client;

class WeatherServices {
  void getCurrentWeatherData({required String cityName}) async {
    Uri url = Uri.parse("${baseUrl}weather?q=$cityName&appid=$ApiKey");
    http_client.Response response = await http_client.get(url);

    Map<String, dynamic> result = jsonDecode(response.body);

    print(result);
  }

  void getCurrentWeatherByLocation({required lat, required long}) async {
    Uri url = Uri.parse("${baseUrl}weather?lat=$lat&lon=$long&appid=$ApiKey");
    http_client.Response response = await http_client.get(url);

    Map<String, dynamic> result = jsonDecode(response.body);

    print(result);
  }
}
