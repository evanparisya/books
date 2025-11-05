import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String myPosition = '';

  Future<Position>? position;

  @override
  void initState() {
    super.initState();
    position = getPosition(); 
  }

    @override
    @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Current Location - Evan')), 
        body: Center(
          child: FutureBuilder<Position>(
            future: position,
            builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
              
              // Saat Future masih 'waiting' (proses 3 detik delay)
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } 
              
              else if (snapshot.connectionState == ConnectionState.done) {
                // Cek jika ada error
                if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error.toString()}');
                }
                // Jika sukses, tampilkan data
                return Text(snapshot.data.toString());
              } 
              
              else {
                return const Text('');
              }
            },
          ),
        ));
  }

  Future<Position> getPosition() async {
    await Geolocator.isLocationServiceEnabled();
    await Future.delayed(const Duration(seconds: 3));
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}