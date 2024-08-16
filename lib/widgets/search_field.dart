import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelText: 'Search for a city',
        hintText: "Enter City Name",
        suffixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.black26,
      ),
    );
  }
}
