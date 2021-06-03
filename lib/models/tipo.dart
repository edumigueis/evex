class Tipo {
  final int id;
  final String nome;

  Tipo(this.id, this.nome);

  factory Tipo.fromJson(Map<String, dynamic> json) {
    return Tipo(json['id'], json['tipo']);
  }
}
