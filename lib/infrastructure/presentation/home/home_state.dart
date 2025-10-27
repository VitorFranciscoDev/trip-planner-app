import 'package:flutter/material.dart';
import 'package:trip_planner/entities/search_result.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/search-result/search_result_usecase.dart';
import 'package:trip_planner/modules/trip-recomendation/trip_recomendation_usecase.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({ required this.tripRecomendationUseCase, required this.searchResultUseCase }) {
    loadRecomendations();
  }

  // Use Cases
  final TripRecomendationUseCase tripRecomendationUseCase;
  final SearchResultUseCase searchResultUseCase;

  // Query from User
  String _query = '';
  String get query => _query;

  // Search Results
  List<SearchResult> _searchResults = [];
  List<SearchResult> get searchResults => _searchResults;

  // Trip Recomendations
  late Trip recomendation1;
  late Trip recomendation2;

  // Searching boolean
  bool _isSearching = false;
  bool get isSearching => _isSearching;


  // Load Recomendations
  void loadRecomendations() {
    List<Trip> temp = tripRecomendationUseCase.getTwoRecomendations();
    recomendation1 = temp[0];
    recomendation2 = temp[1];
  }

  // Search Location based on the query
  Future<void> searchLocations(String query) async {
    _query = query;
    
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners();

    try {
      _searchResults = await searchResultUseCase.searchLocation(query);
    } catch (e) {
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  // Clear the search
  void clearSearch() {
    _query = '';
    _searchResults = [];
    notifyListeners();
  }
}
