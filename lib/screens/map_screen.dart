import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/food_provider.dart';
import '../theme/app_theme.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  final LatLng _center = const LatLng(37.7749, -122.4194); // Mock user location
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _setMarkers() {
    // Adding dummy markers for nearby farmers
    _markers.add(
      Marker(
        markerId: const MarkerId('user'),
        position: _center,
        infoWindow: const InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('farmer1'),
        position: const LatLng(37.7849, -122.4094),
        infoWindow: const InfoWindow(title: 'Green Valley Farm', snippet: 'Tomatoes, Carrots'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('farmer2'),
        position: const LatLng(37.7649, -122.4294),
        infoWindow: const InfoWindow(title: 'Sunny Side Farms', snippet: 'Potatoes (Donation)'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = context.watch<FoodProvider>().items;

    return Scaffold(
      body: Stack(
        children: [
          // Real Google Map
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            markers: _markers,
            myLocationEnabled: false,  // causes UI hang on emulators — keep false
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search in this area...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 12),
                      width: 40, height: 4,
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text("Nearby Produce", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          width: 250,
                          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                                child: Image.network(
                                item.imageUrl,
                                width: 80,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (ctx, child, progress) => progress == null
                                    ? child
                                    : Container(
                                        width: 80,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(strokeWidth: 2),
                                          ),
                                        ),
                                      ),
                                errorBuilder: (ctx, err, st) => Container(
                                  width: 80,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image, color: Colors.grey),
                                ),
                              ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                                      Text(item.location, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
