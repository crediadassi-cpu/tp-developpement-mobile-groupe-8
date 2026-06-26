import 'package:flutter/foundation.dart';

import '../Models/ville.dart';
import '../services/meteo_service.dart';
import '../Models/meteo_data.dart';


class VilleViewModel extends ChangeNotifier {


// La liste des villes disponibles
List<Ville> _villes = [];
// La ville actuellement selectionnee

Ville? _villeSelectionnee;

// --- Ajouts pour la meteo via API ---
final MeteoService _meteoService = MeteoService();
MeteoData? _meteoActuelle;
bool _chargement = false;
String? _erreur;


// Getters (la View lit ces proprietes)

List<Ville> get villes => _villes;

Ville? get villeSelectionnee => _villeSelectionnee;

MeteoData? get meteoActuelle => _meteoActuelle;
bool get chargement => _chargement;
String? get erreur => _erreur;


// Constructeur : charger des donnees au demarrage

VilleViewModel() {

_initialiser();}

void _initialiser() {

_villes = [

Ville(nom:'Cotonou', pays:'Benin', temperature:29,
condition:'Ensoleille', humidite:75),

Ville(nom:'Parakou', pays:'Benin', temperature:32,
condition:'Ensoleille', humidite:60),

Ville(nom:'Lagos', pays:'Nigeria', temperature:31,
condition:'Nuageux', humidite:80),

Ville(nom:'bidjan', pays:'CI', temperature:27,
condition:'Pluvieux', humidite:85),

//EXERCICE 8
Ville(nom: 'Niamey', pays: 'Niger', temperature: 38, condition: 'Orageux', humidite: 40),
Ville(nom: 'Lome', pays: 'Togo', temperature: 30, condition: 'Ventueux', humidite: 70),
];

_villeSelectionnee = _villes.first;

notifyListeners(); // prevenir les widgets

}


// Changer la ville affichee + charger la vraie meteo depuis l'API

Future<void> selectionnerVille(Ville ville) async {

_villeSelectionnee = ville;
_chargement = true;
_erreur = null;
notifyListeners();

final meteo = await _meteoService.getMeteo(ville.nom);

if (meteo != null) {

  _meteoActuelle = meteo;

} else {
  _erreur = 'Impossible de charger la meteo';
}

_chargement = false;
notifyListeners();

}

// Ajouter une nouvelle ville (Exercice C)
  void ajouterVille(Ville ville) {
    _villes.add(ville);
    notifyListeners();
  }

}