class Pokemon {
  String nom;
  int ps;
  int psMax;
  int pp;
  int ppMax;
  int atacsRealitzats = 0;
  String imatgeUrl;

  Pokemon({
    required this.nom,
    required this.psMax,
    required this.ppMax,
    required this.imatgeUrl,
  }) : ps = psMax, pp = ppMax;

  void rebreDany(int dany) {
    ps -= dany;
    if (ps < 0) ps = 0;
  }

  void curar(int quantitat) {
    ps += quantitat;
    if (ps > psMax) ps = psMax;
  }

  bool potAtacar(int cost) {
    return pp >= cost && ps > 0;
  }

  void consumirPP(int cost) {
    pp -= cost;
    if (pp < 0) pp = 0;
    atacsRealitzats++;
  }
}