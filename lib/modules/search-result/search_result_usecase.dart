import 'package:trip_planner/entities/search_result.dart';
import 'package:trip_planner/modules/search-result/search_result_spec.dart';

// Search Result Use Cases
class SearchResultUseCase {
  SearchResultUseCase({ required this.searchResultRepository });

  final ISearchResultRepository searchResultRepository;

  Future<List<SearchResult>> searchLocation(String query) async {
    try {
      // Returns location
      return await searchResultRepository.searchLocation(query);
    } catch(e) {
      throw Exception("Error in Search Location Use Case: $e");
    }
  }
}