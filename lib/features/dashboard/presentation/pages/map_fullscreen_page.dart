import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';

class MapFullscreenPage extends StatelessWidget {
  final String disease;
  const MapFullscreenPage({super.key, this.disease = 'Bronquitis'});

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
          CircleLayer(circles: _getHeatmapCircles(disease)),
        ],
      ),
    );
  }

  List<CircleMarker> _getHeatmapCircles(String disease) {
    // Simulación de zonas grandes y esparcidas para cada enfermedad
    switch (disease) {
      case 'Bronquitis':
        return [
          CircleMarker(
            point: LatLng(-17.75, -63.18),
            color: Colors.yellow.withOpacity(0.7),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 200,
          ),
          CircleMarker(
            point: LatLng(-17.80, -63.22),
            color: Colors.orange.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 350,
          ),
          CircleMarker(
            point: LatLng(-17.85, -63.16),
            color: Colors.red.withOpacity(0.4),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 500,
          ),
        ];
      case 'Zika':
        return [
          CircleMarker(
            point: LatLng(-17.78, -63.19),
            color: Colors.yellow.withOpacity(0.7),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 250,
          ),
          CircleMarker(
            point: LatLng(-17.82, -63.21),
            color: Colors.orange.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 400,
          ),
          CircleMarker(
            point: LatLng(-17.77, -63.14),
            color: Colors.red.withOpacity(0.4),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 600,
          ),
        ];
      case 'Sarampion':
        return [
          // Centro
          CircleMarker(
            point: LatLng(-17.783327, -63.182140),
            color: Colors.yellow.withOpacity(0.8),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 350,
          ),
          CircleMarker(
            point: LatLng(-17.7807346, -63.1890985),
            color: Colors.orange.withOpacity(0.7),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 400,
          ),
          CircleMarker(
            point: LatLng(-17.779344, -63.1887634),
            color: Colors.red.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 500,
          ),
          // Plan 3000 - zona crítica
          CircleMarker(
            point: LatLng(-17.8518622, -63.2225207),
            color: Colors.yellow.withOpacity(0.9),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 250,
          ),
          CircleMarker(
            point: LatLng(-17.8518622, -63.2225207),
            color: Colors.orange.withOpacity(0.8),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 400,
          ),
          CircleMarker(
            point: LatLng(-17.8518622, -63.2225207),
            color: Colors.red.withOpacity(0.7),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 700,
          ),
          CircleMarker(
            point: LatLng(-17.85, -63.23),
            color: Colors.red.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 500,
          ),
          // Villa 1ro de Mayo
          CircleMarker(
            point: LatLng(-17.7783784, -63.1897871),
            color: Colors.red.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 400,
          ),
          // Norte
          CircleMarker(
            point: LatLng(-17.75, -63.15),
            color: Colors.yellow.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 350,
          ),
          CircleMarker(
            point: LatLng(-17.80, -63.22),
            color: Colors.orange.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 300,
          ),
          // Sur
          CircleMarker(
            point: LatLng(-17.90, -63.20),
            color: Colors.red.withOpacity(0.4),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 700,
          ),
          // Oeste
          CircleMarker(
            point: LatLng(-17.83, -63.25),
            color: Colors.orange.withOpacity(0.4),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 400,
          ),
          // Este
          CircleMarker(
            point: LatLng(-17.77, -63.13),
            color: Colors.red.withOpacity(0.3),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 600,
          ),
        ];
      case 'Influencia':
        return [
          CircleMarker(
            point: LatLng(-17.81, -63.18),
            color: Colors.yellow.withOpacity(0.7),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 350,
          ),
          CircleMarker(
            point: LatLng(-17.84, -63.23),
            color: Colors.orange.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 500,
          ),
          CircleMarker(
            point: LatLng(-17.78, -63.15),
            color: Colors.red.withOpacity(0.4),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 800,
          ),
        ];
      case 'Gripe Ah1N1':
        return [
          CircleMarker(
            point: LatLng(-17.77, -63.20),
            color: Colors.yellow.withOpacity(0.7),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 400,
          ),
          CircleMarker(
            point: LatLng(-17.86, -63.18),
            color: Colors.orange.withOpacity(0.5),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 600,
          ),
          CircleMarker(
            point: LatLng(-17.80, -63.12),
            color: Colors.red.withOpacity(0.4),
            borderStrokeWidth: 0,
            useRadiusInMeter: true,
            radius: 900,
          ),
        ];
      default:
        return [];
    }
  }
}
