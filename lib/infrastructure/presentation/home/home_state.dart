import 'package:flutter/material.dart';
import 'package:trip_planner/entities/stop_recomendation.dart';
import 'package:trip_planner/modules/stop-recomendation/stop_recomendation_repository.dart';

class HomeProvider with ChangeNotifier {
  final StopRecomendationRepository stopRecomendationRepository;

  HomeProvider({ required this.stopRecomendationRepository }) {
    loadRecommendations();
  }

  List<StopRecomendation> _brNERecommendations = [];
  List<StopRecomendation> _brSORecommendations = [];

  List<StopRecomendation> get brNERecommendations => _brNERecommendations;
  List<StopRecomendation> get brSORecommendations => _brSORecommendations;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void loadRecommendations() {
    _isLoading = true;
    notifyListeners();

    try {
      _brNERecommendations = stopRecomendationRepository.getBrazilNortheastBeaches();
      _brSORecommendations = stopRecomendationRepository.getBrazilSouth();
    } catch (e) {
      _brNERecommendations = [];
      _brSORecommendations = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}