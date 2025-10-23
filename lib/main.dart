import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/app_global_state.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_state.dart';
import 'package:trip_planner/infrastructure/presentation/home/home_state.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/intl_state.dart';
import 'package:trip_planner/infrastructure/presentation/home/search_result_state.dart';
import 'package:trip_planner/infrastructure/presentation/app/theme/theme_provider.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/modules/person/person_usecase.dart';
import 'package:trip_planner/modules/search-result/search_result_repository.dart';
import 'package:trip_planner/modules/stop-recomendation/stop_recomendation_repository.dart';
import 'package:trip_planner/modules/trip/trip_repository.dart';
import 'package:trip_planner/modules/trip/trip_usecase.dart';
import 'package:trip_planner/modules/user/user_repository.dart';
import 'package:trip_planner/modules/user/user_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userRepository = UserRepository();
  final userUseCase = UserUseCase(userRepository: userRepository);

  final tripRepository = TripRepository();
  final tripUseCase = TripUseCase(tripRepository: tripRepository);

  final personUseCase = PersonUseCase();

  final stopRecomendationRepository = StopRecomendationRepository();

  final searchResultRepository = SearchResultRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IntlProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider(userUseCase: userUseCase)),
        ChangeNotifierProvider(create: (_) => TripProvider(tripUseCase: tripUseCase, personUseCase: personUseCase)),
        ChangeNotifierProvider(create: (_) => BottomNavigatorProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider(stopRecomendationRepository: stopRecomendationRepository)),
        ChangeNotifierProvider(create: (_) => SearchResultProvider(searchResultRepository: searchResultRepository)),
      ],
      child: const MyApp(),
    ),
  );
}
