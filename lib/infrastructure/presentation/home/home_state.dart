import 'package:flutter/material.dart';
import 'package:trip_planner/entities/search_result.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/search-result/search_result_usecase.dart';
import 'package:trip_planner/modules/trip-recomendation/trip_recomendation_usecase.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider({ required this.tripRecomendationUseCase, required this.searchResultUseCase });

  // Use Cases
  final TripRecomendationUseCase tripRecomendationUseCase;
  final SearchResultUseCase searchResultUseCase;

  // Search Results
  List<SearchResult> _searchResults = [];
  List<SearchResult> get searchResults => _searchResults;

  // Searching boolean
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  // Query from User
  String _query = '';
  String get query => _query;

  // Load Recomendations
  List<Trip> loadRecomendations() {
    return tripRecomendationUseCase.getTwoRecomendations();
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
