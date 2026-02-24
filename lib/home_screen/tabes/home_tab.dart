import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home screen',
        style: TextStyle(
          fontSize: 24, 
          fontWeight: FontWeight.bold,
          color: Theme.of(context).splashColor,
        ),
      ),
    );
  }
}
