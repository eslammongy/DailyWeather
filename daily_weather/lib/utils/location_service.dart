import 'package:location/location.dart';

class LocationService {

  late LocationData locationData;
  Future<LocationData> checkUserLocationServices(bool isServiceEnabled) async {
    Location userLocation = Location();

    isServiceEnabled = await userLocation.serviceEnabled();
    if (isServiceEnabled) {
      // user location enabled
      locationData = await _checkUserLocationPermission(userLocation);
    } else {
      isServiceEnabled = await userLocation.requestService();
      if (isServiceEnabled) {
        // Start access user location
        locationData = await _checkUserLocationPermission(userLocation);
      }
    }
    return locationData;
  }

  Future<LocationData> _checkUserLocationPermission(Location location) async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.granted) {
      locationData = await location.getLocation();
      /* location.onLocationChanged.listen((event) {
        locationData = event;
      }); */
      return locationData;
    } else {
      permissionStatus = await location.requestPermission();
      locationData = await location.getLocation();
      if (permissionStatus == PermissionStatus.granted) {
        return locationData;
      } else {
        return locationData;
      }
    }
  }
}
