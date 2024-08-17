import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  int _humidity = 0;
  int _pressure = 0;
  double _windSpeed = 0;
  int _visibility = 0;
  String _sunrise = "";
  String _sunset = "";
  String _weatherIcon = "";
  String _weatherCondition = "";
  String _main = "";

  String getTime(int value) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    final String formattedDate = DateFormat('hh:mm a').format(date);
    return formattedDate;
  }

  getData() async {
    final data = await service.getWeather("karachi");
    final {
      'weather': weather,
      'main': main,
      'visibility': visibility,
      "wind": wind,
      "sys": sys
    } = data;
    debugPrint(data.toString());
    // debugPrint(main.toString());

    setState(() {
      _cityName = data["name"];
      _sunrise = getTime(sys["sunrise"] as int);
      _sunset = getTime(sys["sunset"] as int);
      _main = weather.map((w) => w["main"]).join(" ").toString();
      _weatherCondition =
          weather.map((w) => w["description"]).join(", ").toString();
      _temperature = main["temp"] as double;
      _tempMax = main["feels_like"] as double;
      _tempMin = main["temp_min"] as double;
      _humidity = main["humidity"];
      _pressure = main["pressure"];
      _visibility = visibility as int;
      _windSpeed = wind["speed"] as double;
    });
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                      ),
                      Text(
                        _cityName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "$_temperature°C",
                    style: const TextStyle(
                        fontSize: 90, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(_main,
                          style: const TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w500)),
                      Image.asset(
                        "assets/icons/haze.png",
                        height: 80,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _weatherCondition,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.arrow_upward),
                      Text(
                        "$_tempMax°C",
                        style: const TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "$_tempMin°C",
                        style: const TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      const Icon(Icons.arrow_downward)
                    ],
                  ),
                  const SizedBox(height: 25),
                  Card(
                      elevation: 5,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(children: [
                          WeatherDataTile(
                            keys: const ["Sun Rise", "Sunset"],
                            data: [_sunrise, _sunset],
                          ),
                          const SizedBox(height: 15),
                          WeatherDataTile(
                            keys: const ["Humidity", "Visibility"],
                            data: ["$_humidity", "$_visibility"],
                          ),
                          const SizedBox(height: 15),
                          WeatherDataTile(
                            keys: const ["Pressure", "Speed"],
                            data: ["$_pressure", "$_windSpeed"],
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
