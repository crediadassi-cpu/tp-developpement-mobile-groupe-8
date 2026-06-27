import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ville.dart';
import '../viewmodels/ville_viewmodel.dart';

class EcranAjoutVille extends StatefulWidget {
  const EcranAjoutVille({super.key});

  @override
  State<EcranAjoutVille> createState() => _EcranAjoutVilleState();
}

class _EcranAjoutVilleState extends State<EcranAjoutVille> {
  final _formKey = GlobalKey<FormState>();

  final nomController = TextEditingController();
  final paysController = TextEditingController();
  final tempController = TextEditingController();
  final humiditeController = TextEditingController();

  String condition = 'Ensoleille';

  @override
  void dispose() {
    nomController.dispose();
    paysController.dispose();
    tempController.dispose();
    humiditeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter une ville"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // NOM
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(labelText: "Nom de la ville"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Champ obligatoire" : null,
              ),

              // PAYS
              TextFormField(
                controller: paysController,
                decoration: const InputDecoration(labelText: "Pays"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Champ obligatoire" : null,
              ),

              // TEMPERATURE
              TextFormField(
                controller: tempController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Température"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Champ obligatoire" : null,
              ),

              // HUMIDITE
              TextFormField(
                controller: humiditeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Humidité"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Champ obligatoire" : null,
              ),

              const SizedBox(height: 15),

              // CONDITION
              DropdownButtonFormField<String>(
                value: condition,
                items: const [
                  DropdownMenuItem(
                    value: 'Ensoleille',
                    child: Text("Ensoleillé"),
                  ),
                  DropdownMenuItem(value: 'Nuageux', child: Text("Nuageux")),
                  DropdownMenuItem(value: 'Pluvieux', child: Text("Pluvieux")),
                  DropdownMenuItem(value: 'Orageux', child: Text("Orageux")),
                  DropdownMenuItem(value: 'Venteux', child: Text("Venteux")),
                ],
                onChanged: (value) {
                  setState(() {
                    condition = value!;
                  });
                },
                decoration: const InputDecoration(labelText: "Condition météo"),
              ),

              const SizedBox(height: 25),

              // BOUTON AJOUTER
              ElevatedButton(
                child: const Text("Ajouter"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final ville = Ville(
                      nom: nomController.text,
                      pays: paysController.text,
                      temperature: double.parse(tempController.text),
                      condition: condition,
                      humidite: int.parse(humiditeController.text),
                    );
                    context.read<VilleViewModel>().ajouterVille(ville);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}