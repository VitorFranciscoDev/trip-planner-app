import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_screen.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_state.dart';
import 'package:trip_planner/infrastructure/presentation/login/login_screen.dart';
import 'package:trip_planner/infrastructure/presentation/login/login_state.dart';
import 'package:trip_planner/infrastructure/presentation/map/map_state.dart';
import 'package:trip_planner/infrastructure/presentation/register/register_state.dart';
import 'package:trip_planner/infrastructure/presentation/theme/theme.dart';
import 'package:trip_planner/infrastructure/presentation/theme/theme_provider.dart';
import 'package:trip_planner/infrastructure/presentation/group/group_state.dart';
import 'package:trip_planner/infrastructure/presentation/trip-register/trip_register_state.dart';
import 'package:trip_planner/infrastructure/presentation/trip/trip_state.dart';
import 'package:trip_planner/infrastructure/presentation/user/user_state.dart';
import 'package:trip_planner/modules/person/person_repository.dart';
import 'package:trip_planner/modules/person/person_usecase.dart';
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

  final personRepository = PersonRepository();
  final personUseCase = PersonUseCase(personRepository: personRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider(tripUseCase: tripUseCase)),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (_) => StopsProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider(userUseCase: userUseCase)),
        ChangeNotifierProvider(create: (_) => RegisterProvider(userUseCase: userUseCase)),
        ChangeNotifierProvider(create: (_) => BottomNavigatorProvider()),
        ChangeNotifierProvider(create: (_) => TripRegisterProvider(tripUseCase: tripUseCase, personUseCase: personUseCase)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final userProvider = context.watch<UserProvider>();

    if (userProvider.isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userProvider.user != null ? BottomNavigatorScreen() : LoginScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}