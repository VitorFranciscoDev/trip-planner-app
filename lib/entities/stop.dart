class Stop {
  final int? id;
  final int tripId;
  final String location;

  Stop({ this.id, required this.tripId, required this.location });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tripId': tripId,
      'location': location,
    };
  }

  factory Stop.fromMap(Map<String, dynamic> map) {
    return Stop(
      id: map['id'],
      tripId: map['tripId'],
      location: map['location'],
    );
  }
}