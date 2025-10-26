import 'package:trip_planner/entities/trip.dart';

// Trip Recomendations Contracts
abstract class ITripRecomendationRepository {
  Trip getBrazilNortheastBeaches();
  Trip getBrazilSouth();
  Trip getBrazilSoutheast();
  Trip getWesternEurope();
  Trip getCentralEurope();
  Trip getItaly();
  Trip getUSWestCoast();
  Trip getUSEastCoast();
  Trip getCanada();
  Trip getNorthAfrica();
  Trip getSouthAfrica();
  Trip getSoutheastAsia();
  Trip getEastAsia();
  Trip getOceania();
  Trip getAndes();
  Trip getMexicoCaribbean();
  List<Trip> getAllRecommendations();
}