import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: ElevatedButton(
            onPressed: () {
              print('Top button clicked!');
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50), // Make button full width
            ),
            child: const Text('Location: Blacksburg, VA'),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Read Terms and Conditions'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Click!');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // Make button full width
              ), 
              child: const Text('Location: Blacksburg, VA'),
            ),
          ],
        ),
      ),
    );
  }
}
