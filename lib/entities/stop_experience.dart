class StopExperience {
  final int? id;
  final int? stop_id;
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
}