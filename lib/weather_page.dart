import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/widgets/search_field.dart';
import 'package:weather_app/widgets/weather_data_tile.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final service = WeatherService();

  final _searchController = TextEditingController();

  String _bgImage = "assets/images/clear.jpeg";
  String _iconImg = "assets/images/clear.png";
  String _cityName = "";
  double _temperature = 0;
  double _tempMax = 0, _tempMin = 0;
  double _humidity = 0;
  double _windSpeed = 0;
  double _pressure = 0;
  double _visibility = 0;
  double _windDirection = 0;
  double _sunrise = 0;
  double _sunset = 0;
  String _weatherIcon = "";
  String _weatherCondition = "";
  String _main = "";

  getData() async {
    final data = await service.fetchWeather();
    debugPrint(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/haze.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const SearchField(),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                      ),
                      Text(
                        "Karachi",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const Text(
                    "39.7 C",
                    style: TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      const Text("Haze",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w500)),
                      Image.asset(
                        "assets/icons/haze.png",
                        height: 80,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.arrow_upward),
                      Text(
                        "35",
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      Text(
                        "25",
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      Icon(Icons.arrow_downward)
                    ],
                  ),
                  const SizedBox(height: 25),
                  Card(
                      elevation: 5,
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(children: [
                          WeatherDataTile(
                            keys: ["Sun Rise", "Sunset"],
                            data: ["6:15AM", "6:00PM"],
                          ),
                          const SizedBox(height: 15),
                          WeatherDataTile(
                            keys: ["Humidity", "Visibility"],
                            data: ["4", "10000"],
                          ),
                          const SizedBox(height: 15),
                          WeatherDataTile(
                            keys: ["Percipitation", "Speed"],
                            data: ["6", "45"],
                          ),
                        ]),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
