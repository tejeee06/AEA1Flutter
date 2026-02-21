import 'package:flutter/material.dart';
import 'pantalla_batalla.dart';

class PantallaFinal extends StatelessWidget {
  final String guanyador;
  final int atacsTotals;

  const PantallaFinal({
    super.key,
    required this.guanyador,
    required this.atacsTotals,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final de la Batalla'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Batalla Acabada!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Text(
              'El guanyador és:\n$guanyador',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Atacs totals realitzats: $atacsTotals',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 50),
            
            // Botó Nova Batalla
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PantallaBatalla()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Nova Batalla', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 15),
            
            // Botó Tornar a l'inici
            ElevatedButton(
              onPressed: () {
                // Elimina totes les pantalles i torna a la d'inici
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Tornar a l\'inici', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}