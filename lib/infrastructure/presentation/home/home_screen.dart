import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/user/user_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Controller
  final TextEditingController controllerSearch = TextEditingController();

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
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Image.asset("assets/trip-planner-icon.png", height: 55),
              ),
              Text("Welcome, $name", style: TextStyle(fontFamily: "Times New Roman", fontSize: 20)),
            ],
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
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: GestureDetector(
              child: Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.8,
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {

                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: GestureDetector(
              child: Container(
                width: 360,
                height: 200,
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.8,
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {

                    },
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