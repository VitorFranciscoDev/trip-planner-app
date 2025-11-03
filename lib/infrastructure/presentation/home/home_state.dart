import 'package:flutter/material.dart';
import 'package:trip_planner/entities/search_result.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/search-result/search_result_usecase.dart';
import 'package:trip_planner/modules/trip-recomendation/trip_recomendation_usecase.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({ required this.tripRecomendationUseCase, required this.searchResultUseCase });

  final TripRecomendationUseCase tripRecomendationUseCase;
  final SearchResultUseCase searchResultUseCase;

  String _query = '';
  String get query => _query;

  List<SearchResult> _searchResults = [];
  List<SearchResult> get searchResults => _searchResults;

  Trip? recomendation1;
  Trip? recomendation2;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void loadRecomendations(BuildContext context) {
    if (recomendation1 != null) {
      return; 
    }

    List<Trip> temp = tripRecomendationUseCase.getTwoRecomendations(context);
    recomendation1 = temp[0];
    recomendation2 = temp[1];
  }

  Future<void> searchLocations(String query) async {
    _query = query;
    
    if (_query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await searchResultUseCase.searchLocation(_query);
    } catch (e) {
      _searchResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _query = '';
    _searchResults = [];
    notifyListeners();
  }
}
