import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/login/login_screen.dart';
import 'package:trip_planner/infrastructure/presentation/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // controllers
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  void registerUser() async {
    final provider = context.read<RegisterProvider>();

    final isValid = provider.validateFields(controllerName.text, controllerEmail.text, controllerPassword.text);

    if(!isValid) return;

    final result = await provider.registerUser(controllerName.text, controllerEmail.text, controllerPassword.text);

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
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final provider = context.watch<RegisterProvider>();

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
                      l10n.createAccount,
                      style: TextStyle(
                        fontSize: 20,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextFieldComponent(
                        controller: controllerName,
                        hint: l10n.name,
                        error: provider.errorName,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
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
                          onPressed: () => registerUser(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            l10n.signUp,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
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
                        l10n.haveAccount,
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
      ),
    );
  }
}
