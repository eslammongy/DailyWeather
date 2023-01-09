import 'package:daily_weather/screens/search/search_screen.dart';
import 'package:daily_weather/utils/location_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../services/weather_services.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isServiceEnabled = false;
  WeatherServices services = WeatherServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchScreen();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('DailyWeather'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'there is no weather 😔 start',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const Text(
                'searching now 🔍 or give me access on your location please..',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: (() async {
                    LocationData locationData = await LocationService()
                        .checkUserLocationServices(_isServiceEnabled);
                    List list = await services.getCurrentWeatherByLocation(
                        lat: locationData.latitude,
                        long: locationData.longitude);
                    print(list);
                  }),
                  child: const Text(
                    'Get Location',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
