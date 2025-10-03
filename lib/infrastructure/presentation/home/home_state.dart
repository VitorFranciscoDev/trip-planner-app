import 'package:flutter/widgets.dart';
import 'package:trip_planner/entities/recomended_stop.dart';

class RecomendedStopsProvider with ChangeNotifier {

  //List of Recomended Stops that appear for the User if he's in South America
  List<RecomendedStop> saRecomendedStops = [
    RecomendedStop(
      name: "Machu Picchu - Peru",
      img: "https://upload.wikimedia.org/wikipedia/commons/e/e8/Machu_Picchu%2C_Peru.jpg",
      latlng: [-13.1631, -72.5450],
    ),
    RecomendedStop(
      name: "Cidade Perdida (Teyuna) - Colômbia",
      img: "https://upload.wikimedia.org/wikipedia/commons/a/a1/Ciudad_Perdida_Colombia.jpg",
      latlng: [11.0423, -73.9222],
    ),
    RecomendedStop(
      name: "Chan Chan - Peru",
      img: "https://upload.wikimedia.org/wikipedia/commons/6/67/Chan_Chan_Peru.jpg",
      latlng: [-8.1100, -79.0658],
    ),
    RecomendedStop(
      name: "Tiwanaku - Bolívia",
      img: "https://upload.wikimedia.org/wikipedia/commons/c/c6/Tiwanaku_-_Puerta_del_Sol.jpg",
      latlng: [-16.5542, -68.6733],
    ),
    RecomendedStop(
      name: "Ruínas de São Miguel das Missões - Brasil",
      img: "https://upload.wikimedia.org/wikipedia/commons/5/5b/Ruinas_Sao_Miguel_Missoes.jpg",
      latlng: [-28.5556, -54.5556],
    ),
    RecomendedStop(
      name: "Centro Histórico de Ouro Preto - Brasil",
      img: "https://upload.wikimedia.org/wikipedia/commons/3/37/Ouro_Preto_Minas_Gerais_Brasil.jpg",
      latlng: [-20.3850, -43.5033],
    ),
    RecomendedStop(
      name: "Pelourinho - Salvador, Brasil",
      img: "https://upload.wikimedia.org/wikipedia/commons/6/6d/Pelourinho_Salvador_Bahia.jpg",
      latlng: [-12.9714, -38.5108],
    ),
    RecomendedStop(
      name: "Cueva de las Manos - Argentina",
      img: "https://upload.wikimedia.org/wikipedia/commons/3/37/Cueva_de_las_Manos-P2210651b.jpg",
      latlng: [-47.1522, -70.6669],
    ),
    RecomendedStop(
      name: "Moais da Ilha de Páscoa - Chile",
      img: "https://upload.wikimedia.org/wikipedia/commons/9/96/Ahu_Tongariki%2C_Easter_Island.jpg",
      latlng: [-27.1127, -109.3497],
    ),
    RecomendedStop(
      name: "Quito Histórico - Equador",
      img: "https://upload.wikimedia.org/wikipedia/commons/4/47/Quito_Cathedral.jpg",
      latlng: [-0.2202, -78.5127],
    ),
  ];

