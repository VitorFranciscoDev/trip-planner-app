import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/trip_planner_logo_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/intl_state.dart';
import 'package:trip_planner/infrastructure/presentation/auth/login_screen.dart';
import 'package:trip_planner/infrastructure/presentation/app/theme/theme_provider.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  String languageSelected = "Portuguese";
  bool darkMode = false;
  bool showLanguage = false;
  bool showInformations = false;

  @override
  void initState() {
    super.initState();
    _controllerName.text = context.read<AuthProvider>().user!.name;
    _controllerEmail.text = context.read<AuthProvider>().user!.email;
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intl = AppLocalizations.of(context);
    final provider = context.read<AuthProvider>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Center(child: TripPlannerLogoComponent()),
            const SizedBox(height: 30),
            
            // Preferences Section
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                intl.preferences,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // Dark Mode Container
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 2,
                  color: theme.colorScheme.primary,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.dark_mode),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      intl.darkMode,
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Switch(
                    value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      context.read<ThemeProvider>().toggleTheme(value);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            
            // Language Container
            GestureDetector(
              onTap: () {
                setState(() {
                  showLanguage = !showLanguage;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.flag),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            intl.language,
                            style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          showLanguage ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          size: 28,
                        ),
                      ],
                    ),
                    if (showLanguage) ...[
                      const SizedBox(height: 15),
                      _buildLanguageOption(
                        "🇺🇸",
                        intl.english,
                        () {
                          setState(() {
                            languageSelected = "English";
                            showLanguage = false;
                          });
                          context.read<IntlProvider>().setLanguage('en');
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildLanguageOption(
                        "🇧🇷",
                        intl.portuguese,
                        () {
                          setState(() {
                            languageSelected = "Portuguese";
                            showLanguage = false;
                          });
                          context.read<IntlProvider>().setLanguage('pt');
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildLanguageOption(
                        "🇪🇸",
                        intl.spanish,
                        () {
                          setState(() {
                            languageSelected = "Spanish";
                            showLanguage = false;
                          });
                          context.read<IntlProvider>().setLanguage('es');
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Account Section
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                intl.account,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // Your Information Container
            GestureDetector(
              onTap: () {
                setState(() {
                  showInformations = !showInformations;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.settings),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            intl.yourInformation,
                            style: TextStyle(
                              fontFamily: "Times New Roman",
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          showInformations ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          size: 28,
                        ),
                      ],
                    ),
                    if (showInformations) ...[
                      const SizedBox(height: 15),
                      TextFieldComponent(
                        controller: _controllerName,
                        label: "Name",
                        error: provider.errorName,
                      ),
                      const SizedBox(height: 10),
                      TextFieldComponent(
                        controller: _controllerEmail,
                        label: "Email",
                        error: provider.errorEmail,
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final updatedUser = User(
                              id: provider.user!.id,
                              name: _controllerName.text,
                              email: _controllerEmail.text,
                              password: provider.user!.password,
                            );
                            await provider.updateUser(updatedUser);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.secondary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            intl.updateInfo,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // Delete Account Container
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            intl.deleteAccount,
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
                      "Are you sure you want to delete your account? This action cannot be undone.",
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: Text(
                          intl.cancel,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthProvider>().deleteUser(context);
                          Navigator.of(dialogContext).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                          context.read<BottomNavigatorProvider>().index = 0;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          intl.deleteAccountConfirm,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.delete, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        intl.deleteAccount,
                        style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            
            // Log Out Container
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Row(
                      children: [
                        Icon(Icons.logout, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            intl.logOut,
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
                      "Are you sure you want to log out?",
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        child: Text(
                          intl.cancel,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthProvider>().logout();
                          Navigator.of(dialogContext).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                          context.read<BottomNavigatorProvider>().index = 0;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          intl.logOutConfirm,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontSize: 16,
                          color: Colors.red,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String flag, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}