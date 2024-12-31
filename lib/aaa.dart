import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ZoomLevelMap extends StatefulWidget {
  const ZoomLevelMap({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ZoomLevelMapState createState() => _ZoomLevelMapState();
}

class _ZoomLevelMapState extends State<ZoomLevelMap> {
  final MapController _mapController = MapController();
  double _currentZoom = 13.0; // 初期ズームレベル

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zoom Level Map')),
      body: Column(
        children: <Widget>[
          // FlutterMapウィジェット
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(35.6895, 139.6917), // 東京の座標
                initialZoom: _currentZoom,
                onPositionChanged: (MapCamera position, bool isMoving) {
                  if (isMoving) {
                    setState(() => _currentZoom = position.zoom);
                  }
                },
              ),
              children: <Widget>[TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png')],
            ),
          ),
          // 現在のズームレベルを表示
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Current Zoom: ${_currentZoom.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
