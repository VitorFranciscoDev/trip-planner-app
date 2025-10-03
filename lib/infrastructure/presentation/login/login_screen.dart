import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_screen.dart';
import 'package:trip_planner/infrastructure/presentation/login/login_state.dart';
import 'package:trip_planner/infrastructure/presentation/register/register_screen.dart';
import 'package:trip_planner/modules/user/user_repository.dart';
import 'package:trip_planner/modules/user/user_usecase.dart';

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

  //Use Cases of the User
  final UserUseCase userUseCase = UserUseCase(userRepository: UserRepository());

  //Function to Login
  void doLogin() async {
    setState(() {
      errorEmail = userUseCase.validateEmail(controllerEmail.text);
      errorPassword = userUseCase.validatePassword(controllerPassword.text);
    });

    if(errorEmail==null && errorPassword==null) {
      try {
        final result = await userUseCase.loginUser(controllerEmail.text, controllerPassword.text);

        if(result!=null) {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: const Text("Login Successful"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigatorScreen()));
                    context.read<UserProvider>().registerUser(result);
                  }, 
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: const Text("User Not Found"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        }
      } catch(e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: const Text("Unexpected Error"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, 
                child: const Text("Close"),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
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
                  Text(
                    "Welcome Back!",
                    style: TextStyle(fontSize: 20, color: theme.colorScheme.primary),
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
                        onPressed: () => doLogin(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
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
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        "Doesn't have an account? Click here to create one!",
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontSize: 12,
                        ),
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