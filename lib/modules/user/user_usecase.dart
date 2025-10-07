import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_repository.dart';
import 'package:trip_planner/modules/user/user_spec.dart';

class UserUseCase implements IUserUseCase {

  UserUseCase({ required this.userRepository });

  // repository of the User
  final UserRepository userRepository;

  // function to validate the name of the User
  @override
  String? validateName(String name) {
    if(name.isEmpty) {
       return "Name cannot be blank";
    } else if(!RegExp(r'^[a-zA-ZÀ-ÿ]+$').hasMatch(name)) {
      return "Name can only contain letters";
    }

    return null;
  }

  // function to validate the email of the User
  @override
  String? validateEmail(String email) {
    if(email.isEmpty) {
      return "Email cannot be blank";
    } else if(!email.contains("@")) {
      return "Email must have @";
    }

    return null;
  }

  // function to validate the password of the User
  @override
  String? validatePassword(String password) {
    if(password.isEmpty) {
      return "Password cannot be blank";
    } else if(password.length < 8) {
      return "Password needs to have, at least, 8 characters";
    }

    return null;
  }

  // function to validate the User
  @override
  Future<User?> validateUser(String email) async {
    final result = await userRepository.getUserByEmail(email);

    if(result!=null) return result;

    return null;
  }

  // function to register the User
  @override
  Future<String?> registerUser(String name, String email, String password) async {
    final existingUser = await userRepository.getUserByEmail(email);

    if(existingUser!=null) {
      return "There's a register with this Email";
    }

    User user = User(name: name, email: email, password: password);
    final result = await userRepository.insertUser(user);

    if(result>0) return null;

    return "Error in the register";
  }

  // function to do login
  @override
  Future<User?> loginUser(String email, String password) async {
    final user = await userRepository.doLogin(email, password);

    if(user!=null) {
      return user;
    }

    return null;
  }
}