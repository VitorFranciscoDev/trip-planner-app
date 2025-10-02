import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/container_recomended_stop.dart';
import 'package:trip_planner/infrastructure/presentation/login/login_state.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/logout_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerSearch = TextEditingController();

  bool showLogOut = false;

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.only(right: 325),
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
                  borderSide: const BorderSide(
                    color: Color(0xFF8B4513),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B4513),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 25, right: 25),
            child: ContainerRecomendedStop(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 25, right: 25),
            child: ContainerRecomendedStop(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40, left: 25, right: 25),
            child: ContainerRecomendedStop(),
          ),
        ],
      ),
    );
  }
}