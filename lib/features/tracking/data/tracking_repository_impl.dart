import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/bus_location.dart';
import '../domain/tracking_repository.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final FirebaseFirestore _firestore;

  TrackingRepositoryImpl(this._firestore);

  @override
  Stream<BusLocation> getBusLocation(String busId) {
    return _firestore
        .collection('buses')
        .doc(busId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        throw Exception("Bus not found");
      }

      final Timestamp? firestoreTimestamp = data['timestamp'];

      if (firestoreTimestamp == null) {
        throw Exception("Timestamp not yet available");
      }

      final Timestamp ts = data['timestamp'];

      return BusLocation(
        latitude: (data['latitude'] ?? 0).toDouble(),
        longitude: (data['longitude'] ?? 0).toDouble(),
        speed: (data['speed'] ?? 0).toDouble(),
        status: data['status'] ?? "offline",
        timestamp: ts.toDate(),
        timestampMillis: ts.millisecondsSinceEpoch, // ✅ NEW
      );
    });
  }
}
