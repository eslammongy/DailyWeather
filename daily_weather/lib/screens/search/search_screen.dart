import 'package:daily_weather/services/weather_services.dart';
import 'package:daily_weather/utils/app_colors.dart';
import 'package:daily_weather/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/weather_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  WeatherServices services = WeatherServices();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: Colors.grey[900], // You can use this as well
            statusBarIconBrightness:
                Brightness.light, // OR Vice Versa for ThemeMode.dark
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: Colors.grey[900],
          elevation: 3,
          title: const Text('search a city'),
        ),
        body: provider.cityName == null
            ? Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: TextField(
                  onSubmitted: ((value) {
                    setState(() {
                      provider.cityName = value;
                    });
                  }),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search, color: Colors.grey[500]),
                    fillColor: Colors.grey[700],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    label: Text(
                      'search',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    hintText: 'enter city name',
                    hintStyle: const TextStyle(color: AppColor.grey),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Colors.blue), //<-- SEE HERE
                    ),
                  ),
                ),
              )
            : CurrentWeatherContainer(fetchMethod: provider.cityName!));
  }
}
