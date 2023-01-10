import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  late LocationData locationData;
  Future<LocationData> checkUserLocationServices(bool isServiceEnabled) async {
    Location userLocation = Location();

    isServiceEnabled = await userLocation.serviceEnabled();
    if (isServiceEnabled) {
      // user location enabled
      locationData = await _checkUserLocationPermission(userLocation);
      saveUserLocation(
          lat: locationData.latitude, long: locationData.longitude);
    } else {
      isServiceEnabled = await userLocation.requestService();
      if (isServiceEnabled) {
        // Start access user location
        locationData = await _checkUserLocationPermission(userLocation);
        saveUserLocation(
            lat: locationData.latitude, long: locationData.longitude);
      }
    }
    return locationData;
  }

/* location.onLocationChanged.listen((event) {
        locationData = event;
      }); */
  Future<LocationData> _checkUserLocationPermission(Location location) async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      locationData = await location.getLocation();
      print("latitude checkUserLocationPermission1:: ${locationData.latitude}");
      print(
          "longitude checkUserLocationPermission1:: ${locationData.longitude}");
      return locationData;
    } else {
      permissionStatus = await location.requestPermission();
      locationData = await location.getLocation();
      if (permissionStatus == PermissionStatus.granted) {
        print(
            "latitude checkUserLocationPermission2:: ${locationData.latitude}");
        print(
            "longitude checkUserLocationPermission2:: ${locationData.longitude}");
        return locationData;
      } else {
        return locationData;
      }
    }
  }

  saveUserLocation({required double? lat, required double? long}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble('LocationLatitude', lat!);
    sharedPreferences.setDouble('LocationLongitude', long!);
  }
}
