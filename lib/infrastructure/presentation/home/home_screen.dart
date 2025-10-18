import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/home/home_state.dart';
import 'package:trip_planner/infrastructure/presentation/search-result/search_result_state.dart';
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
    final provider = context.watch<HomeProvider>();
    final searchProvider = context.watch<SearchResultProvider>();
    final recomendation1 = provider.brNERecommendations;
    final recomendation2 = provider.brSORecommendations;

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
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 40),
            child: TextField(
              controller: controllerSearch,
              decoration: InputDecoration(
                hintText: "Search destinations...",
                prefixIcon: Icon(Icons.search),
                suffixIcon: controllerSearch.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                      onPressed: () {
                        controllerSearch.clear();
                        searchProvider.clearSearch();
                      },
                  )
                  : null,
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
          if (searchProvider.isSearching)
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
            else if (searchProvider.searchResults.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchProvider.searchResults.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final result = searchProvider.searchResults[index];
                    return ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: theme.colorScheme.secondary,
                      ),
                      title: Text(
                        result.displayName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Selected: ${result.displayName}\n'
                              'Lat: ${result.position.latitude.toStringAsFixed(4)}, '
                              'Lng: ${result.position.longitude.toStringAsFixed(4)}',
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                        controllerSearch.clear();
                        searchProvider.clearSearch();
                      },
                    );
                  },
                ),
              )
            else if (searchProvider.query.isNotEmpty && 
                      searchProvider.query.length >= 3 &&
                      !searchProvider.isSearching)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  'No results found',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          GestureDetector(
            child: Container(
              width: 360,
              height: 220,
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 3, color: theme.colorScheme.primary),
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
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "30 days",
                        style: TextStyle(
                          fontSize: 15,
                          color: theme.colorScheme.primary,
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recomendation1.length,
                      itemBuilder: (context, index) {
                        final location = recomendation1[index];
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
                                  fontWeight: FontWeight.w700,
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
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: GestureDetector(
              child: Container(
                width: 360,
                height: 220,
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 3, color: theme.colorScheme.primary),
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
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "30 days",
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.colorScheme.primary,
                            fontFamily: "Times New Roman",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recomendation2.length,
                        itemBuilder: (context, index) {
                          final location = recomendation2[index];
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
                                    fontWeight: FontWeight.w700,
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
