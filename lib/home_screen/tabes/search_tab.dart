import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search screen',
        style: TextStyle(
          fontSize: 24, 
          fontWeight: FontWeight.bold,
          color: Theme.of(context).splashColor,
        ),
      ),
    );
  }
}
