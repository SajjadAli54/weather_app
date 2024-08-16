import 'package:flutter/material.dart';

class WeatherDataTile extends StatelessWidget {
  final List keys, data;
  const WeatherDataTile({super.key, required this.data, required this.keys});

  @override
  Widget build(BuildContext context) {
    const keysStyle = TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    const dataStyle = TextStyle(
      fontSize: 20,
      color: Colors.white70,
      fontWeight: FontWeight.w300,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(keys[0], style: keysStyle),
            Text(keys[1], style: keysStyle),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data[0], style: dataStyle),
            Text(data[1], style: dataStyle),
          ],
        ),
      ],
    );
  }
}
