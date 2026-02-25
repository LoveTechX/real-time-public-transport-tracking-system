import 'bus_location.dart';

abstract class TrackingRepository {
  Stream<BusLocation> getBusLocation(String busId);
}