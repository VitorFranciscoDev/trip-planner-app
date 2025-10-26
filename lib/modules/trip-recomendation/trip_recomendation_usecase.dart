import 'dart:math';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/modules/trip-recomendation/trip_recomendation_repository.dart';

// Trip Recomendations Use Cases
class TripRecomendationUseCase {
  TripRecomendationUseCase({ required this.tripRecomendationRepository });

  final TripRecomendationRepository tripRecomendationRepository;

  // Get Two Random Recomendations
  List<Trip> getTwoRecomendations() {
    final allTripRecomendations = tripRecomendationRepository.getAllRecommendations();

    final index1 = Random().nextInt(allTripRecomendations.length);
    int index2 = Random().nextInt(allTripRecomendations.length);

    while(index2 == index1) {
      index2 = Random().nextInt(allTripRecomendations.length);
    }

    // Return the two recomendations
    return [
      allTripRecomendations[index1],
      allTripRecomendations[index2],
    ];
  }
}