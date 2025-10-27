import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/alert_dialog_component.dart';
import 'package:trip_planner/infrastructure/presentation/app/components/recomendations_list_component.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_state.dart';
import 'package:trip_planner/infrastructure/presentation/home/home_state.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller
  final TextEditingController controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final intl = AppLocalizations.of(context);
    final name = context.read<AuthProvider>().user!.name;
    final provider = context.watch<HomeProvider>();
    final List<Trip> tripRecomendations = provider.loadRecomendations();
    final recomendation1 = tripRecomendations[0];
    final recomendation2 = tripRecomendations[1];

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Image.asset(
                  "assets/logos/trip-planner-icon.png",
                  height: 55,
                ),
              ),
              Text(
                intl.welcomeUser(name),
                style: TextStyle(
                  fontFamily: "Times New Roman", 
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: controllerSearch,
              decoration: InputDecoration(
                hintText: intl.searchDestinations,
                prefixIcon: Icon(Icons.search),
                suffixIcon: controllerSearch.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                      onPressed: () {
                        controllerSearch.clear();
                        provider.clearSearch();
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
          if (provider.isSearching)
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
            else if (provider.searchResults.isNotEmpty)
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
                  itemCount: provider.searchResults.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final result = provider.searchResults[index];
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
                        provider.clearSearch();
                      },
                    );
                  },
                ),
              )
            else if (provider.query.isNotEmpty && 
                      provider.query.length >= 3 &&
                      !provider.isSearching)
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
                child: Text(
                  'No results found',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: RecomendationsListComponent(
              tripRecomendation: recomendation1, 
              fn: () {
                showDialog(
                  context: context, 
                  builder: (dialogContext) => AlertDialogComponent(
                    title: "Select Trip?", 
                    fn1: () => Navigator.of(context).pop(),
                    fn1Message: "No",
                    fn2: () {
                      context.read<TripProvider>().trip = recomendation1;
                      Navigator.of(dialogContext).pop();
                      context.read<BottomNavigatorProvider>().setIndex(1);
                    },
                    fn2Message: "Yes",
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: RecomendationsListComponent(
              tripRecomendation: recomendation2,
              fn: () {
                showDialog(
                  context: context, 
                  builder: (dialogContext) => AlertDialogComponent(
                    title: "Select Trip?", 
                    fn1: () => Navigator.of(context).pop(),
                    fn1Message: "No",
                    fn2: () {
                      context.read<TripProvider>().trip = recomendation2;
                      Navigator.of(dialogContext).pop();
                      context.read<BottomNavigatorProvider>().setIndex(1);
                    },
                    fn2Message: "Yes",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
