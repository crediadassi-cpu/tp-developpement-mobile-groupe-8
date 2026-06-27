import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/ville_viewmodel.dart';
import 'ecran_liste_villes.dart';
import 'ecran_detail_ville.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EcranAccueil extends StatefulWidget {
  const EcranAccueil({super.key});

  @override
  State<EcranAccueil> createState() => _EcranAccueilState();
}

class _EcranAccueilState extends State<EcranAccueil> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  IconData _iconeMeteo(String condition) {
    switch (condition) {
      case 'Ensoleille':
        return Icons.wb_sunny;
      case 'Nuageux':
        return Icons.cloud;
      case 'Pluvieux':
        return Icons.umbrella;
      case 'Orageux':
        return Icons.thunderstorm;
      case 'Venteux':
        return Icons.air;
      default:
        return Icons.wb_cloudy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EcranListeVilles()),
              );
            },
          ),
        ],
        title: const Text('AppMeteo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
        child: Center(
          child: Consumer<VilleViewModel>(
            builder: (context, vm, _) {
              if (vm.chargement) {
                return const CircularProgressIndicator();
              }

              if (vm.erreur != null) {
                return const Text(
                  "Erreur de chargement",
                  style: TextStyle(color: Colors.red),
                );
              }

              final ville = vm.villeSelectionnee;
              final meteo = vm.meteoActuelle;

              if (ville == null || meteo == null) {
                return const Text("Aucune donnée météo");
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EcranDetailVille(ville: ville, meteo: meteo),
                    ),
                  );
                },

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // IMAGE
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (image != null) {
                          context.read<VilleViewModel>().mettreAJourPhoto(
                            image.path,
                          );
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ville.photoPath != null
                            ? Image.file(
                                File(ville.photoPath!),
                                width: double.infinity,
                                height: 180,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: double.infinity,
                                height: 180,
                                color: Colors.grey[200],
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo, size: 50),
                                    Text("Appuyez pour ajouter une photo"),
                                  ],
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // HERO
                    Hero(
                      tag: 'icone-${ville.nom}',
                      child: Icon(
                        _iconeMeteo(ville.condition),
                        size: 100,
                        color: Colors.orange,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // TEMPÉRATURE ANIMÉE
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Text(
                        '${meteo.temperature.toStringAsFixed(1)} °C',
                        key: ValueKey(ville.nom),
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '${meteo.conditionTexte} - ${meteo.humidite}%',
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Mesure : ${meteo.time}",
                      style: const TextStyle(fontSize: 14),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Ville : ${ville.nom}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}