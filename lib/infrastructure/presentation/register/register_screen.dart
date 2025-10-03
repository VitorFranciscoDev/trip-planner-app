import 'package:flutter/material.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/login/login_screen.dart';
import 'package:trip_planner/modules/user/user_repository.dart';
import 'package:trip_planner/modules/user/user_usecase.dart';

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

  //Use Cases of the User
  final UserUseCase userUseCase = UserUseCase(userRepository: UserRepository());

  void registerUser() async {
    setState(() {
      errorName = userUseCase.validateName(controllerName.text);
      errorEmail = userUseCase.validateEmail(controllerEmail.text);
      errorPassword = userUseCase.validatePassword(controllerPassword.text);
    });

    if(errorName==null && errorEmail==null && errorPassword==null) {
      try {
        final resultUser = await userUseCase.validateUser(controllerEmail.text);

        if(resultUser==null) {
          showDialog(
            context: context, 
            builder: (context) => AlertDialog(
              title: const Text("Register Successful"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }, 
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        } else {
          setState(() {
            errorEmail = "Email already exists";
          });
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
                    "Create Your Account",
                    style: TextStyle(fontSize: 20, color: theme.colorScheme.primary),
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
                        onPressed: () => registerUser(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.secondary,
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
                    child: Text(
                      "Already have an account? Click here to login!",
                      style: TextStyle(color: theme.colorScheme.secondary),
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