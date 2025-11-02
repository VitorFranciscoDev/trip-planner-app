class Person {
  final int? id;
  final int? trip_id;
  final String name;
  final int age;

  Person({ this.id, this.trip_id, required this.name, required this.age });

  // Transforms Person in Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "trip_id": trip_id,
      "name": name,
      "age": age,
    };
  }

  // Transforms Map<String, dynamic> in Person
  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      trip_id: map['trip_id'], 
      name: map['name'], 
      age: map['age'],
    );
  }
}