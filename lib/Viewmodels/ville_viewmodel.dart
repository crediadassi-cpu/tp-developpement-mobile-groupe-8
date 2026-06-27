import 'package:flutter/foundation.dart';
import '../models/ville.dart';
import '../services/meteo_service.dart';
import '../models/meteo_data.dart';
import '../services/notification_service.dart';

class VilleViewModel extends ChangeNotifier {
  List<Ville> _villes = [];

  Ville? _villeSelectionnee;

  final MeteoService _meteoService = MeteoService();
  final NotificationService _notificationService = NotificationService();

  final Map<String, (MeteoData, DateTime)> _cache = {};

  MeteoData? _meteoActuelle;
  bool _chargement = false;
  String? _erreur;

  List<Ville> get villes => _villes;
  Ville? get villeSelectionnee => _villeSelectionnee;

  MeteoData? get meteoActuelle => _meteoActuelle;
  bool get chargement => _chargement;
  String? get erreur => _erreur;

  VilleViewModel() {
    _initialiser();
  }

  void _initialiser() {
    _notificationService.init(); // ⭐ INITIALISATION NOTIFICATIONS

    _villes = [
      Ville(
        nom: 'Cotonou',
        pays: 'Benin',
        temperature: 29,
        condition: 'Ensoleille',
        humidite: 75,
      ),
      Ville(
        nom: 'Parakou',
        
        pays: 'Benin',
        temperature: 32,
        condition: 'Ensoleille',
        humidite: 60,
      ),
      Ville(
        nom: 'Lagos',
        pays: 'Nigeria',
        temperature: 31,
        condition: 'Nuageux',
        humidite: 80,
      ),
      Ville(
        nom: 'Abidjan',
        pays: 'CI',
        temperature: 27,
        condition: 'Pluvieux',
        humidite: 85,
      ),
      Ville(
        nom: 'Porto-Novo',
        pays: 'Benin',
        temperature: 28,
        condition: 'Orageux',
        humidite: 90,
      ),
      Ville(
        nom: 'Natitingou',
        pays: 'Benin',
        temperature: 30,
        condition: 'Venteux',
        humidite: 55,
      ),
    ];

    _villeSelectionnee = _villes.first;

    notifyListeners();
  }

  // ⭐ VERSION ASYNC (OBLIGATOIRE POUR NOTIFICATIONS)
  Future<void> selectionnerVille(Ville ville) async {
    _villeSelectionnee = ville;

    final cacheData = _cache[ville.nom];

    // ⏱️ CACHE
    if (cacheData != null) {
      final meteoCache = cacheData.$1;
      final dateCache = cacheData.$2;

      if (DateTime.now().difference(dateCache).inMinutes < 30) {
        _meteoActuelle = meteoCache;
        notifyListeners();
        return;
      }
    }

    _chargement = true;
    _erreur = null;
    notifyListeners();

    final meteo = await _meteoService.getMeteo(ville.nom);

    if (meteo != null) {
      _meteoActuelle = meteo;

      // 💾 cache
      _cache[ville.nom] = (meteo, DateTime.now());

      // ⭐ NOTIFICATION ICI (IMPORTANT)
      await _notificationService.showHighTempNotification(
        meteo.temperature,
        ville.nom,
      );
    } else {
      _erreur = "Impossible de charger la météo";
    }

    _chargement = false;
    notifyListeners();
  }

  void ajouterVille(Ville ville) {
    _villes.add(ville);
    notifyListeners();
  }

  void mettreAJourPhoto(String cheminPhoto) {
    if (_villeSelectionnee == null) return;

    final index = _villes.indexWhere((v) => v.nom == _villeSelectionnee!.nom);

    if (index == -1) return;

    _villes[index] = _villes[index].copierAvecPhoto(cheminPhoto);
    _villeSelectionnee = _villes[index];

    notifyListeners();
  }

  // ⭐ COORDONNÉES GPS
  static const Map<String, List<double>> coords = {
    'Cotonou': [6.3703, 2.3912],
    'Parakou': [9.3370, 2.6283],
    'Lagos': [6.4541, 3.3947],
    'Abidjan': [5.3600, -4.0083],
    'Porto-Novo': [6.4969, 2.6289],
    'Natitingou': [10.3042, 1.3798],
  };
}