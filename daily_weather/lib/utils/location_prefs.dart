// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class LocationPreferences {
  SharedPreferences sharedPreferences;
  LocationPreferences({
    required this.sharedPreferences,
  });

  saveUserLocation({required double? lat, required double? long}) async {
    sharedPreferences.setDouble('LocationLatitude', lat!);
    sharedPreferences.setDouble('LocationLongitude', long!);
    print(
        "The location data saved successfully in shared preference:: $lat .. $long");
  }

  getLocationLatitude() async {
    double latitude = sharedPreferences.getDouble('LocationLatitude') ?? 0.0;
    return latitude;
  }

  getLocationLongitude() async {
    double longitude = sharedPreferences.getDouble('LocationLongitude') ?? 0.0;
    return longitude;
  }
}
