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
  late Pokemon pokemon1;
  late Pokemon pokemon2;
  bool tornJugador1 = true;
  final Random _random = Random();
  List<String> historial = []; 

  @override
  void initState() {
    super.initState();
    reiniciarBatalla();
  }

  void reiniciarBatalla() {
    pokemon1 = Pokemon(
        nom: "Pikachu", 
        psMax: 100, 
        ppMax: 40, 
        imatgeUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png");
    pokemon2 = Pokemon(
        nom: "Charmander", 
        psMax: 100, 
        ppMax: 40, 
        imatgeUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png");
    tornJugador1 = true;
    historial.clear();
    historial.add("La batalla comença!");
  }

  void executarAccio({
    String nomAtac = "", 
    int costPP = 0, 
    int danyMin = 0, 
    int danyMax = 0, 
    bool esCura = false, 
    bool esDescans = false
  }) {
    setState(() {
      Pokemon atacant = tornJugador1 ? pokemon1 : pokemon2;
      Pokemon defensor = tornJugador1 ? pokemon2 : pokemon1;
      String missatgeLog = "";

      if (esDescans) {
        int ppRecuperats = 15;
        atacant.pp += ppRecuperats;
        if (atacant.pp > atacant.ppMax) atacant.pp = atacant.ppMax;
        atacant.atacsRealitzats++;
        missatgeLog = "${atacant.nom} descansa i recupera $ppRecuperats PP!";
      } 
      else if (esCura) {
        atacant.consumirPP(costPP);
        atacant.curar(25);
        missatgeLog = "${atacant.nom} utilitza Curació i recupera 25 PS!";
      } 
      else {
        atacant.consumirPP(costPP);
        int sort = _random.nextInt(100);
        
        if (sort < 5) {
          missatgeLog = "${atacant.nom} utilitza $nomAtac però FALLA!";
        } else {
          int dany = danyMin + _random.nextInt((danyMax - danyMin) + 1);
          if (sort >= 5 && sort < 15) {
            dany *= 2;
            missatgeLog = "Cop Crític! ${atacant.nom} fa $dany de dany amb $nomAtac!";
          } else {
            missatgeLog = "${atacant.nom} utilitza $nomAtac i fa $dany de dany.";
          }
          defensor.rebreDany(dany);
        }
      }

      historial.insert(0, missatgeLog); 

      if (defensor.ps <= 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PantallaFinal(
            guanyador: atacant.nom,
            atacsTotals: pokemon1.atacsRealitzats + pokemon2.atacsRealitzats,
          )),
        );
      } else {
        tornJugador1 = !tornJugador1;
      }
    });
  }

  Widget _buildPokemonCard(Pokemon p, bool esTorn) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: esTorn ? Colors.yellow[100] : Colors.grey[200],
        border: Border.all(color: esTorn ? Colors.orange : Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (esTorn) const BoxShadow(color: Colors.orangeAccent, blurRadius: 8, spreadRadius: 1)
        ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(p.nom, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Image.network(p.imatgeUrl, height: 60, fit: BoxFit.cover),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("PS: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: LinearProgressIndicator(
                  value: p.ps / p.psMax,
                  color: p.ps > (p.psMax * 0.3) ? Colors.green : Colors.red,
                  backgroundColor: Colors.grey[300],
                  minHeight: 12,
                ),
              ),
              Text(" ${p.ps}/${p.psMax}"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("PP: ", style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: LinearProgressIndicator(
                  value: p.pp / p.ppMax,
                  color: Colors.blue,
                  backgroundColor: Colors.grey[300],
                  minHeight: 12,
                ),
              ),
              Text(" ${p.pp}/${p.ppMax}"),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Pokemon atacantActual = tornJugador1 ? pokemon1 : pokemon2;

    return Scaffold(
      appBar: AppBar(title: const Text('Batalla Pokémon'), automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildPokemonCard(pokemon2, !tornJugador1),
            
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: historial.length > 5 ? 5 : historial.length,
                  itemBuilder: (context, index) => Text(
                    historial[index],
                    style: TextStyle(color: index == 0 ? Colors.white : Colors.grey, fontSize: 14),
                  ),
                ),
              ),
            ),

            Text(tornJugador1 ? "Torn de P1" : "Torn de P2", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: atacantActual.potAtacar(5) ? () => executarAccio(nomAtac: "A. Ràpid", costPP: 5, danyMin: 10, danyMax: 15) : null,
                  child: const Text('Ràpid (5PP)'),
                ),
                ElevatedButton(
                  onPressed: atacantActual.potAtacar(10) ? () => executarAccio(nomAtac: "A. Normal", costPP: 10, danyMin: 20, danyMax: 25) : null,
                  child: const Text('Normal (10PP)'),
                ),
                ElevatedButton(
                  onPressed: atacantActual.potAtacar(20) ? () => executarAccio(nomAtac: "A. Fort", costPP: 20, danyMin: 35, danyMax: 45) : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  child: const Text('Fort (20PP)', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: atacantActual.potAtacar(15) ? () => executarAccio(esCura: true, costPP: 15) : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Curar (15PP)', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: atacantActual.pp < atacantActual.ppMax ? () => executarAccio(esDescans: true) : null,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  child: const Text('Descansar (+15 PP)', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            
            _buildPokemonCard(pokemon1, tornJugador1),
          ],
        ),
      ),
    );
  }
}