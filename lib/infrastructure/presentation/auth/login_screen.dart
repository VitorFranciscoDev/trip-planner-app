import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/button_component.dart';
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
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  // Try to Login in App
  Future<void> doLogin() async {
    final theme = Theme.of(context);
    final provider = context.read<AuthProvider>();
    final currentContext = context;

    final isValid = provider.validateLoginFields(_controllerEmail.text, _controllerPassword.text, currentContext);

    if (!isValid) return;

    final result = await provider.doLogin(_controllerEmail.text, _controllerPassword.text, currentContext);

    if (result == null) {
      // Successful Feedback Alert
      showDialog(
        context: currentContext,
        builder: (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.check_circle, color: theme.colorScheme.primary, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Login Successful!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            "Welcome back, ${provider.user!.name}!",
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigatorScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.tertiary,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Enter",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      );
    } else {
      // Error Feedback Alert
      showDialog(
        context: currentContext,
        builder: (dialogContext) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.error, color: Colors.red, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Error in Login!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            result,
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: theme.colorScheme.tertiary,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Try Again",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                TripPlannerLogoComponent(),
                const SizedBox(height: 40),

                // Text Fields Container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text(
                          l10n.welcomeBack,
                          style: TextStyle(
                            fontSize: 24,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Sign in to continue your journey",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Email Field
                        TextFieldComponent(
                          controller: _controllerEmail,
                          label: "Email",
                          error: provider.errorEmail,
                        ),
                        const SizedBox(height: 10),

                        // Password Field
                        TextFieldComponent(
                          controller: _controllerPassword,
                          label: "Password",
                          error: provider.errorPassword,
                          isPassword: true,
                        ),
                        const SizedBox(height: 15),

                        // Sign In Button
                        ButtonComponent(
                          function: doLogin,
                          message: l10n.signIn,
                        ),
                        const SizedBox(height: 20),

                        // Divider
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[300])),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "or",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey[300])),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Go to Register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                                provider.clearErrors();
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}