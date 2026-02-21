import 'package:flutter/material.dart';
import 'dart:math';
import '../models/pokemon.dart';
import 'pantalla_final.dart';

class PantallaBatalla extends StatefulWidget {
  const PantallaBatalla({super.key});

  @override
  State<PantallaBatalla> createState() => _PantallaBatallaState();
}

class _PantallaBatallaState extends State<PantallaBatalla> {
  // Creem els dos Pokémon segons els requisits (120 PS i 30 PP)
  late Pokemon pokemon1;
  late Pokemon pokemon2;
  
  bool tornJugador1 = true; // Control de qui és el torn
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    reiniciarBatalla();
  }

  void reiniciarBatalla() {
    pokemon1 = Pokemon(nom: "Pikachu (Jugador 1)", psMax: 120, ppMax: 30);
    pokemon2 = Pokemon(nom: "Charmander (Jugador 2)", psMax: 120, ppMax: 30);
    tornJugador1 = true;
  }

  void realitzarAtac(int costPP, int danyMin, int danyMax) {
    setState(() {
      Pokemon atacant = tornJugador1 ? pokemon1 : pokemon2;
      Pokemon defensor = tornJugador1 ? pokemon2 : pokemon1;

      // Càlcul del dany aleatori
      int dany = danyMin + _random.nextInt((danyMax - danyMin) + 1);

      atacant.consumirPP(costPP);
      defensor.rebreDany(dany);

      // Comprovem si la batalla ha acabat
      if (defensor.ps <= 0) {
        acabarBatalla(atacant);
      } else {
        tornJugador1 = !tornJugador1; // Passem el torn
      }
    });
  }

  void acabarBatalla(Pokemon guanyador) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaFinal(
          guanyador: guanyador.nom,
          atacsTotals: pokemon1.atacsRealitzats + pokemon2.atacsRealitzats,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Pokemon atacantActual = tornJugador1 ? pokemon1 : pokemon2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Batalla Pokémon'),
        automaticallyImplyLeading: false, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dades del Pokémon 2 (A dalt)
            Card(
              color: tornJugador1 ? Colors.grey[200] : Colors.orange[100],
              child: ListTile(
                title: Text(pokemon2.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('PS: ${pokemon2.ps} / 120  |  PP: ${pokemon2.pp} / 30'),
              ),
            ),
            const Spacer(),

            // Indicador de Torn
            Text(
              tornJugador1 ? "Torn del Jugador 1" : "Torn del Jugador 2",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),

            // Botons d'Atac
            ElevatedButton(
              onPressed: atacantActual.potAtacar(5) ? () => realitzarAtac(5, 10, 15) : null,
              child: const Text('Atac Ràpid (5 PP) - Dany: 10-15'),
            ),
            const SizedBox(height: 10),
            
            ElevatedButton(
              onPressed: atacantActual.potAtacar(10) ? () => realitzarAtac(10, 20, 25) : null,
              child: const Text('Atac Normal (10 PP) - Dany: 20-25'),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: atacantActual.potAtacar(20) ? () => realitzarAtac(20, 35, 45) : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Atac Fort (20 PP) - Dany: 35-45', style: TextStyle(color: Colors.white)),
            ),

            const Spacer(),
            
            // Dades del Pokémon 1 (A baix)
            Card(
              color: tornJugador1 ? Colors.yellow[100] : Colors.grey[200],
              child: ListTile(
                title: Text(pokemon1.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('PS: ${pokemon1.ps} / 120  |  PP: ${pokemon1.pp} / 30'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}