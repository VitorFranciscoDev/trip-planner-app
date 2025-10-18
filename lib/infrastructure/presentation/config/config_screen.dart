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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 100),
            child: Image.asset("assets/logos/trip-planner-logo.png", height: 75),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Dark Mode", style: TextStyle(fontFamily: "Times New Roman", fontSize: 18)),
              Padding(padding: EdgeInsets.only(right: 10)),
              Switch(
                value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark, 
                onChanged: (value) {
                  setState(() {
                    context.read<ThemeProvider>().toggleTheme(value);
                  });
                }
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: const [
              DropdownMenuItem(
                value: "Portuguese",
                child: Text("Portuguese")
              ),
              DropdownMenuItem(
                value: "English",
                child: Text("English"),
              ),
              DropdownMenuItem(
                value: "Spanish",
                child: Text("Spanish"),
              ),
            ], 
          ),
        ],
      ),
    );
  }
}