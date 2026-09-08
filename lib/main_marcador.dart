import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Mapa',
      home: const MapaPage(),
    );
  }
}

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  Position? posicao;

  final MapController _mapController = MapController();

  Future<void> buscarLocalizacao() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

    if (!servicoAtivo) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied ||
          permissao == LocationPermission.deniedForever) {
        return;
      }
    }

    Position novaPosicao = await Geolocator.getCurrentPosition();

    setState(() {
      posicao = novaPosicao;
      _mapController.move(
        LatLng(novaPosicao.latitude, novaPosicao.longitude),
        16.0,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    buscarLocalizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Mapa')),
      body: FlutterMap(
        mapController: _mapController,

        options: const MapOptions(
          initialCenter: LatLng(
            -21.470000,
            -47.030000,
          ), // Coordenadas iniciais do mapa
          initialZoom: 13.0,
        ),

        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapa_flutter',
          ),

          if (posicao != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(posicao!.latitude, posicao!.longitude),
                  width: 50.0,
                  height: 50.0,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
              ],
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: buscarLocalizacao,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
