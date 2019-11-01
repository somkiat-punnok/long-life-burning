part of nearby;

abstract class ScreenListener {
  updateScreen(Location location);
  dismissLoader();
}

abstract class GooglePlacesListener {
  selectedLocation(double lat, double long, String address);
}

abstract class GpsUtilListener {
  onLocationChange(Map<String, double> location);
}
