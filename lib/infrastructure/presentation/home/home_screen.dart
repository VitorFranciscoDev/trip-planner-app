import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/logout_container.dart';
import 'package:trip_planner/infrastructure/presentation/providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Controller
  final TextEditingController controllerSearch = TextEditingController();

  //bool to show the log out container
  bool showLogOut = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = context.read<UserProvider>().user!.name;

    return Center(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showLogOut = !showLogOut;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Image.asset("assets/trip-planner-icon.png", height: 55),
                ),
              ),
              Text("Welcome, $name", style: TextStyle(fontFamily: "Times New Roman", fontSize: 20)),
            ],
          ),
          if(showLogOut)
            Padding(
              padding: EdgeInsets.only(right: 202, left: 25),
              child: LogOutContainer(),
            ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 25, right: 25),
            child: TextField(
              controller: controllerSearch,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}