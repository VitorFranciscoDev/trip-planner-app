import 'package:trip_planner/entities/trip.dart';
import 'package:trip_planner/entities/stop.dart';

class TripRecomendationRepository {
  
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Trip getBrazilNortheastBeaches() {
    final now = DateTime.now();
    DateTime currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Porto de Galinhas',
      img: 'assets/stops-recomendations/br-ne/portogalinhas.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -8.5014,
      longitude: -35.0042,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 2));
    final stop2 = Stop(
      location: 'Maragogi',
      img: 'assets/stops-recomendations/br-ne/maragogi.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -9.0122,
      longitude: -35.2222,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Praia do Forte',
      img: 'assets/stops-recomendations/br-ne/praiaforte.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -12.5814,
      longitude: -38.0065,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 4));
    final stop4 = Stop(
      location: 'Jericoacoara',
      img: 'assets/stops-recomendations/br-ne/jericoacoara.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -2.7928,
      longitude: -40.5147,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Arraial d\'Ajuda',
      img: 'assets/stops-recomendations/br-ne/arraial.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -16.4833,
      longitude: -39.0667,
    );
    
    return Trip(
      title: 'Praias do Nordeste Brasileiro',
      transport: "Car",
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getBrazilSouth() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Florianópolis',
      img: 'assets/stops-recomendations/br-so/floripa.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -27.5954,
      longitude: -48.5480,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 2));
    final stop2 = Stop(
      location: 'Balneário Camboriú',
      img: 'assets/stops-recomendations/br-so/balneario.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -26.9906,
      longitude: -48.6350,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Gramado',
      img: 'assets/stops-recomendations/br-so/gramado.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -29.3787,
      longitude: -50.8754,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Bombinhas',
      img: 'assets/stops-recomendations/br-so/bombinhas.jpg',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -27.1394,
      longitude: -48.5114,
    );
    
    return Trip(
      title: 'Sul do Brasil',
      transport: "Car",
      start_date: stop1.start_date,
      end_date: stop4.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4],
      group: null,
    );
  }

  Trip getBrazilSoutheast() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 5));
    final stop1 = Stop(
      location: 'Rio de Janeiro',
      img: 'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -22.9068,
      longitude: -43.1729,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Búzios',
      img: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -22.7469,
      longitude: -41.8819,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Angra dos Reis',
      img: 'https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -23.0067,
      longitude: -44.3181,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Paraty',
      img: 'https://images.unsplash.com/photo-1516490981167-dc990a242603?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -23.2175,
      longitude: -44.7164,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Ilhabela',
      img: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -23.7781,
      longitude: -45.3581,
    );
    
    return Trip(
      title: 'Litoral Sudeste',
      transport: 'car',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getWesternEurope() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Paris',
      img: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 48.8566,
      longitude: 2.3522,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Barcelona',
      img: 'https://images.unsplash.com/photo-1583422409516-2895a77efded?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 41.3851,
      longitude: 2.1734,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Madrid',
      img: 'https://images.unsplash.com/photo-1539037116277-4db20889f2d4?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 40.4168,
      longitude: -3.7038,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Lisboa',
      img: 'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 38.7223,
      longitude: -9.1393,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 2));
    final stop5 = Stop(
      location: 'Nice',
      img: 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 43.7102,
      longitude: 7.2620,
    );
    
    return Trip(
      title: 'Europa Ocidental',
      transport: 'train',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getCentralEurope() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Berlin',
      img: 'https://images.unsplash.com/photo-1560930950-5cc20e80e392?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 52.5200,
      longitude: 13.4050,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Prague',
      img: 'https://images.unsplash.com/photo-1541849546-216549ae216d?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 50.0755,
      longitude: 14.4378,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Vienna',
      img: 'https://images.unsplash.com/photo-1609856878074-cf31e21ccb9b?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 48.2082,
      longitude: 16.3738,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Munich',
      img: 'https://images.unsplash.com/photo-1595867818082-083862f3d630?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 48.1351,
      longitude: 11.5820,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 2));
    final stop5 = Stop(
      location: 'Salzburg',
      img: 'https://images.unsplash.com/photo-1536859975388-d3e293d5ca2d?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 47.8095,
      longitude: 13.0550,
    );
    
    return Trip(
      title: 'Europa Central',
      transport: 'train',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getItaly() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Rome',
      img: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 41.9028,
      longitude: 12.4964,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Florence',
      img: 'https://images.unsplash.com/photo-1541580621-b6e5a99f9d5c?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 43.7696,
      longitude: 11.2558,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Venice',
      img: 'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 45.4408,
      longitude: 12.3155,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Milan',
      img: 'https://images.unsplash.com/photo-1513581166391-887a96ddeafd?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 45.4642,
      longitude: 9.1900,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Naples',
      img: 'https://images.unsplash.com/photo-1585155793862-a601c2955e50?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 40.8518,
      longitude: 14.2681,
    );
    
    return Trip(
      title: 'Itália Clássica',
      transport: 'train',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getUSWestCoast() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Los Angeles',
      img: 'https://images.unsplash.com/photo-1534190239940-9ba8944ea261?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 34.0522,
      longitude: -118.2437,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'San Francisco',
      img: 'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 37.7749,
      longitude: -122.4194,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Las Vegas',
      img: 'https://images.unsplash.com/photo-1605833556294-ea5c7a74f57d?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 36.1699,
      longitude: -115.1398,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'San Diego',
      img: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 32.7157,
      longitude: -117.1611,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Seattle',
      img: 'https://images.unsplash.com/photo-1550838786-de47d3a5d921?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 47.6062,
      longitude: -122.3321,
    );
    
    return Trip(
      title: 'Costa Oeste Americana',
      transport: 'car',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getUSEastCoast() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 5));
    final stop1 = Stop(
      location: 'New York',
      img: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 40.7128,
      longitude: -74.0060,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Washington DC',
      img: 'https://images.unsplash.com/photo-1617581629397-a72507c3de9e?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 38.9072,
      longitude: -77.0369,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Boston',
      img: 'https://images.unsplash.com/photo-1523071929255-6fb62f9d63e7?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 42.3601,
      longitude: -71.0589,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Philadelphia',
      img: 'https://images.unsplash.com/photo-1554844728-baf58f56f34b?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 39.9526,
      longitude: -75.1652,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 4));
    final stop5 = Stop(
      location: 'Miami',
      img: 'https://images.unsplash.com/photo-1533106418989-88406c7cc8ca?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 25.7617,
      longitude: -80.1918,
    );
    
    return Trip(
      title: 'Costa Leste Americana',
      transport: 'car',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getCanada() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Toronto',
      img: 'https://images.unsplash.com/photo-1517935706615-2717063c2225?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 43.6532,
      longitude: -79.3832,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 4));
    final stop2 = Stop(
      location: 'Vancouver',
      img: 'https://images.unsplash.com/photo-1559511260-66a654ae982a?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 49.2827,
      longitude: -123.1207,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Montreal',
      img: 'https://images.unsplash.com/photo-1519659528534-7fd733a832a0?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 45.5017,
      longitude: -73.5673,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Quebec City',
      img: 'https://images.unsplash.com/photo-1535463731090-e34f4b5098c5?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 46.8139,
      longitude: -71.2080,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Banff',
      img: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 51.1784,
      longitude: -115.5708,
    );
    
    return Trip(
      title: 'Tour pelo Canadá',
      transport: 'car',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getNorthAfrica() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Marrakech',
      img: 'https://images.unsplash.com/photo-1489749798305-4fea3ae63d43?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 31.6295,
      longitude: -7.9811,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 4));
    final stop2 = Stop(
      location: 'Cairo',
      img: 'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 30.0444,
      longitude: 31.2357,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Casablanca',
      img: 'https://images.unsplash.com/photo-1558447268-bc5a8e0c8769?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 33.5731,
      longitude: -7.5898,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Fez',
      img: 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 34.0181,
      longitude: -5.0078,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Luxor',
      img: 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 25.6872,
      longitude: 32.6396,
    );
    
    return Trip(
      title: 'Norte da África',
      transport: 'plane',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getSouthAfrica() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Cape Town',
      img: 'https://images.unsplash.com/photo-1580060839134-75a5edca2e99?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -33.9249,
      longitude: 18.4241,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Johannesburg',
      img: 'https://images.unsplash.com/photo-1577948000111-9c970dfe3743?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -26.2041,
      longitude: 28.0473,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 2));
    final stop3 = Stop(
      location: 'Durban',
      img: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -29.8587,
      longitude: 31.0218,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Kruger Park',
      img: 'https://images.unsplash.com/photo-1516426122078-c23e76319801?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -23.9884,
      longitude: 31.5547,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 4));
    final stop5 = Stop(
      location: 'Garden Route',
      img: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -34.0378,
      longitude: 23.0454,
    );
    
    return Trip(
      title: 'África do Sul',
      transport: 'car',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getSoutheastAsia() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Bangkok',
      img: 'https://images.unsplash.com/photo-1528181304800-259b08848526?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 13.7563,
      longitude: 100.5018,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 5));
    final stop2 = Stop(
      location: 'Bali',
      img: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -8.4095,
      longitude: 115.1889,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Singapore',
      img: 'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 1.3521,
      longitude: 103.8198,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 4));
    final stop4 = Stop(
      location: 'Phuket',
      img: 'https://images.unsplash.com/photo-1589394815804-964ed0be2eb5?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 7.8804,
      longitude: 98.3923,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Hanoi',
      img: 'https://images.unsplash.com/photo-1528127269322-539801943592?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 21.0285,
      longitude: 105.8542,
    );
    
    return Trip(
      title: 'Sudeste Asiático',
      transport: 'plane',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getEastAsia() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Tokyo',
      img: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 35.6762,
      longitude: 139.6503,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Kyoto',
      img: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 35.0116,
      longitude: 135.7681,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 4));
    final stop3 = Stop(
      location: 'Seoul',
      img: 'https://images.unsplash.com/photo-1517154421773-0529f29ea451?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 37.5665,
      longitude: 126.9780,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 2));
    final stop4 = Stop(
      location: 'Osaka',
      img: 'https://images.unsplash.com/photo-1590559899731-a382839e5549?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 34.6937,
      longitude: 135.5023,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Busan',
      img: 'https://images.unsplash.com/photo-1583474354980-8e9b53e0c5fc?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 35.1796,
      longitude: 129.0756,
    );
    
    return Trip(
      title: 'Leste Asiático',
      transport: 'train',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getOceania() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Sydney',
      img: 'https://images.unsplash.com/photo-1523482580672-f109ba8cb9be?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -33.8688,
      longitude: 151.2093,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Melbourne',
      img: 'https://images.unsplash.com/photo-1514395462725-fb4566210144?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -37.8136,
      longitude: 144.9631,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Auckland',
      img: 'https://images.unsplash.com/photo-1507699622108-4be3abd695ad?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -36.8485,
      longitude: 174.7633,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Gold Coast',
      img: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -28.0167,
      longitude: 153.4000,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 4));
    final stop5 = Stop(
      location: 'Queenstown',
      img: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -45.0312,
      longitude: 168.6626,
    );
    
    return Trip(
      title: 'Oceania',
      transport: 'plane',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getAndes() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 3));
    final stop1 = Stop(
      location: 'Machu Picchu',
      img: 'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: -13.1631,
      longitude: -72.5450,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 2));
    final stop2 = Stop(
      location: 'Cusco',
      img: 'https://images.unsplash.com/photo-1526392060635-9d6019884377?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: -13.5319,
      longitude: -71.9675,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'La Paz',
      img: 'https://images.unsplash.com/photo-1531065208531-4036c0dba3ca?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: -16.5000,
      longitude: -68.1500,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 3));
    final stop4 = Stop(
      location: 'Santiago',
      img: 'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: -33.4489,
      longitude: -70.6693,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 2));
    final stop5 = Stop(
      location: 'Uyuni Salt Flats',
      img: 'https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: -20.3094,
      longitude: -66.8251,
    );
    
    return Trip(
      title: 'Cordilheira dos Andes',
      transport: 'car',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  Trip getMexicoCaribbean() {
    final now = DateTime.now();
    var currentDate = now.add(Duration(days: 7));
    
    final stop1End = currentDate.add(Duration(days: 4));
    final stop1 = Stop(
      location: 'Cancún',
      img: 'https://images.unsplash.com/photo-1544986581-efac024faf62?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop1End),
      latitude: 21.1619,
      longitude: -86.8515,
    );
    
    currentDate = stop1End;
    final stop2End = currentDate.add(Duration(days: 3));
    final stop2 = Stop(
      location: 'Tulum',
      img: 'https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop2End),
      latitude: 20.2114,
      longitude: -87.4654,
    );
    
    currentDate = stop2End;
    final stop3End = currentDate.add(Duration(days: 3));
    final stop3 = Stop(
      location: 'Playa del Carmen',
      img: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop3End),
      latitude: 20.6273,
      longitude: -87.0794,
    );
    
    currentDate = stop3End;
    final stop4End = currentDate.add(Duration(days: 4));
    final stop4 = Stop(
      location: 'Punta Cana',
      img: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop4End),
      latitude: 18.5601,
      longitude: -68.3725,
    );
    
    currentDate = stop4End;
    final stop5End = currentDate.add(Duration(days: 3));
    final stop5 = Stop(
      location: 'Havana',
      img: 'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=400',
      start_date: _formatDate(currentDate),
      end_date: _formatDate(stop5End),
      latitude: 23.1136,
      longitude: -82.3666,
    );
    
    return Trip(
      title: 'México e Caribe',
      transport: 'car',
      start_date: stop1.start_date,
      end_date: stop5.end_date,
      concluded: false,
      stops: [stop1, stop2, stop3, stop4, stop5],
      group: null,
    );
  }

  List<Trip> getAllRecommendations() {
    return [
      getBrazilNortheastBeaches(),
      getBrazilSouth(),
      getBrazilSoutheast(),
      getWesternEurope(),
      getCentralEurope(),
      getItaly(),
      getUSWestCoast(),
      getUSEastCoast(),
      getCanada(),
      getNorthAfrica(),
      getSouthAfrica(),
      getSoutheastAsia(),
      getEastAsia(),
      getOceania(),
      getAndes(),
      getMexicoCaribbean(),
    ];
  }
}