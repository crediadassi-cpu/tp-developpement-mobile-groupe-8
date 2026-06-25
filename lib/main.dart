import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/ville_viewmodel.dart';
import 'screens/ecran_accueil.dart';


void main() {

  runApp(

    ChangeNotifierProvider(

      create: (context) => VilleViewModel(),

      child: const MyApp(),

    ),

  );

}



class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'AppMeteo',

      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),

      home: const EcranAccueil(),

    );

  }

}