import 'package:flutter/cupertino.dart';
import 'package:trip_planner/entities/entity_user.dart';
import 'package:trip_planner/infrastructure/infrastructure.dart';

/// Represents the state for the application.
class AppState with ChangeNotifier {
  /// Default constructor.
  AppState() {
    _init();
  }

  AppUser? _appUser;
  var _loading = false;

  Future<void> _init() async {
    _loading = true;
    notifyListeners();

    _appUser = await appUserUseCase.getUserInformation();

    _loading = false;
    notifyListeners();
  }
}
