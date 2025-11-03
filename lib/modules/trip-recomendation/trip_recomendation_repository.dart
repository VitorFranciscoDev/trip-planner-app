import 'package:flutter/material.dart';
import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/entities/stop.dart';
import 'package:trip_planner/infrastructure/presentation/app/intl/app_localizations.dart';
import 'package:trip_planner/modules/trip-recomendation/trip_recomendation_spec.dart';

// Implementation of Trip Recomendation Repository [Mocked Data]
class TripRecomendationRepository implements ITripRecomendationRepository {
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Trip getBrazilNortheastBeaches(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    DateTime currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Porto de Galinhas',
      img: 'assets/trip-recomendations/br-northeast/portogalinhas.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -8.5014,
      longitude: -35.0042,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 2));
    final stop2 = Stop(
      location: 'Maragogi',
      img: 'assets/trip-recomendations/br-northeast/maragogi.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -9.0122,
      longitude: -35.2222,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Praia do Forte',
      img: 'assets/trip-recomendations/br-northeast/praiaforte.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -12.5814,
      longitude: -38.0065,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 4));
    final stop4 = Stop(
      location: 'Jericoacoara',
      img: 'assets/trip-recomendations/br-northeast/jericoacoara.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -2.7928,
      longitude: -40.5147,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Arraial d\'Ajuda',
      img: 'assets/trip-recomendations/br-northeast/arraial.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -16.4833,
      longitude: -39.0667,
    );
    
    return Trip(
      title: 'Praias do Nordeste Brasileiro',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getBrazilSouth(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Florianópolis',
      img: 'assets/trip-recomendations/br-south/floripa.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -27.5954,
      longitude: -48.5480,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 2));
    final stop2 = Stop(
      location: 'Balneário Camboriú',
      img: 'assets/trip-recomendations/br-south/balneario.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -26.9906,
      longitude: -48.6350,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Gramado',
      img: 'assets/trip-recomendations/br-south/gramado.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -29.3787,
      longitude: -50.8754,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Bombinhas',
      img: 'assets/trip-recomendations/br-south/bombinhas.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -27.1394,
      longitude: -48.5114,
    );
    
    return Trip(
      title: 'Sul do Brasil',
      transport: intl.car,
      start_date: stop1.start_date,
      end_date: stop4.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4],
      group: null,
    );
  }

  @override
  Trip getBrazilSoutheast(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 5));
    final stop1 = Stop(
      location: 'Rio de Janeiro',
      img: 'assets/trip-recomendations/br-southeast/rio.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -22.9068,
      longitude: -43.1729,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Búzios',
      img: 'assets/trip-recomendations/br-southeast/buzios.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -22.7469,
      longitude: -41.8819,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Angra dos Reis',
      img: 'assets/trip-recomendations/br-southeast/angra.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -23.0067,
      longitude: -44.3181,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Paraty',
      img: 'assets/trip-recomendations/br-southeast/paraty.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -23.2175,
      longitude: -44.7164,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Ilhabela',
      img: 'assets/trip-recomendations/br-southeast/ilhabela.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -23.7781,
      longitude: -45.3581,
    );
    
    return Trip(
      title: 'Litoral Sudeste',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getWesternEurope(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Paris',
      img: 'assets/trip-recomendations/western-eu/paris.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 48.8566,
      longitude: 2.3522,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Barcelona',
      img: 'assets/trip-recomendations/western-eu/barcelona.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 41.3851,
      longitude: 2.1734,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Madrid',
      img: 'assets/trip-recomendations/western-eu/madrid.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 40.4168,
      longitude: -3.7038,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Lisboa',
      img: 'assets/trip-recomendations/western-eu/lisboa.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 38.7223,
      longitude: -9.1393,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 2));
    final stop5 = Stop(
      location: 'Nice',
      img: 'assets/trip-recomendations/western-eu/nice.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 43.7102,
      longitude: 7.2620,
    );
    
    return Trip(
      title: 'Europa Ocidental',
      transport: intl.motorcycle,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getCentralEurope(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Berlin',
      img: 'assets/trip-recomendations/central-eu/berlin.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 52.5200,
      longitude: 13.4050,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Prague',
      img: 'assets/trip-recomendations/central-eu/prague.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 50.0755,
      longitude: 14.4378,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Vienna',
      img: 'assets/trip-recomendations/central-eu/vienna.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 48.2082,
      longitude: 16.3738,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Munich',
      img: 'assets/trip-recomendations/central-eu/munich.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 48.1351,
      longitude: 11.5820,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 2));
    final stop5 = Stop(
      location: 'Salzburg',
      img: 'assets/trip-recomendations/central-eu/salzburg.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 47.8095,
      longitude: 13.0550,
    );
    
    return Trip(
      title: 'Europa Central',
      transport: intl.car,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getItaly(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Rome',
      img: 'assets/trip-recomendations/italy/roma.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 41.9028,
      longitude: 12.4964,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Florence',
      img: 'assets/trip-recomendations/italy/florence.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 43.7696,
      longitude: 11.2558,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Venice',
      img: 'assets/trip-recomendations/italy/venice.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 45.4408,
      longitude: 12.3155,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Milan',
      img: 'assets/trip-recomendations/italy/milan.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 45.4642,
      longitude: 9.1900,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Naples',
      img: 'assets/trip-recomendations/italy/naples.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 40.8518,
      longitude: 14.2681,
    );
    
    return Trip(
      title: 'Itália Clássica',
      transport: intl.car,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getUSWestCoast(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Los Angeles',
      img: 'assets/trip-recomendations/us-west-coast/losangeles.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 34.0522,
      longitude: -118.2437,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'San Francisco',
      img: 'assets/trip-recomendations/us-west-coast/sanfrancisco.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 37.7749,
      longitude: -122.4194,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Las Vegas',
      img: 'assets/trip-recomendations/us-west-coast/lasvegas.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 36.1699,
      longitude: -115.1398,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'San Diego',
      img: 'assets/trip-recomendations/us-west-coast/sandiego.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 32.7157,
      longitude: -117.1611,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Seattle',
      img: 'assets/trip-recomendations/us-west-coast/seattle.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 47.6062,
      longitude: -122.3321,
    );
    
    return Trip(
      title: 'Costa Oeste Americana',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getUSEastCoast(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 5));
    final stop1 = Stop(
      location: 'New York',
      img: 'assets/trip-recomendations/us-east-coast/newyork.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 40.7128,
      longitude: -74.0060,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Washington DC',
      img: 'assets/trip-recomendations/us-east-coast/washington.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 38.9072,
      longitude: -77.0369,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Boston',
      img: 'assets/trip-recomendations/us-east-coast/boston.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 42.3601,
      longitude: -71.0589,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Philadelphia',
      img: 'assets/trip-recomendations/us-east-coast/philadelphia.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 39.9526,
      longitude: -75.1652,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 4));
    final stop5 = Stop(
      location: 'Miami',
      img: 'assets/trip-recomendations/us-east-coast/miami.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 25.7617,
      longitude: -80.1918,
    );
    
    return Trip(
      title: 'Costa Leste Americana',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getCanada(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Toronto',
      img: 'assets/trip-recomendations/canada/toronto.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 43.6532,
      longitude: -79.3832,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 4));
    final stop2 = Stop(
      location: 'Vancouver',
      img: 'assets/trip-recomendations/canada/vancouver.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 49.2827,
      longitude: -123.1207,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Montreal',
      img: 'assets/trip-recomendations/canada/montreal.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 45.5017,
      longitude: -73.5673,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Quebec City',
      img: 'assets/trip-recomendations/canada/quebec.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 46.8139,
      longitude: -71.2080,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Banff',
      img: 'assets/trip-recomendations/canada/banff.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 51.1784,
      longitude: -115.5708,
    );
    
    return Trip(
      title: 'Tour pelo Canadá',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getNorthAfrica(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Marrakech',
      img: 'assets/trip-recomendations/north-africa/marrakech.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 31.6295,
      longitude: -7.9811,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 4));
    final stop2 = Stop(
      location: 'Cairo',
      img: 'assets/trip-recomendations/north-africa/cairo.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 30.0444,
      longitude: 31.2357,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Casablanca',
      img: 'assets/trip-recomendations/north-africa/casablanca.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 33.5731,
      longitude: -7.5898,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Fez',
      img: 'assets/trip-recomendations/north-africa/fez.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 34.0181,
      longitude: -5.0078,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Luxor',
      img: 'assets/trip-recomendations/north-africa/luxor.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 25.6872,
      longitude: 32.6396,
    );
    
    return Trip(
      title: 'Norte da África',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getSouthAfrica(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Cape Town',
      img: 'assets/trip-recomendations/south-africa/capetown.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -33.9249,
      longitude: 18.4241,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Johannesburg',
      img: 'assets/trip-recomendations/south-africa/johannesburg.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -26.2041,
      longitude: 28.0473,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Durban',
      img: 'assets/trip-recomendations/south-africa/durban.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -29.8587,
      longitude: 31.0218,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Kruger Park',
      img: 'assets/trip-recomendations/south-africa/krugerpark.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -23.9884,
      longitude: 31.5547,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 4));
    final stop5 = Stop(
      location: 'Garden Route',
      img: 'assets/trip-recomendations/south-africa/gardenroute.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -34.0378,
      longitude: 23.0454,
    );
    
    return Trip(
      title: 'África do Sul',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getSoutheastAsia(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Bangkok',
      img: 'assets/trip-recomendations/southeast-asia/bangkok.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 13.7563,
      longitude: 100.5018,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 5));
    final stop2 = Stop(
      location: 'Bali',
      img: 'assets/trip-recomendations/southeast-asia/bali.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -8.4095,
      longitude: 115.1889,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Singapore',
      img: 'assets/trip-recomendations/southeast-asia/singapore.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 1.3521,
      longitude: 103.8198,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 4));
    final stop4 = Stop(
      location: 'Phuket',
      img: 'assets/trip-recomendations/southeast-asia/phuket.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 7.8804,
      longitude: 98.3923,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Hanoi',
      img: 'assets/trip-recomendations/southeast-asia/hanoi.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 21.0285,
      longitude: 105.8542,
    );
    
    return Trip(
      title: 'Sudeste Asiático',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getEastAsia(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Tokyo',
      img: 'assets/trip-recomendations/east-asia/tokyo.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 35.6762,
      longitude: 139.6503,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Kyoto',
      img: 'assets/trip-recomendations/east-asia/kyoto.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 35.0116,
      longitude: 135.7681,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 4));
    final stop3 = Stop(
      location: 'Seoul',
      img: 'assets/trip-recomendations/east-asia/seoul.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 37.5665,
      longitude: 126.9780,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Osaka',
      img: 'assets/trip-recomendations/east-asia/osaka.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 34.6937,
      longitude: 135.5023,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Busan',
      img: 'assets/trip-recomendations/east-asia/busan.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 35.1796,
      longitude: 129.0756,
    );
    
    return Trip(
      title: 'Leste Asiático',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getOceania(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Sydney',
      img: 'assets/trip-recomendations/oceania/sydney.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -33.8688,
      longitude: 151.2093,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Melbourne',
      img: 'assets/trip-recomendations/oceania/melbourne.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -37.8136,
      longitude: 144.9631,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Auckland',
      img: 'assets/trip-recomendations/oceania/auckland.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -36.8485,
      longitude: 174.7633,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Gold Coast',
      img: 'assets/trip-recomendations/oceania/goldcoast.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -28.0167,
      longitude: 153.4000,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 4));
    final stop5 = Stop(
      location: 'Queenstown',
      img: 'assets/trip-recomendations/oceania/queenstown.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -45.0312,
      longitude: 168.6626,
    );
    
    return Trip(
      title: 'Oceania',
      transport: intl.airplane,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getAndes(BuildContext context) {
    final intl = AppLocalizations.of(context);
    
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Machu Picchu',
      img: 'assets/trip-recomendations/andes/machupicchu.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -13.1631,
      longitude: -72.5450,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 2));
    final stop2 = Stop(
      location: 'Cusco',
      img: 'assets/trip-recomendations/andes/cusco.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -13.5319,
      longitude: -71.9675,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'La Paz',
      img: 'assets/trip-recomendations/andes/lapaz.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -16.5000,
      longitude: -68.1500,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Santiago',
      img: 'assets/trip-recomendations/andes/santiago.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -33.4489,
      longitude: -70.6693,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 2));
    final stop5 = Stop(
      location: 'Uyuni Salt Flats',
      img: 'assets/trip-recomendations/andes/uyunisaltflats.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -20.3094,
      longitude: -66.8251,
    );
    
    return Trip(
      title: 'Cordilheira dos Andes',
      transport: intl.car,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  Trip getMexicoCaribbean(BuildContext context) {
    final intl = AppLocalizations.of(context);

    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Cancún',
      img: 'assets/trip-recomendations/mexico-caribbean/cancun.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 21.1619,
      longitude: -86.8515,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Tulum',
      img: 'assets/trip-recomendations/mexico-caribbean/tulum.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 20.2114,
      longitude: -87.4654,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Playa del Carmen',
      img: 'assets/trip-recomendations/mexico-caribbean/playadelcarmen.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 20.6273,
      longitude: -87.0794,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 4));
    final stop4 = Stop(
      location: 'Punta Cana',
      img: 'assets/trip-recomendations/mexico-caribbean/puntacana.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 18.5601,
      longitude: -68.3725,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Havana',
      img: 'assets/trip-recomendations/mexico-caribbean/havana.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 23.1136,
      longitude: -82.3666,
    );
    
    return Trip(
      title: 'México e Caribe',
      transport: intl.ship,
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  @override
  List<Trip> getAllRecommendations(BuildContext context) {
    return [
      getBrazilNortheastBeaches(context),
      getBrazilSouth(context),
      getBrazilSoutheast(context),
      getWesternEurope(context),
      getCentralEurope(context),
      getItaly(context),
      getUSWestCoast(context),
      getUSEastCoast(context),
      getCanada(context),
      getNorthAfrica(context),
      getSouthAfrica(context),
      getSoutheastAsia(context),
      getEastAsia(context),
      getOceania(context),
      getAndes(context),
      getMexicoCaribbean(context),
    ];
  }
}