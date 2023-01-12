import 'package:daily_weather/providers/weather_provider.dart';
import 'package:daily_weather/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return WeatherProvider();
      },
      child: MaterialApp(
        title: 'DailyWeather',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}


/*  body: provider.latitude == 0.0
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
                              if (provider.latitude == 0.0) {
                                await _locationService
                                    .checkUserLocationServices(
                                        _isServiceEnabled)
                                    .then((locationData) {
                                  if (locationData.latitude != null) {
                                    print(
                                        "Returned location data from dereferences");
                                    provider.getUserLocationData();
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
            : Container()); */