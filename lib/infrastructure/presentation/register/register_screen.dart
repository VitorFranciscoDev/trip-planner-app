import 'package:flutter/material.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/modules/user/user_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //Controllers
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  //Error Text
  String? errorName;
  String? errorEmail;
  String? errorPassword;

  bool _obscureText = true;

  //Repository
  final userRepo = UserRepository();

  Future<void> registerUser(String name, String email, String password) async {
    final existingUser = await userRepo.getUserByEmail(email);
    if(existingUser!=null) {
      setState(() {
        errorEmail = "There's a register with this Email";
      });
      return;
    }

    final user = User(name: name, email: email, password: password);
    final newUser = await userRepo.insertUser(user);
  }

  //Function to verify the data of the controllers
  void verify() async {
    setState(() {
      //Name Verification
      if(controllerName.text.isEmpty) {
        errorName = "Name cannot be blank";
      } else if(!RegExp(r'[a-zA-Z ]').hasMatch(controllerName.text)) {
        errorName = "Name cannot contain special characters";
      } else {
        errorName = null;
      }

      //Email Verification
      if(controllerEmail.text.isEmpty) {
        errorEmail = "Email cannot be blank";
      } else if(!controllerEmail.text.contains("@")) {
        errorEmail = "Email must have @";
      } else {
        errorEmail = null;
      }

      //Password Verification
      if(controllerPassword.text.isEmpty) {
        errorPassword = "Password cannot be blank";
      } else if(controllerPassword.text.length < 8) {
        errorPassword = "Password needs to have, at least, 8 characters";
      } else {
        errorPassword = null;
      }
    });

    //If all the data is correct, navigates to the Login Page
    if(errorName == null && errorEmail == null && errorPassword == null) {
      await registerUser(controllerName.text, controllerEmail.text, controllerPassword.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8DC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/trip-planner-logo.png",
              width: 350,
              fit: BoxFit.cover,
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            Container(
              width: 320,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(padding: EdgeInsets.only(bottom: 50)),
                  const Text(
                    "Create Your Account",
                    style: TextStyle(fontSize: 20, color: Color(0xFF8B4513)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldComponent(
                      controller: controllerName, 
                      hint: "Name",
                      error: errorName,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFieldComponent(
                      controller: controllerEmail, 
                      hint: "Email",
                      error: errorEmail,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextField(
                      controller: controllerPassword,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Password",
                        errorText: errorPassword,
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF8B4513),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => verify(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Already have an account? Click here to login!",
                      style: TextStyle(color: Color(0xFFFFA07A)),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 50)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}