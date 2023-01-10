import 'package:daily_weather/screens/search/search_screen.dart';
import 'package:daily_weather/utils/location_service.dart';
import 'package:daily_weather/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/weather_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isServiceEnabled = false;
  WeatherServices services = WeatherServices();
  final LocationService _locationService = LocationService();
  double? latitude = 0.0;
  double? longitude = 0.0;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    print("latitude BuildMethod:: $latitude");
    print("longitude BuildMethod:: $longitude");

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
        body: (latitude == 0.0)
            ? Center(
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
                            if (latitude == 0.0 && longitude == 0.0) {
                              _locationService
                                  .checkUserLocationServices(_isServiceEnabled);
                              print(
                                  "latitude checkUserLocationServices:: $latitude");
                              print(
                                  "longitude checkUserLocationServices:: $longitude");
                            } else {
                              List list =
                                  await services.getCurrentWeatherByLocation(
                                      lat: latitude, long: longitude);
                              print(list);
                            }
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
              )
            : CurrentWeatherContainer());
  }

  getLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      latitude = prefs.getDouble('LocationLatitude') ?? 0.0;
      longitude = prefs.getDouble('LocationLongitude') ?? 0.0;
    });
    print("latitude getLocationData:: $latitude");
    print("longitude getLocationData:: $longitude");
  }
}
