import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/alert_dialog_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/button_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_textfield_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/trip_planner_logo_component.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_screen.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/infrastructure/presentation/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  // Try to Login in App
  Future<void> doLogin() async {
    final provider = context.read<AuthProvider>();
    final currentContext = context;

    final isValid = provider.validateLoginFields(controllerEmail.text, controllerPassword.text, context);

    if(!isValid) return;

    final result = await provider.doLogin(controllerEmail.text, controllerPassword.text);

    if(result == null) {
      showDialog(
        context: currentContext,
        builder: (dialogContext) => AlertDialogComponent(
          title: "Login Successful!", 
          message: "Welcome back, ${provider.user!.name}!",
          icon: Icons.check,
          fn2: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigatorScreen()));
          }, 
          fn2Message: "Enter",
        ),
      );
    } else {
      showDialog(
        context: currentContext,
        builder: (context) => AlertDialogComponent(
          icon: Icons.error,
          title: "Error in Login!",
          message: result,
          fn2: () => Navigator.of(context).pop(), 
          fn2Message: "Try Again",
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ContainerTextFieldComponent(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        l10n.welcomeBack,
                        style: TextStyle(
                          fontSize: 20, 
                          color: theme.colorScheme.primary, 
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFieldComponent(
                          controller: controllerEmail, 
                          label: "Email",
                          error: provider.errorEmail,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
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
                        child: ButtonComponent(function: doLogin, message: l10n.signIn),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                          provider.clearErrors();
                        },
                        child: Text(
                          l10n.noAccount,
                          style: TextStyle(
                            color: theme.colorScheme.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
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