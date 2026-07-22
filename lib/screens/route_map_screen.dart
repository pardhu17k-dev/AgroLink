import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../theme/app_theme.dart';

class RouteMapScreen extends StatefulWidget {
  const RouteMapScreen({super.key});

  @override
  State<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends State<RouteMapScreen> {
  GoogleMapController? mapController;
  
  final LatLng _startLocation = const LatLng(37.7749, -122.4194); // MOCK user loc
  final LatLng _endLocation = const LatLng(37.7849, -122.4094); // MOCK farmer loc
  
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setMarkers();
    _setPolylines();
  }

  void _setMarkers() {
    _markers.add(
      Marker(
        markerId: const MarkerId('start'),
        position: _startLocation,
        infoWindow: const InfoWindow(title: 'You'),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('end'),
        position: _endLocation,
        infoWindow: const InfoWindow(title: 'Farmer'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  void _setPolylines() {
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.red,
        width: 4,
        points: [_startLocation, _endLocation], // In real app, fetch from Directions API
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Route")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _startLocation,
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) => mapController = controller,
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Estimated Arrival", style: TextStyle(color: AppTheme.textSecondary)),
                  const SizedBox(height: 8),
                  const Text("15 mins", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
