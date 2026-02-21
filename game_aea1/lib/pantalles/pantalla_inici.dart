import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pantalla_batalla.dart';

class PantallaInici extends StatelessWidget {
  const PantallaInici({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Batalla Pokémon')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'VIDEOJOC DE BATALLA POKÉMON',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PantallaBatalla()),
                );
              },
              child: const Text('Començar Batalla'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                SystemNavigator.pop(); // Tanca l'aplicació
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Sortir', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}