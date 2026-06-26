import 'package:appmeteo/screens/ecran_liste_villes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/ville_viewmodel.dart';


class EcranAccueil extends StatelessWidget {

  const EcranAccueil({super.key});


  IconData _iconeMeteo(String condition) {

    switch (condition) {

      case 'Ensoleille':
        return Icons.wb_sunny;

      case 'Nuageux':
        return Icons.cloud;

      case 'Pluvieux':
        return Icons.umbrella;
        //Exercice 8
      case'Orageux':
       return Icons.thunderstorm;
       case 'Venteux':
      return Icons.air;
      //Fin d'exercice

      default:
        return Icons.wb_cloudy;
    }
    
  }
Color _couleurFond(String condition) {
  switch (condition) {
    case 'Ensoleille': return Colors.orange[100]!;
    case 'Nuageux': return Colors.grey[300]!;
    case 'Pluvieux': return Colors.blue[100]!;
    default: return Colors.white;
  }
}

  @override
  Widget build(BuildContext context) {


    final vm = context.watch<VilleViewModel>();

    final ville = vm.villeSelectionnee;


    return Scaffold(

      appBar: AppBar(

        title: const Text('AppMeteo'),

        backgroundColor: Colors.blue,

        foregroundColor: Colors.white,

      ),


     body: ville == null
    ? Center(child: CircularProgressIndicator())
    : Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: _couleurFond(ville.condition),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            


                Icon(

                  _iconeMeteo(ville.condition),

                  size: 100,

                  color: Colors.orange,

                ),


                const SizedBox(height: 20),


                Text(

                  '${ville.temperature.toStringAsFixed(0)} C',

                  style: const TextStyle(

                    fontSize: 60,

                    fontWeight: FontWeight.bold,

                  ),

                ),


                Text(

                  ville.nom,

                  style: TextStyle(

                    fontSize: 28,

                    color: Colors.grey[700],

                  ),

                ),


                Text(

                  '${ville.condition} - Humidite : ${ville.humidite}%',

                  style: TextStyle(

                    fontSize: 16,

                    color: Colors.grey[600],

                  ),

                ),


                const SizedBox(height: 30),


                ElevatedButton.icon(

                  icon: const Icon(Icons.list),

                  label: const Text('Changer de ville'),


                  onPressed: () {


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) => const EcranListeVilles(),

                      ),

                    );

                  },

                ),

              ],

            ),

    ),
   ); 

  }

}