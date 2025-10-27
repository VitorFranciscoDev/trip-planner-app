import 'package:trip_planner/entities/search_result.dart';

// Search Result Contracts
abstract class ISearchResultRepository {
  Future<List<SearchResult>> searchLocation(String query);
}