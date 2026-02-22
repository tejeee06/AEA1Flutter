import 'package:flutter/material.dart';
import 'pantalla_batalla.dart';

class PantallaFinal extends StatelessWidget {
  final String guanyador;
  final int atacsTotals;

  const PantallaFinal({super.key, required this.guanyador, required this.atacsTotals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultat'), automaticallyImplyLeading: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('VICTÒRIA!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 20),
            Text('Guanyador: $guanyador', style: const TextStyle(fontSize: 24)),
            Text('Moviments totals: $atacsTotals', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PantallaBatalla())),
              child: const Text('Jugar de nou'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Tornar a Inici'),
            ),
          ],
        ),
      ),
    );
  }
}