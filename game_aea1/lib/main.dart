import 'package:flutter/material.dart';
import 'pantalles/pantalla_inici.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalla Pokémon',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const PantallaInici(),
    );
  }
}