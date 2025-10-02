class Person {
  final int? id;
  final int tripId;
  final String name;
  final int age;

  Person({this.id, required this.tripId, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "tripId": tripId,
      "name": name,
      "age": age,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      tripId: map['tripId'], 
      name: map['name'], 
      age: map['age'],
    );
  }
}