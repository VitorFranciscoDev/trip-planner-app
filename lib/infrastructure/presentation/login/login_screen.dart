import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_screen.dart';
import 'package:trip_planner/infrastructure/presentation/login/login_state.dart';
import 'package:trip_planner/infrastructure/presentation/register/register_screen.dart';
import 'package:trip_planner/modules/user/user_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controllers
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  //Error Text
  String? errorEmail;
  String? errorPassword;

  //Repository
  final userRepo = UserRepository();

  //Function to Login
  Future<void> login(String email, String password) async {
    final user = await userRepo.login(email, password);

    if(user!=null) {
      context.read<LoginState>().registerUser(user);
      Navigator.push(context, MaterialPageRoute(builder: (context) =>BottomNavigatorScreen()));
    } else {
      setState(() {
        errorEmail = "Invalid Login";
        errorPassword = "Invalid Login";
      });
    }
  }

  //Function to verify the data of the controllers
  void verify() {
    setState(() {
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

    //If all the data is correct, navigates to the Home Page
    if(errorEmail==null && errorPassword==null) {
      login(controllerEmail.text, controllerPassword.text);
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
                    "Welcome Back!",
                    style: TextStyle(fontSize: 20, color: Color(0xFF8B4513)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
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
                    child: TextFieldComponent(
                      controller: controllerPassword, 
                      hint: "Password",
                      error: errorPassword,
                      isPassword: true,
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
                          "Sign In",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Your Password?", style: TextStyle(color: Color(0xFFFFA07A))),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      "Doesn't have an account? Click here to create one!",
                      style: TextStyle(
                        color: Color(0xFFFFA07A),
                        fontSize: 12,
                      ),
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