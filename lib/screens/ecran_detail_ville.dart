import 'package:flutter/material.dart';
import '../models/ville.dart';
import '../models/meteo_data.dart';

class EcranDetailVille extends StatelessWidget {
  final Ville ville;
  final MeteoData? meteo;

  const EcranDetailVille({super.key, required this.ville, this.meteo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ville.nom),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'icone-${ville.nom}',
              child: const Icon(
                Icons.wb_sunny,
                size: 180,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              ville.nom,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            Text(
              ville.pays,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            if (meteo != null) ...[
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  '${meteo!.temperature.toStringAsFixed(1)} °C',
                  key: ValueKey(meteo!.temperature),
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                '${meteo!.conditionTexte} • ${meteo!.humidite}%',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}