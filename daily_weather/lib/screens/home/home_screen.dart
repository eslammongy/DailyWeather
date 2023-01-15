// ignore_for_file: avoid_print

import 'package:daily_weather/screens/search/search_screen.dart';
import 'package:daily_weather/utils/app_colors.dart';
import 'package:daily_weather/utils/location_prefs.dart';
import 'package:daily_weather/utils/location_service.dart';
import 'package:daily_weather/widgets/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool _isServiceEnabled = false;
  late LocationService _locationService;

  @override
  void initState() {
    super.initState();
    initialLocationServices();
    getCurrentLocationData();
  }

  getCurrentLocationData() async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getUserLocationData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherProvider>(context, listen: true);
    // provider.getUserLocationData();
    print(
        "Provider build context -> ${provider.latitude}..${provider.longitude}");
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
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  provider.listWeatherModel.clear();
                  provider.cityName = null;
                  return const SearchScreen();
                }));
              },
              icon: Icon(
                Icons.search,
                color: AppColor.titleBlue,
              ),
            ),
          ],
          title: Text(
            'DailyWeather',
            style: TextStyle(color: AppColor.titleBlue),
          ),
        ),
        body: provider.latitude == 0.0
            ? Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'searching now 🔍 or give me access on your location please 😔 to start..',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, color: AppColor.snowWhite),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: (() async {
                              if (provider.latitude == 0.0) {
                                await _locationService
                                    .checkUserLocationServices(
                                        _isServiceEnabled)
                                    .then((locationData) {
                                  if (locationData.latitude != null) {
                                    provider.setLatitude =
                                        locationData.latitude!;
                                    provider.setLongitude =
                                        locationData.longitude!;
                                  }
                                });
                              }
                            }),
                            child: const Text(
                              'Get Location',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )),
              )
            : CurrentWeatherContainer(fetchMethod: "LatLang"));
  }

  initialLocationServices() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    LocationPreferences locationPreferences =
        LocationPreferences(sharedPreferences: sharedPreferences);
    _locationService =
        LocationService(locationPreferences: locationPreferences);
  }
}
