import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/ville_viewmodel.dart';
import '../models/ville.dart';

class EcranAjoutVille extends StatefulWidget {
  const EcranAjoutVille({super.key});

  @override
  State<EcranAjoutVille> createState() => _EcranAjoutVilleState();
}

class _EcranAjoutVilleState extends State<EcranAjoutVille> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _paysController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _humiditeController = TextEditingController();
  String _conditionChoisie = 'Ensoleille';

  final List<String> _conditions = [
    'Ensoleille',
    'Nuageux',
    'Pluvieux',
    'Orageux',
    'Ventueux',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une ville'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom de la ville'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              TextFormField(
                controller: _paysController,
                decoration: InputDecoration(labelText: 'Pays'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              TextFormField(
                controller: _temperatureController,
                decoration: InputDecoration(labelText: 'Temperature (C)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              TextFormField(
                controller: _humiditeController,
                decoration: InputDecoration(labelText: 'Humidite (%)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              DropdownButtonFormField<String>(
                value: _conditionChoisie,
                decoration: InputDecoration(labelText: 'Condition'),
                items: _conditions
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _conditionChoisie = value!;
                  });
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final nouvelleVille = Ville(
                      nom: _nomController.text,
                      pays: _paysController.text,
                      temperature: double.parse(_temperatureController.text),
                      condition: _conditionChoisie,
                      humidite: int.parse(_humiditeController.text),
                    );
                    context.read<VilleViewModel>().ajouterVille(nouvelleVille);
                    Navigator.pop(context);
                  }
                },
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}