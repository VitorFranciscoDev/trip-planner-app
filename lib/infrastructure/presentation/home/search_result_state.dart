import 'package:flutter/material.dart';
import 'package:trip_planner/entities/search_result.dart';
import 'package:trip_planner/modules/search-result/search_result_repository.dart';

class SearchResultProvider with ChangeNotifier {
  SearchResultProvider({required this.searchResultRepository});

  final SearchResultRepository searchResultRepository;

  List<SearchResult> _searchResults = [];
  List<SearchResult> get searchResults => _searchResults;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  String _query = '';
  String get query => _query;

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
      _searchResults = await searchResultRepository.searchLocation(query);
    } catch (e) {
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _query = '';
    _searchResults = [];
    notifyListeners();
  }
}