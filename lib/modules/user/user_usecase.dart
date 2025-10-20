import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/modules/user/user_spec.dart';

class UserUseCase {
  UserUseCase({ required this.userRepository });

  final IUserRepository userRepository;

  String? validateName(String name) => name.isEmpty ? "Name cannot be blank" : null;

  String? validateEmail(String email) {
    if(email.isEmpty) {
      return "Email cannot be blank";
    } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return "Invalid email format";
    }
    return null;
  }

  String? validatePassword(String password) {
    if(password.isEmpty) {
      return "Password cannot be blank";
    } else if(password.length < 8) {
      return "Password needs to have, at least, 8 characters";
    }
    return null;
  }

  Future<User?> validateUser(String email) async {
    return await userRepository.getUserByEmail(email);
  }

  Future<String?> registerUser(String name, String email, String password) async {
    try {
      final existingUser = await userRepository.getUserByEmail(email);

      if(existingUser != null) {
        return "There's a register with this Email";
      }

      User user = User(name: name, email: email, password: password);
      
      await userRepository.registerUser(user);
      return null;
    } catch (e) {
      return "Error in the register: ${e.toString()}";
    }
  }

  Future<User?> doLogin(String email, String password) async {
    return await userRepository.doLogin(email, password);
  }

  Future<String?> deleteUser(int? id) async {
    final result = await userRepository.deleteUser(id);
    
    if(result>0) return null;

    return "Error in deleting the user";
  }
}