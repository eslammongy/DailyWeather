import 'package:daily_weather/services/weather_services.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  String? cityName;
  WeatherServices services = WeatherServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('search a city'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: TextField(
          onSubmitted: ((value) {
            cityName = value;
            services.getCurrentWeatherData(cityName: cityName!);
          }),
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              label: Text('search'),
              hintText: 'enter city name',
              border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
