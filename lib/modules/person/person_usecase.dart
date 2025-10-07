import 'package:trip_planner/modules/person/person_spec.dart';

class PersonUseCase implements IPersonUseCase {

  // function to validate the name
  @override
  String? validateName(String name) => name.isEmpty ? "Name cannot be blank" : null;

  // function to validate the age
  @override
  String? validateAge(String age) {
    if(age.isEmpty) {
      return "Age cannot be blank";
    } else if(!RegExp(r'[0-9]').hasMatch(age)) {
      return "Age must have only numbers";
    }

    return null;
  }
}