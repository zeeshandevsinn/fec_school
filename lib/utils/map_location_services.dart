/* ******************************************
  AIzaSyDKh1ef1o9DUMQH1-LQsFj0W-y1mcozrdk            // IOS API key for firebase google maps
  AIzaSyBZTUo5tAP4GI_eQ1Ao-jxZ6Junm3A6R_0            // Android API key for firebase google maps
  AIzaSyB9SGRa6R9GlymyypI8k-PyQcpPXRbe4zU            // WEB based API key for firebase google maps

   map location for address: 208-209 A, Khayaban-e-Iqbal, Phase VIII DHA, Karachi
   24.77763940116839, 67.0666705928456
*/

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocationServices extends StatefulWidget {
  const MapLocationServices({super.key});

  @override
  State<MapLocationServices> createState() => _MapLocationServicesState();
}

class _MapLocationServicesState extends State<MapLocationServices> {
  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: const Color.fromARGB(255, 25, 74, 159),
          title: const Text(
            "Fec School Location",
            style: TextStyle(color: Colors.white),
          )),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: const CameraPosition(
                target: LatLng(24.77763940116839, 67.0666705928456), zoom: 16),
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            markers: <Marker>{
              const Marker(
                draggable: true,
                markerId: MarkerId("1"),
                position: LatLng(24.77763940116839, 67.0666705928456),
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(
                    title: 'Froebel Education Centre', anchor: Offset(2, 2)),
              )
            },
          ),
        ],
      ),
    );
  }
}
