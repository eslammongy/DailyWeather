// ignore_for_file: avoid_print

import 'package:location/location.dart';
import 'package:daily_weather/utils/location_prefs.dart';

class LocationService {
  late LocationData locationData;
  LocationPreferences locationPreferences;
  LocationService({
    required this.locationPreferences,
  });
  Future<LocationData> checkUserLocationServices(bool isServiceEnabled) async {
    Location userLocation = Location();

    isServiceEnabled = await userLocation.serviceEnabled();
    if (isServiceEnabled) {
      // user location enabled
      locationData = await _checkUserLocationPermission(userLocation);
      locationPreferences.saveUserLocation(
          lat: locationData.latitude, long: locationData.longitude);
    } else {
      isServiceEnabled = await userLocation.requestService();
      if (isServiceEnabled) {
        // Start access user location
        locationData = await _checkUserLocationPermission(userLocation);
        locationPreferences.saveUserLocation(
            lat: locationData.latitude, long: locationData.longitude);
      }
    }
    return locationData;
  }

  Future<LocationData> _checkUserLocationPermission(Location location) async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      locationData = await location.getLocation();
      print(
          "checkUserLocationPermission1:: ${locationData.latitude}..${locationData.longitude}");
      return locationData;
    } else {
      permissionStatus = await location.requestPermission();
      locationData = await location.getLocation();
      if (permissionStatus == PermissionStatus.granted) {
        print(
            "latitude checkUserLocationPermission2:: ${locationData.latitude}..${locationData.longitude}");

        return locationData;
      } else {
        return locationData;
      }
    }
  }
}
