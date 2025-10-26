import 'package:flutter/material.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/trip-recomendation/trip_recomendation_repository.dart';

class HomeProvider with ChangeNotifier {
  final TripRecomendationRepository tripRecomendationRepository;

  HomeProvider({ required this.tripRecomendationRepository }) {
    loadRecommendations();
  }

  late Trip _brNERecommendations;
  late Trip _brSORecommendations;

  Trip get brNERecommendations => _brNERecommendations;
  Trip get brSORecommendations => _brSORecommendations;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void loadRecommendations() {
    _isLoading = true;
    notifyListeners();

    try {
      _brNERecommendations = tripRecomendationRepository.getBrazilNortheastBeaches();
      _brSORecommendations = tripRecomendationRepository.getBrazilSouth();
    } catch (e) {
      throw Exception("Error in Loading Recomended Trips: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}