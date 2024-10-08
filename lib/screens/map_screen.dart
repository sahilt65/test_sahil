import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_sahil/widgets/map_type_widget.dart';

class MapScreen extends StatefulWidget {
  final String location;
  final bool isCoordinates;
  const MapScreen({super.key, required this.location, required this.isCoordinates});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isLoading = true;
  bool isResult = true;
  late Coordinates mainCo;
  final List<MapType> _mapTypes = const [MapType.normal, MapType.satellite, MapType.terrain];
  @override
  void initState() {
    super.initState();
    if (!widget.isCoordinates) _getCoordinates();
    if (widget.isCoordinates) _getInputCordinates();
  }

  MapType map = MapType.normal;
  void changeMapType(MapType newMapType) {
    setState(() {
      map = newMapType;
    });
  }

  Future<void> _getCoordinates() async {
    GeoCode geoCode = GeoCode();

    try {
      Coordinates coordinates = await geoCode.forwardGeocoding(address: widget.location);

      setState(() {
        mainCo = coordinates;
        _isLoading = false;
        markers.add(Marker(
          markerId: const MarkerId('locationMarker'),
          position: LatLng(mainCo.latitude!.toDouble(), mainCo.longitude!.toDouble()),
        ));
      });
    } catch (e) {
      isResult = false;
      print(e);
    }
  }

  void _getInputCordinates() {
    try {
      List<String> latLong = widget.location.split(',');
      if (latLong.length != 2) {
        throw const FormatException("Input should have exactly one comma separating latitude and longitude.");
      }
      double latitude = double.parse(latLong[0].trim());
      double longitude = double.parse(latLong[1].trim());
      setState(() {
        Coordinates c = Coordinates();
        c.latitude = latitude;
        c.longitude = longitude;
        mainCo = c;
        _isLoading = false;
        markers.add(Marker(
          markerId: const MarkerId('locationMarker'),
          position: LatLng(mainCo.latitude!.toDouble(), mainCo.longitude!.toDouble()),
        ));
      });
    } catch (e) {
      isResult = false;
      throw FormatException("Invalid input for latitude and longitude: $e");
    }
  }

  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !isResult
              ? const Center(
                  child: Text("Enter Correct Address or Coordinates"),
                )
              : Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: GoogleMap(
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        trafficEnabled: true,
                        mapType: map,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(mainCo.latitude!.toDouble(), mainCo.longitude!.toDouble()), zoom: 13),
                        markers: markers,
                      ),
                    ),
                    Positioned(
                      top: 90.0,
                      right: 16.0,
                      child: Container(
                        // width: 110,
                        // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), color: Colors.white.withOpacity(0.6)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: 70,
                              child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      map = _mapTypes[0];
                                    });
                                  },
                                  backgroundColor: map == MapType.normal
                                      ? const Color.fromRGBO(234, 222, 255, 0.9)
                                      : Colors.white.withOpacity(0.6),
                                  child: MapTypeWidget(mapType: "Normal", icon: Icons.nordic_walking_outlined)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 70,
                              child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      map = _mapTypes[1];
                                    });
                                  },
                                  backgroundColor: map == MapType.satellite
                                      ? const Color.fromRGBO(234, 222, 255, 0.9)
                                      : Colors.white.withOpacity(0.6),
                                  child: MapTypeWidget(mapType: "Satellite", icon: Icons.satellite_alt_outlined)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 70,
                              child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      map = _mapTypes[2];
                                    });
                                  },
                                  backgroundColor: map == MapType.terrain
                                      ? const Color.fromRGBO(234, 222, 255, 0.9)
                                      : Colors.white.withOpacity(0.6),
                                  child: MapTypeWidget(mapType: "Terrain", icon: Icons.map)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
          markers.add(Marker(
              markerId: const MarkerId('currentLocation'), position: LatLng(position.latitude, position.longitude)));
          setState(() {});
        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