  //List of Recomended Stops that appear for the User if he's in North America
  List<RecomendedStop> naRecomendedStops = [
    RecomendedStop(
      name: "Chichén Itzá - México",
      img: "https://upload.wikimedia.org/wikipedia/commons/9/9a/Chichen_Itza_3.jpg",
      latlng: [20.6843, -88.5678],
    ),
    RecomendedStop(
      name: "Teotihuacán - México",
      img: "https://upload.wikimedia.org/wikipedia/commons/f/fb/Teotihuacan_Moon_Pyramid.JPG",
      latlng: [19.6925, -98.8434],
    ),
    RecomendedStop(
      name: "Monte Albán - México",
      img: "https://upload.wikimedia.org/wikipedia/commons/7/71/Monte_Alban_Plaza.jpg",
      latlng: [17.0436, -96.7670],
    ),
    RecomendedStop(
      name: "Mesa Verde - EUA",
      img: "https://upload.wikimedia.org/wikipedia/commons/3/31/Mesa_Verde_National_Park_Cliff_Palace_2013.jpg",
      latlng: [37.2309, -108.4618],
    ),
    RecomendedStop(
      name: "Pueblo Bonito (Chaco Canyon) - EUA",
      img: "https://upload.wikimedia.org/wikipedia/commons/4/40/PuebloBonito.jpg",
      latlng: [36.0617, -107.9617],
    ),
    RecomendedStop(
      name: "Cahokia Mounds - EUA",
      img: "https://upload.wikimedia.org/wikipedia/commons/f/fc/Cahokia_Mounds.jpg",
      latlng: [38.6592, -90.0620],
    ),
    RecomendedStop(
      name: "Tulum - México",
      img: "https://upload.wikimedia.org/wikipedia/commons/8/80/Tulum_ruins_2009.jpg",
      latlng: [20.2141, -87.4291],
    ),
    RecomendedStop(
      name: "Uxmal - México",
      img: "https://upload.wikimedia.org/wikipedia/commons/3/35/Uxmal_Pyramid_of_the_Magician_2009.jpg",
      latlng: [20.3607, -89.7713],
    ),
    RecomendedStop(
      name: "Gila Cliff Dwellings - EUA",
      img: "https://upload.wikimedia.org/wikipedia/commons/8/88/Gila_Cliff_Dwellings_NM.jpg",
      latlng: [33.2333, -108.2670],
    ),
    RecomendedStop(
      name: "Templo Mayor - Cidade do México",
      img: "https://upload.wikimedia.org/wikipedia/commons/1/1e/Templo_Mayor_Ciudad_de_M%C3%A9xico.jpg",
      latlng: [19.4351, -99.1329],
    ),
  ];

  //List of Recomended Stops that appear for the User if he's in Europe
  List<RecomendedStop> euRecomendedStops = [
    RecomendedStop(
      name: "Coliseu - Roma, Itália",
      img: "https://upload.wikimedia.org/wikipedia/commons/d/de/Colosseo_2020.jpg",
      latlng: [41.8902, 12.4922],
    ),
    RecomendedStop(
      name: "Stonehenge - Inglaterra",
      img: "https://upload.wikimedia.org/wikipedia/commons/3/3c/Stonehenge2007_07_30.jpg",
      latlng: [51.1789, -1.8262],
    ),
    RecomendedStop(
      name: "Acrópole de Atenas - Grécia",
      img: "https://upload.wikimedia.org/wikipedia/commons/d/d7/Parthenon_from_west.jpg",
      latlng: [37.9715, 23.7267],
    ),
    RecomendedStop(
      name: "Alhambra - Espanha",
      img: "https://upload.wikimedia.org/wikipedia/commons/9/9e/Alhambra_Granada_2009.jpg",
      latlng: [37.1761, -3.5881],
    ),
    RecomendedStop(
      name: "Castelo de Edimburgo - Escócia",
      img: "https://upload.wikimedia.org/wikipedia/commons/1/1e/Edinburgh_Castle_from_the_south-east.JPG",
      latlng: [55.9486, -3.1999],
    ),
    RecomendedStop(
      name: "Pompéia - Itália",
      img: "https://upload.wikimedia.org/wikipedia/commons/6/6e/Via_dell%27Abbondanza_Pompeii.jpg",
      latlng: [40.7497, 14.4870],
    ),
    RecomendedStop(
      name: "Catedral de Notre-Dame - França",
      img: "https://upload.wikimedia.org/wikipedia/commons/6/6e/Notre_Dame_de_Paris.JPG",
      latlng: [48.8529, 2.3500],
    ),
    RecomendedStop(
      name: "Basílica de São Pedro - Vaticano",
      img: "https://upload.wikimedia.org/wikipedia/commons/4/4d/Petersdom_von_Engelsburg_gesehen.jpg",
      latlng: [41.9022, 12.4539],
    ),
    RecomendedStop(
      name: "Castelo de Neuschwanstein - Alemanha",
      img: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Neuschwanstein_Castle_%28July_2013%29.jpg",
      latlng: [47.5576, 10.7498],
    ),
    RecomendedStop(
      name: "Mosteiro de Meteora - Grécia",
      img: "https://upload.wikimedia.org/wikipedia/commons/d/d8/Meteora_monasteries_2016.jpg",
      latlng: [39.7211, 21.6300],
    ),
  ];

}