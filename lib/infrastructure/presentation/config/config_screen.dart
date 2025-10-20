import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/user.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/text_field_component.dart';
import 'package:trip_planner/infrastructure/presentation/config/config_state.dart';
import 'package:trip_planner/infrastructure/presentation/login/login_screen.dart';
import 'package:trip_planner/infrastructure/presentation/theme/theme_provider.dart';
import 'package:trip_planner/infrastructure/presentation/user/user_state.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  String languageSelected = "Portuguese";
  bool darkMode = false;
  bool showLanguage = false;
  bool showInformations = false;

  @override
  void initState() {
    super.initState();
    _controllerName.text = context.read<UserProvider>().user!.name;
    _controllerEmail.text = context.read<UserProvider>().user!.email;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ConfigProvider>();
    final userProvider = context.read<UserProvider>();

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Image.asset("assets/logos/trip-planner-logo.png", height: 75),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10, right: 205),
              child: Text(
                "Preferences",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
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
                    const Text("Dark Mode", style: TextStyle(fontFamily: "Times New Roman", fontSize: 18)),
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
            Padding(
              padding: EdgeInsets.only(top: 10, right: 25, left: 25),
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
                          const Text(
                            "Language",
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
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Text("🇺🇸"),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "English",
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
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Text("🇧🇷"),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Portuguese",
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
                              },
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  const Text("🇪🇸"),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Spanish",
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
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10, right: 235),
              child: Text(
                "Account",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
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
                          const Text(
                            "Your Information",
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
                                hint: "Name",
                                error: provider.errorName,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, right: 30, left: 30),
                              child: TextFieldComponent(
                                controller: _controllerEmail, 
                                hint: "Email",
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
                                      id: userProvider.user!.id,
                                      name: _controllerName.text,
                                      email: _controllerEmail.text,
                                      password: userProvider.user!.password,
                                    );
                                    final newUser = await provider.updateUser(updatedUser);
                                    userProvider.registerUser(newUser!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.secondary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Update Info",
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: const Text("Delete Account?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<ConfigProvider>().deleteUser(userProvider.user!.id, context);
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: const Text("Delete"),
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
                      const Text(
                        "Delete Account",
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
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 30),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: const Text("Log Out?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<UserProvider>().logout();
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: const Text("Delete"),
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
      ),
    );
  }
}