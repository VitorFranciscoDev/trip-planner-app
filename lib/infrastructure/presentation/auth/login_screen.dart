import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_screen.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/infrastructure/presentation/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // controllers
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  Future<void> doLogin() async {
    final provider = context.read<AuthProvider>();

    final isValid = provider.validateLoginFields(controllerEmail.text, controllerPassword.text, context);

    if(!isValid) return;

    final result = await provider.doLogin(controllerEmail.text, controllerPassword.text);

    if(result == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Successful"),
          content: Text("Welcome, ${provider.user?.name ?? "User"}!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigatorScreen()));
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Failed"),
          content: const Text("Email or password incorrect"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Try Again"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logos/trip-planner-logo.png",
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
                      l10n.welcomeBack,
                      style: TextStyle(fontSize: 20, color: theme.colorScheme.primary),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextFieldComponent(
                        controller: controllerEmail, 
                        hint: l10n.email, 
                        error: provider.errorEmail,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextFieldComponent(
                        controller: controllerPassword, 
                        hint: l10n.password,
                        error: provider.errorPassword,
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
                          child: Text(
                            l10n.signIn,
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
                          l10n.noAccount,
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
      ),
    );
  }
}