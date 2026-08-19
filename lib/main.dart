import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/infrastructure.dart';
import 'package:trip_planner/infrastructure/presentation/app_state.dart';
import 'infrastructure/presentation/app/intl/app_localizations.dart';
import 'infrastructure/presentation/app/theme/theme.dart';
import 'infrastructure/presentation/auth/login_screen.dart';
import 'infrastructure/presentation/bottom-navigator/bottom_navigator_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  runApp(
    ChangeNotifierProvider(create: (_) => AppState(), child: TripPlannerApp()),
  );
}

class TripPlannerApp extends StatelessWidget {
  const TripPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return MaterialApp(
      locale: appState.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
        Locale('es', 'ES'),
      ],
      debugShowCheckedModeBanner: false,
      home: appState.appUser != null ? BottomNavigatorScreen() : LoginScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: appState.themeMode,
    );
  }
}
