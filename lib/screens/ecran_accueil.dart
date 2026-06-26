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

      case 'Orageux':
        return Icons.thunderstorm;

      case 'Venteux':
        return Icons.air;

      default:
        return Icons.wb_cloudy;
   }
  }


Color _couleurFond(String condition) {

  switch(condition){

    case 'Ensoleille':
      return Colors.orange[100]!;

    case 'Nuageux':
      return Colors.grey[300]!;

    case 'Pluvieux':
      return Colors.blue[100]!;

    default:
      return Colors.white;
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

? const Center(child: CircularProgressIndicator())


: Container(

width: double.infinity,

height: double.infinity,

decoration: BoxDecoration(

color: _couleurFond(ville.condition),

),


child: Column(

mainAxisAlignment: MainAxisAlignment.center,


children: [



// ICON METEO

Icon(

_iconeMeteo(ville.condition),

size: 100,

color: Colors.orange,

),



const SizedBox(height: 20),


// DONNEES REELLES METEO

Consumer<VilleViewModel>(

builder: (context, vm, _) {



if(vm.chargement){

return const CircularProgressIndicator();

}



if(vm.erreur != null){


return Column(

children: [


const Icon(

Icons.wifi_off,

size: 60,

color: Colors.red,

),


Text(

vm.erreur!,

style: const TextStyle(

color: Colors.red

),

),



ElevatedButton(

onPressed: (){

vm.selectionnerVille(

vm.villeSelectionnee!

);

},


child: const Text(

'Réessayer'

),

)



],

);

}




final meteo = vm.meteoActuelle;



if(meteo == null){

return const Text(

'Chargement...'

);

}




return Column(

children: [



Text(

'${meteo.temperature.toStringAsFixed(1)} C',

style: const TextStyle(

fontSize: 60,

fontWeight: FontWeight.bold,

),

),


Text(

'${meteo.conditionTexte} - ${meteo.humidite}% humidité',

style: TextStyle(

fontSize: 16,

color: Colors.grey[600],

),

),



],


);


},


),



const SizedBox(height:30),




ElevatedButton.icon(


icon: const Icon(Icons.list),


label: const Text(

'Changer de ville'

),



onPressed: (){


Navigator.push(

context,

MaterialPageRoute(

builder: (context)=> const EcranListeVilles(),

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