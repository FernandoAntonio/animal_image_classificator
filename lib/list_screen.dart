import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ListScreen extends StatelessWidget {
  static const id = 'ListScreen';

  final List<String> animalsListEng = [
    'Antelope',
    'Bat',
    'Beaver',
    'Bobcat',
    'Buffalo',
    'Collie',
    'Dalmatian',
    'German Sheperd',
    'Grizzly Bear',
    'Hippopotamus',
    'Horse',
    'Killer Whale',
    'Mouse',
    'Otter',
    'Panda',
    'Persian Cat',
    'Rhinoceros',
    'Seal',
    'Siamese Cat',
    'Wolf',
  ];

  final List<String> animalsListPt = [
    'Antílope',
    'Morcego',
    'Castor',
    'Lince',
    'Búfalo',
    'Collie',
    'Dálmata',
    'Pastor Alemão',
    'Urso Pardo',
    'Hipopótamo',
    'Cavalo',
    'Orca',
    'Rato',
    'Lontra',
    'Panda',
    'Gato Persa',
    'Rinoceronte',
    'Foca',
    'Gato Siamês',
    'Lobo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: GradientAppBar(
        gradient: FlutterGradients.viciousStance(),
        title: Text('Supported Animals List'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView.builder(
      itemCount: animalsListEng.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            animalsListEng.elementAt(index),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            animalsListPt.elementAt(index),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
