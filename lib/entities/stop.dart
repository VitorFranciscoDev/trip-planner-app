class Stop {
  final int? id;
  final int? tripId;
  final String location;
  final double latitude;
  final double longitude;

  Stop({ this.id, this.tripId, required this.location, required this.latitude, required this.longitude });

  //Transforms Stop in Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tripId': tripId,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  //Transforms Map in Stop
  factory Stop.fromMap(Map<String, dynamic> map) {
    return Stop(
      id: map['id'],
      tripId: map['tripId'],
      location: map['location'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}