import 'package:flutter/material.dart';
import 'package:test_sahil/screens/map_screen.dart';
import 'package:geolocator/geolocator.dart';

class LocationInputScreen extends StatefulWidget {
  const LocationInputScreen({super.key});

  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final _locationController = TextEditingController();
  String? _errorText;
  bool isCoordinates = false;
  bool checkIfInputIsCoordinate() {
    final regex = RegExp(r'^[+-]?\d+(\.\d+)?,[+-]?\d+(\.\d+)?$');
    return regex.hasMatch(_locationController.text.toString());
  }

  void _onNextPressed() {
    if (_locationController.text.isEmpty) {
      setState(() {
        _errorText = 'Please enter a location';
      });
    } else {
      if (checkIfInputIsCoordinate()) isCoordinates = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
            location: _locationController.text,
            isCoordinates: isCoordinates,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Location')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
                "If you want to locate by co-ordinates then please give input by latitude and longitude separated by comma and without space \n(for ex. 4.268482,6.162849)"),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                errorText: _errorText,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onNextPressed,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
