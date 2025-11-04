// Stop Experience's Model
class StopExperience {
  final int? id; // Stop Experience's ID [Auto Increment]
  final int? stop_id; // Stop's ID [Related to Stop Experience]
  final String experience;

  StopExperience({ this.id, this.stop_id, required this.experience });

  // Transforms UserExperience in Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stop_id': stop_id,
      'experience': experience,
    };
  }

  factory StopExperience.fromMap(Map<String, dynamic> map) {
    return StopExperience(
      id: map['id'],
      stop_id: map['stop_id'],
      experience: map['experience'],
    );
  }
}