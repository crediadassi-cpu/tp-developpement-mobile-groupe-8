import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/ville_viewmodel.dart';
import '../Models/ville.dart';


class EcranAjoutVille extends StatefulWidget {

  const EcranAjoutVille({super.key});


  @override
  State<EcranAjoutVille> createState() => _EcranAjoutVilleState();

}



class _EcranAjoutVilleState extends State<EcranAjoutVille> {


  final _formKey = GlobalKey<FormState>();


  final TextEditingController _villeController =
      TextEditingController();



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text("Ajouter une ville"),

        backgroundColor: Colors.blue,

      ),



      body: Padding(


        padding: const EdgeInsets.all(20),



        child: Form(


          key: _formKey,



          child: ListView(


            children: [



              TextFormField(


                controller: _villeController,


                decoration: const InputDecoration(

                  labelText: "Nom de la ville",

                  border: OutlineInputBorder(),

                ),



                validator: (value){


                  if(value == null || value.isEmpty){


                    return "Veuillez entrer une ville";


                  }


                  return null;


                },


              ),



              const SizedBox(height:20),




              ElevatedButton(


                child: const Text(

                  "Ajouter"

                ),



                onPressed: (){


                  if(_formKey.currentState!.validate()){



                    final vm = context.read<VilleViewModel>();



                    vm.ajouterVille(


                      Ville(


                        nom: _villeController.text,


                        pays: "Inconnu",


                        temperature: 0,


                        humidite: 0,


                        condition: "Nuageux",


                      )


                    );




                    Navigator.pop(context);



                  }


                },


              )



            ],


          ),


        ),


      ),


    );


  }


}