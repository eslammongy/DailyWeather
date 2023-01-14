import 'package:daily_weather/services/weather_services.dart';
import 'package:daily_weather/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    print(
        "CityName -> $cityName Weather List Model Size -> ${provider.listWeatherModel.length}");
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.grey[800], // You can use this as well
            statusBarIconBrightness:
                Brightness.light, // OR Vice Versa for ThemeMode.dark
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: Colors.grey[800],
          elevation: 0.3,
          title: const Text('search a city'),
        ),
        body: provider.listWeatherModel.isEmpty
            ? Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextField(
                  onSubmitted: ((value) {
                    cityName = value;
                    provider.getWeatherInfoByCityName(cityName!);
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
            : Container());
  }
}
