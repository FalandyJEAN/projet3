/*
  Flutter est un framework (créé par Google), pas un langage.
  Le langage utilisé par Flutter, c'est Dart.
  En résumé : tu écris du code en Dart, et Flutter 
  te fournit les outils (widgets, navigation, animations…) 
  pour construire des apps multiplateformes (Android, iOS, 
  web, desktop) à partir d'un seul code.
*/

import 'package:flutter/material.dart';

/*
  importe la bibliothèque Material Design de Flutter. Concrètement,
  ça te donne accès à tout ce dont tu as besoin pour construire une
  interface graphique : les widgets (Text, Container, Scaffold, AppBar, 
  ElevatedButton…), les thèmes, les couleurs, les icônes Material, 
  la navigation, etc.
*/

// Première commande pour voir si tout marche : flutter doctor

// L'état d'une application s'appelle le **State** (état des écrans)

// Point d'entrée de l'application
void main() {
  runApp(MyApp());
}

// Racine de l'application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

// Écran principal
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ESIH App")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text("Hello"),
        ),
      ),
    );
  }
}

// Écran Contact (à compléter)
class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact")),
      body: Center(
        child: Text("Page Contact"),
      ),
    );
  }
}

/*
  Notes :
  - Chaque application commence par main() → runApp() → racine (MyApp)
  - MyApp retourne un MaterialApp (la racine de toute app Flutter)
  - Chaque écran est basé sur un Scaffold (structure de page)
  - Chaque classe qui hérite de StatelessWidget ou StatefulWidget = un écran
  - C'est comme une pièce d'identité : on appartient à un seul pays (la racine),
    et chaque écran a son propre Scaffold
*/