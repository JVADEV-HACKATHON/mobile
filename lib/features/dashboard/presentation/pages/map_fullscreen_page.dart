import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

class MapFullscreenPage extends StatelessWidget {
  const MapFullscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Santa Cruz de la Sierra',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(-17.783327, -63.182140), // Cambio aquí
          initialZoom: 13.0, // Cambio aquí
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.jvadev',
          ),
          CircleLayer(
            circles: [
              // Hospital Japonés
              CircleMarker(
                point: LatLng(-17.7725285, -63.153871),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.7725285, -63.153871),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.7725285, -63.153871),
                color: Colors.red.withOpacity(0.4),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Hospital de Niños Dr. Mario Ortiz Suárez
              CircleMarker(
                point: LatLng(-17.7807346, -63.1890985),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.7807346, -63.1890985),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.7807346, -63.1890985),
                color: Colors.red.withOpacity(0.4),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Hospital San Juan de Dios
              CircleMarker(
                point: LatLng(-17.779344, -63.1887634),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.779344, -63.1887634),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.779344, -63.1887634),
                color: Colors.red.withOpacity(0.4),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Hospital Percy Boland
              CircleMarker(
                point: LatLng(-17.7783784, -63.1897871),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.7783784, -63.1897871),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.7783784, -63.1897871),
                color: Colors.red.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Hospital Municipal Francés
              CircleMarker(
                point: LatLng(-17.8518622, -63.2225207),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.8518622, -63.2225207),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.8518622, -63.2225207),
                color: Colors.red.withOpacity(0.4),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Hospital del Norte
              CircleMarker(
                point: LatLng(-17.3487718, -66.1773225),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.3487718, -66.1773225),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.3487718, -66.1773225),
                color: Colors.red.withOpacity(0.4),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Clínica Foianini
              CircleMarker(
                point: LatLng(-17.7916862, -63.1824279),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.7916862, -63.1824279),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.7916862, -63.1824279),
                color: Colors.red.withOpacity(0.4),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Hospital La Católica
              CircleMarker(
                point: LatLng(-17.7374565, -63.1923283),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.7374565, -63.1923283),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.7374565, -63.1923283),
                color: Colors.red.withOpacity(0.4),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Hospital de la Mujer Dr. Percy Boland
              CircleMarker(
                point: LatLng(-17.7783784, -63.1897871),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.7783784, -63.1897871),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.7783784, -63.1897871),
                color: Colors.red.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
              // Hospital General San Juan de Dios
              CircleMarker(
                point: LatLng(-17.9757477, -67.1164299),
                color: Colors.yellow.withOpacity(0.7),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 80,
              ),
              CircleMarker(
                point: LatLng(-17.9757477, -67.1164299),
                color: Colors.orange.withOpacity(0.5),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 180,
              ),
              CircleMarker(
                point: LatLng(-17.9757477, -67.1164299),
                color: Colors.red.withOpacity(0.4),
                borderStrokeWidth: 0,
                useRadiusInMeter: true,
                radius: 300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
