import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/button_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/trip_planner_logo.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/infrastructure/presentation/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  // Try to Register User in DB
  void registerUser() async {
    final provider = context.read<AuthProvider>();

    final isValid = provider.validateRegisterFields(controllerName.text, controllerEmail.text, controllerPassword.text, context);

    if(!isValid) return;

    User user = User(name: controllerName.text, email: controllerEmail.text, password: controllerPassword.text);

    final result = await provider.registerUser(user, context);

    if(result == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Register Successful"),
          content: const Text("You can now login with your credentials"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text("Go to Login"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error in Register"),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Ok"),
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
            children: [
              const SizedBox(height: 60),
              TripPlannerLogo(),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ContainerTextField(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        l10n.createAccount,
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFieldComponent(
                          controller: controllerName,
                          hint: l10n.name,
                          error: provider.errorName,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFieldComponent(
                          controller: controllerEmail,
                          hint: l10n.email,
                          error: provider.errorEmail,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFieldComponent(
                          controller: controllerPassword,
                          hint: l10n.password,
                          error: provider.errorPassword,
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ButtonComponent(function: registerUser, message: l10n.signUp),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          provider.clearErrors();
                        },
                        child: Text(
                          l10n.haveAccount,
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
