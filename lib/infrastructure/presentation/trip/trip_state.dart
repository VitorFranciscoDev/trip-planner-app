import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/infrastructure/presentation/auth/auth_state.dart';
import 'package:trip_planner/modules/trip/trip_usecase.dart';

class TripProvider extends ChangeNotifier {
  TripProvider({required this.tripUseCase});

  final TripUseCase tripUseCase;

  List<Trip> _trips = [];
  List<Trip> get trips => _trips;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadAllTrips(BuildContext context) async {
    final userProvider = context.read<AuthProvider>();
    _isLoading = true;
    notifyListeners();

    try {
      _trips = await tripUseCase.getAllTrips(userProvider.user!.id!);
    } catch (e) {
      _trips = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Trip?> getTripById(int id) async {
    try {
      return await tripUseCase.getTripById(id);
    } catch (e) {
      return null;
    }
  }

  Future<String?> deleteTrip(int id, BuildContext context) async {
    try {
      final result = await tripUseCase.deleteTrip(id, context);
      
      if (result == null) {
        await loadAllTrips(context);
      }
      
      return result;
    } catch (e) {
      return "Failed to delete trip";
    }
  }

  Future<String?> updateTrip(Trip trip, BuildContext context) async {
    try {
      final result = await tripUseCase.updateTrip(trip, context);
      
      if (result == null) {
        await loadAllTrips(context);
      }
      
      return result;
    } catch (e) {
      return "Failed to update trip";
    }
  }
}