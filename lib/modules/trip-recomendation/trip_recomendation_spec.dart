import 'package:flutter/material.dart';
import 'package:trip_planner/entities/trip.dart';

// Trip Recomendations Contracts
abstract class ITripRecomendationRepository {
  Trip getBrazilNortheastBeaches(BuildContext context);
  Trip getBrazilSouth(BuildContext context);
  Trip getBrazilSoutheast(BuildContext context);
  Trip getWesternEurope(BuildContext context);
  Trip getCentralEurope(BuildContext context);
  Trip getItaly(BuildContext context);
  Trip getUSWestCoast(BuildContext context);
  Trip getUSEastCoast(BuildContext context);
  Trip getCanada(BuildContext context);
  Trip getNorthAfrica(BuildContext context);
  Trip getSouthAfrica(BuildContext context);
  Trip getSoutheastAsia(BuildContext context);
  Trip getEastAsia(BuildContext context);
  Trip getOceania(BuildContext context);
  Trip getAndes(BuildContext context);
  Trip getMexicoCaribbean(BuildContext context);
  List<Trip> getAllRecommendations(BuildContext context);
}