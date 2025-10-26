import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/alert_dialog_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/button_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/trip_planner_logo_component.dart';
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

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  // Try to Register User in DB
  void registerUser() async {
    final provider = context.read<AuthProvider>();
    final currentContext = context;

    final isValid = provider.validateRegisterFields(controllerName.text, controllerEmail.text, controllerPassword.text, context);

    if(!isValid) return;

    User user = User(name: controllerName.text, email: controllerEmail.text, password: controllerPassword.text);

    final result = await provider.registerUser(user, context);

    if(result == null) {
      showDialog(
        context: currentContext,
        builder: (dialogContext) => AlertDialogComponent(
          icon: Icons.person,
          title: "Register Succesful!",
          message: "You can now Login.", 
          fn2: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          }, 
          fn2Message: "Go To Login",
        ),
      );
    } else {
      showDialog(
        context: currentContext,
        builder: (context) => AlertDialogComponent(
          icon: Icons.error,
          title: "Error in Register", 
          message: result,
          fn2: () => Navigator.of(context).pop(), 
          fn2Message: "Ok",
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
              TripPlannerLogoComponent(),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ContainerTextFieldComponent(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        l10n.createAccount,
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFieldComponent(
                          controller: controllerName,
                          label: "Name",
                          error: provider.errorName,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFieldComponent(
                          controller: controllerEmail,
                          label: "Email",
                          error: provider.errorEmail,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFieldComponent(
                          controller: controllerPassword,
                          label: "Password",
                          error: provider.errorPassword,
                          isPassword: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ButtonComponent(function: registerUser, message: l10n.signUp),
                      ),
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
                      const SizedBox(height: 20),
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
