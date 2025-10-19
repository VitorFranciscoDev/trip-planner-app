import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/theme/theme_provider.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  String dropdownValue = "Portuguese";
  bool darkMode = false;
  bool showLanguage = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                      }
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, right: 25, left: 25),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showLanguage = !showLanguage;
                            });
                          },
                          child: Icon(
                            showLanguage ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                            size: 35,
                          ),
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                    if(showLanguage)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
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
                          const SizedBox(height: 10),
                          Row(
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
                          const SizedBox(height: 10),
                          Row(
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
                        ],
                      ),
                  ],
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
                    const Icon(Icons.settings),
                    const SizedBox(width: 8),
                    const Text(
                      "Your Information",
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                    const Icon(Icons.delete),
                    const SizedBox(width: 8),
                    const Text(
                      "Delete Account",
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 18,
                      ),
                    ),
                  ],
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
                    const Icon(Icons.logout),
                    const SizedBox(width: 8),
                    const Text(
                      "Log Out",
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}