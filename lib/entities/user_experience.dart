class UserExperience {
  final int? id;
  final int? stop_id;
  final String experience;

  UserExperience({ this.id, this.stop_id, required this.experience });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stop_id': stop_id,
      'experience': experience,
    };
  }
}