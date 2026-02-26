class BusLocation {
  final double latitude;
  final double longitude;
  final double speed;
  final String status;
  final DateTime timestamp;
  final int timestampMillis; // ✅ NEW

  BusLocation({
    required this.latitude,
    required this.longitude,
    required this.speed,
    required this.status,
    required this.timestamp,
    required this.timestampMillis, // ✅ NEW
  });
}
