import 'package:trip_planner/entities/stop_recomendation.dart';

class StopRecomendationRepository {
  
  List<StopRecomendation> getBrazilNortheastBeaches() {
    return [
      StopRecomendation(
        name: 'Porto de Galinhas',
        img: 'assets/stops-recomendations/br-ne/portogalinhas.jpg',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Maragogi',
        img: 'assets/stops-recomendations/br-ne/maragogi.jpg',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Praia do Forte',
        img: 'assets/stops-recomendations/br-ne/praiaforte.jpg',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Jericoacoara',
        img: 'assets/stops-recomendations/br-ne/jericoacoara.jpg',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Arraial d\'Ajuda',
        img: 'assets/stops-recomendations/br-ne/arraial.jpg',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getBrazilSouth() {
    return [
      StopRecomendation(
        name: 'Florianópolis',
        img: 'assets/stops-recomendations/br-so/floripa.jpg',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Balneário Camboriú',
        img: 'assets/stops-recomendations/br-so/balneario.jpg',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Gramado',
        img: 'assets/stops-recomendations/br-so/gramado.jpg',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Bombinhas',
        img: 'assets/stops-recomendations/br-so/bombinhas.jpg',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getBrazilSoutheast() {
    return [
      StopRecomendation(
        name: 'Rio de Janeiro',
        img: 'https://images.unsplash.com/photo-1483729558449-99ef09a8c325?w=400',
        duration: 5,
      ),
      StopRecomendation(
        name: 'Búzios',
        img: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Angra dos Reis',
        img: 'https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Paraty',
        img: 'https://images.unsplash.com/photo-1516490981167-dc990a242603?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Ilhabela',
        img: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getWesternEurope() {
    return [
      StopRecomendation(
        name: 'Paris',
        img: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Barcelona',
        img: 'https://images.unsplash.com/photo-1583422409516-2895a77efded?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Madrid',
        img: 'https://images.unsplash.com/photo-1539037116277-4db20889f2d4?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Lisboa',
        img: 'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Nice',
        img: 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=400',
        duration: 2,
      ),
    ];
  }

  List<StopRecomendation> getCentralEurope() {
    return [
      StopRecomendation(
        name: 'Berlin',
        img: 'https://images.unsplash.com/photo-1560930950-5cc20e80e392?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Prague',
        img: 'https://images.unsplash.com/photo-1541849546-216549ae216d?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Vienna',
        img: 'https://images.unsplash.com/photo-1609856878074-cf31e21ccb9b?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Munich',
        img: 'https://images.unsplash.com/photo-1595867818082-083862f3d630?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Salzburg',
        img: 'https://images.unsplash.com/photo-1536859975388-d3e293d5ca2d?w=400',
        duration: 2,
      ),
    ];
  }

  List<StopRecomendation> getItaly() {
    return [
      StopRecomendation(
        name: 'Rome',
        img: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Florence',
        img: 'https://images.unsplash.com/photo-1541580621-b6e5a99f9d5c?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Venice',
        img: 'https://images.unsplash.com/photo-1523906834658-6e24ef2386f9?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Milan',
        img: 'https://images.unsplash.com/photo-1513581166391-887a96ddeafd?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Naples',
        img: 'https://images.unsplash.com/photo-1585155793862-a601c2955e50?w=400',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getUSWestCoast() {
    return [
      StopRecomendation(
        name: 'Los Angeles',
        img: 'https://images.unsplash.com/photo-1534190239940-9ba8944ea261?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'San Francisco',
        img: 'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Las Vegas',
        img: 'https://images.unsplash.com/photo-1605833556294-ea5c7a74f57d?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'San Diego',
        img: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Seattle',
        img: 'https://images.unsplash.com/photo-1550838786-de47d3a5d921?w=400',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getUSEastCoast() {
    return [
      StopRecomendation(
        name: 'New York',
        img: 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=400',
        duration: 5,
      ),
      StopRecomendation(
        name: 'Washington DC',
        img: 'https://images.unsplash.com/photo-1617581629397-a72507c3de9e?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Boston',
        img: 'https://images.unsplash.com/photo-1523071929255-6fb62f9d63e7?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Philadelphia',
        img: 'https://images.unsplash.com/photo-1554844728-baf58f56f34b?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Miami',
        img: 'https://images.unsplash.com/photo-1533106418989-88406c7cc8ca?w=400',
        duration: 4,
      ),
    ];
  }

  List<StopRecomendation> getCanada() {
    return [
      StopRecomendation(
        name: 'Toronto',
        img: 'https://images.unsplash.com/photo-1517935706615-2717063c2225?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Vancouver',
        img: 'https://images.unsplash.com/photo-1559511260-66a654ae982a?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Montreal',
        img: 'https://images.unsplash.com/photo-1519659528534-7fd733a832a0?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Quebec City',
        img: 'https://images.unsplash.com/photo-1535463731090-e34f4b5098c5?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Banff',
        img: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getNorthAfrica() {
    return [
      StopRecomendation(
        name: 'Marrakech',
        img: 'https://images.unsplash.com/photo-1489749798305-4fea3ae63d43?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Cairo',
        img: 'https://images.unsplash.com/photo-1572252009286-268acec5ca0a?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Casablanca',
        img: 'https://images.unsplash.com/photo-1558447268-bc5a8e0c8769?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Fez',
        img: 'https://images.unsplash.com/photo-1516483638261-f4dbaf036963?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Luxor',
        img: 'https://images.unsplash.com/photo-1553913861-c0fddf2619ee?w=400',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getSouthAfrica() {
    return [
      StopRecomendation(
        name: 'Cape Town',
        img: 'https://images.unsplash.com/photo-1580060839134-75a5edca2e99?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Johannesburg',
        img: 'https://images.unsplash.com/photo-1577948000111-9c970dfe3743?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Durban',
        img: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Kruger Park',
        img: 'https://images.unsplash.com/photo-1516426122078-c23e76319801?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Garden Route',
        img: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        duration: 4,
      ),
    ];
  }

  List<StopRecomendation> getSoutheastAsia() {
    return [
      StopRecomendation(
        name: 'Bangkok',
        img: 'https://images.unsplash.com/photo-1528181304800-259b08848526?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Bali',
        img: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=400',
        duration: 5,
      ),
      StopRecomendation(
        name: 'Singapore',
        img: 'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Phuket',
        img: 'https://images.unsplash.com/photo-1589394815804-964ed0be2eb5?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Hanoi',
        img: 'https://images.unsplash.com/photo-1528127269322-539801943592?w=400',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getEastAsia() {
    return [
      StopRecomendation(
        name: 'Tokyo',
        img: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Kyoto',
        img: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Seoul',
        img: 'https://images.unsplash.com/photo-1517154421773-0529f29ea451?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Osaka',
        img: 'https://images.unsplash.com/photo-1590559899731-a382839e5549?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'Busan',
        img: 'https://images.unsplash.com/photo-1583474354980-8e9b53e0c5fc?w=400',
        duration: 3,
      ),
    ];
  }

  List<StopRecomendation> getOceania() {
    return [
      StopRecomendation(
        name: 'Sydney',
        img: 'https://images.unsplash.com/photo-1523482580672-f109ba8cb9be?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Melbourne',
        img: 'https://images.unsplash.com/photo-1514395462725-fb4566210144?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Auckland',
        img: 'https://images.unsplash.com/photo-1507699622108-4be3abd695ad?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Gold Coast',
        img: 'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Queenstown',
        img: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        duration: 4,
      ),
    ];
  }

  List<StopRecomendation> getAndes() {
    return [
      StopRecomendation(
        name: 'Machu Picchu',
        img: 'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Cusco',
        img: 'https://images.unsplash.com/photo-1526392060635-9d6019884377?w=400',
        duration: 2,
      ),
      StopRecomendation(
        name: 'La Paz',
        img: 'https://images.unsplash.com/photo-1531065208531-4036c0dba3ca?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Santiago',
        img: 'https://images.unsplash.com/photo-1555881400-74d7acaacd8b?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Uyuni Salt Flats',
        img: 'https://images.unsplash.com/photo-1533587851505-d119e13fa0d7?w=400',
        duration: 2,
      ),
    ];
  }

  List<StopRecomendation> getMexicoCaribbean() {
    return [
      StopRecomendation(
        name: 'Cancún',
        img: 'https://images.unsplash.com/photo-1544986581-efac024faf62?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Tulum',
        img: 'https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Playa del Carmen',
        img: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
        duration: 3,
      ),
      StopRecomendation(
        name: 'Punta Cana',
        img: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        duration: 4,
      ),
      StopRecomendation(
        name: 'Havana',
        img: 'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=400',
        duration: 3,
      ),
    ];
  }
}