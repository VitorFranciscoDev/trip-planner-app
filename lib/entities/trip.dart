class Trip {
  final int? id;
  final String title;
  final String transport;
  final String startDate;
  final String endDate;

  Trip({ this.id, required this.title, required this.transport, required this.startDate, required this.endDate});

  //Transforms Trip in Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'transport': transport,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  //Transforms Map in Trip
  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'],
      title: map['title'],
      transport: map['transport'],
      startDate: map['startDate'],
      endDate: map['endDate'],
    );
  }
}