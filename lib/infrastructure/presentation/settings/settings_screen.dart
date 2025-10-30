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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intl =AppLocalizations.of(context);
    final provider = context.read<AuthProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Center(child: TripPlannerLogoComponent()),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 30),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              height: 70,
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
                  const SizedBox(width: 20),
                  const Icon(Icons.dark_mode),
                  const SizedBox(width: 5),
                  Text(intl.darkMode, style: TextStyle(fontFamily: "Times New Roman", fontSize: 18)),
                  Spacer(),
                  Switch(
                    value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark, 
                    onChanged: (value) {
                      setState(() {
                        context.read<ThemeProvider>().toggleTheme(value);
                      });
                    },
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showLanguage = !showLanguage;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: showLanguage ? 200 : 70,
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(Icons.flag),
                        const SizedBox(width: 5),
                        Text(
                          intl.language,
                          style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          showLanguage ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          size: 35,
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                    if(showLanguage)
                      Column(
                        children: [
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                languageSelected = "English";
                                showLanguage = !showLanguage;
                              });
                              context.read<IntlProvider>().setLanguage('en');
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                const Text("🇺🇸"),
                                const SizedBox(width: 10),
                                Text(
                                  intl.english,
                                  style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                languageSelected = "Portuguese";
                                showLanguage = !showLanguage;
                              });
                              context.read<IntlProvider>().setLanguage('pt');
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                const Text("🇧🇷"),
                                const SizedBox(width: 10),
                                Text(
                                  intl.portuguese,
                                  style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                languageSelected = "Spanish";
                                showLanguage = !showLanguage;
                              });
                              context.read<IntlProvider>().setLanguage('es');
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: 20),
                                const Text("🇪🇸"),
                                const SizedBox(width: 10),
                                Text(
                                  intl.spanish,
                                  style: TextStyle(
                                    fontFamily: "Times New Roman",
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 30),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showInformations = !showInformations;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: showInformations ? 275 : 70,
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: theme.colorScheme.primary,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(Icons.settings),
                        const SizedBox(width: 8),
                        Text(
                          intl.yourInformation,
                          style: TextStyle(
                            fontFamily: "Times New Roman",
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          showInformations ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          size: 35,
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                    if(showInformations)
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10, right: 30, left: 30),
                            child: TextFieldComponent(
                              controller: _controllerName, 
                              label: "Name",
                              error: provider.errorName,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, right: 30, left: 30),
                            child: TextFieldComponent(
                              controller: _controllerEmail, 
                              label: "Email",
                              error: provider.errorEmail,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: SizedBox(
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
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: Text(intl.deleteAccount),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(intl.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthProvider>().deleteUser(context);
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          context.read<BottomNavigatorProvider>().index = 0;
                        },
                        child: Text(intl.deleteAccountConfirm),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                height: 70,
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
                    const SizedBox(width: 20),
                    const Icon(Icons.delete, color: Colors.red,),
                    const SizedBox(width: 8),
                    Text(
                      intl.deleteAccount,
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: Text(intl.logOut),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(intl.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthProvider>().logout();
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          context.read<BottomNavigatorProvider>().index = 0;
                        },
                        child: Text(intl.logOutConfirm),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                height: 70,
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
                    const SizedBox(width: 20),
                    const Icon(Icons.logout, color: Colors.red,),
                    const SizedBox(width: 8),
                    const Text(
                      "Log Out",
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}