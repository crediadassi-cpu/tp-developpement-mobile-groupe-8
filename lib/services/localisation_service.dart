import 'package:geolocator/geolocator.dart';
import '../models/ville.dart';

class LocalisationService {
  Future<Position?> getPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Ville? trouverVilleProche(
    Position position,
    List<Ville> villes,
    Map<String, List<double>> coords,
  ) {
    Ville? plusProche;
    double minDistance = double.infinity;

    for (final ville in villes) {
      final c = coords[ville.nom];
      if (c == null) continue;

      final distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        c[0],
        c[1],
      );

      if (distance < minDistance) {
        minDistance = distance;
        plusProche = ville;
      }
    }

    return plusProche;
  }
}