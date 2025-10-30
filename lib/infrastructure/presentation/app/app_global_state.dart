import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/infrastructure/presentation/bottom-navigator/bottom_navigator_screen.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/intl_state.dart';
import 'package:trip_planner/infrastructure/presentation/auth/login_screen.dart';
import 'package:trip_planner/infrastructure/presentation/app/theme/theme.dart';
import 'package:trip_planner/infrastructure/presentation/app/theme/theme_provider.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final intlProvider = context.watch<IntlProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final userProvider = context.watch<AuthProvider>();

    if (userProvider.isLoading || intlProvider.isLoading) {
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
      locale: intlProvider.locale,
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
      home: userProvider.user != null ? BottomNavigatorScreen() : LoginScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}