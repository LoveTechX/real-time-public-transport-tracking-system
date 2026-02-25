import '../domain/tracking_repository.dart';
import '../domain/bus_location.dart';

class TrackingController {
  final TrackingRepository _repository;

  TrackingController(this._repository);

  Stream<BusLocation> getBusLocation(String busId) {
    return _repository.getBusLocation(busId);
  }
}