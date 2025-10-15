import 'package:trip_planner/modules/person/person_repository.dart';

class PersonUseCase {
  PersonUseCase({ required this.personRepository });

  final PersonRepository personRepository;

  String? validateName(String name) => name.isEmpty ? "Name cannot be blank" : null;

  String? validateAge(String age) {
    if(age.isEmpty) {
      return "Age cannot be blank";
    } else if(!RegExp(r'[0-9]').hasMatch(age)) {
      return "Age must have only numbers";
    }

    return null;
  }
}