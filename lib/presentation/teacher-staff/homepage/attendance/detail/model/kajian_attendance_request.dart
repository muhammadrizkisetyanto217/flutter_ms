class KajianAttendanceRequest {
  final String userId;
  final double latitude;
  final double longitude;
  final String address;
  final String topic;
  final String notes;

  KajianAttendanceRequest({
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.topic,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'topic': topic,
      'notes': notes,
    };
  }
}
