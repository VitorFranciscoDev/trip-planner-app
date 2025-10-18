import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/home/home_state.dart';
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
    final provider = context.read<HomeProvider>();
    final list1 = provider.brNERecommendations;
    final list2 = provider.brSORecommendations;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Image.asset(
                    "assets/logos/trip-planner-icon.png",
                    height: 55,
                  ),
                ),
                Text(
                  "Welcome, $name",
                  style: TextStyle(fontFamily: "Times New Roman", fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 25, right: 25),
            child: TextField(
              controller: controllerSearch,
              decoration: InputDecoration(
                hintText: "Search destinations...",
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
            padding: EdgeInsets.only(top: 30),
            child: GestureDetector(
              child: Container(
                width: 360,
                height: 220,
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Text(
                          "Nordeste Brasileiro",
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.colorScheme.primary,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                        Spacer(),
                        Text(
                          "30 days",
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.colorScheme.primary,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list1.length,
                        itemBuilder: (context, index) {
                          final location = list1[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        location.img,
                                        fit: BoxFit.cover,
                                        width: 170,
                                        height: 130,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_right, size: 30),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, right: 20),
                                child: Text(
                                  location.name,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontFamily: "Times New Roman",
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: GestureDetector(
              child: Container(
                width: 360,
                height: 220,
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Text(
                          "Sul do Brasil",
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.colorScheme.primary,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                        Spacer(),
                        Text(
                          "30 days",
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.colorScheme.primary,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list2.length,
                        itemBuilder: (context, index) {
                          final location = list2[index];
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        location.img,
                                        fit: BoxFit.cover,
                                        width: 170,
                                        height: 130,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_right, size: 30),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, right: 20),
                                child: Text(
                                  location.name,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontFamily: "Times New Roman",
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
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
