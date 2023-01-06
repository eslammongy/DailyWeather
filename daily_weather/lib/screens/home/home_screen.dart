import 'package:daily_weather/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isServiceEnabled = false;
  late PermissionStatus _permissionStatus;
  //late LocationData _locationData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SearchScreen();
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
                  onTap: (() {
                    checkUserLocationServices();
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

  Future<void> checkUserLocationServices() async {
    Location userLocation = Location();
    _isServiceEnabled = await userLocation.serviceEnabled();
    if (_isServiceEnabled) {
      print("user location enabled");
      checkUserLocationPermission(userLocation);
    } else {
      _isServiceEnabled = await userLocation.requestService();

      if (_isServiceEnabled) {
        print("Start access user location");
        checkUserLocationPermission(userLocation);
      } else {
        return;
      }
    }
  }

  Future<void> checkUserLocationPermission(Location location) async {
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.granted) {
      print("Location Permission Accept");
      // _locationData = await location.getLocation();
      location.onLocationChanged.listen((event) {
        print("${event.latitude} ${event.longitude}");
      });
      //print("${_locationData.latitude} ${_locationData.longitude}");
    } else {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus == PermissionStatus.granted) {
        print("Permission Granted");
        location.onLocationChanged.listen((event) {
          print("${event.latitude} ${event.longitude}");
        });
      } else {
        return;
      }
    }
  }
}
