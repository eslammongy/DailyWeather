import 'package:daily_weather/services/weather_services.dart';
import 'package:daily_weather/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/weather_provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? cityName;

  WeatherServices services = WeatherServices();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherProvider>(context);
    provider.weatherModels.clear();
    return Scaffold(
        appBar: AppBar(
          title: const Text('search a city'),
        ),
        body: provider.weatherModels.isEmpty
            ? Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
              )
            : const CurrentWeatherContainer());
  }
}
