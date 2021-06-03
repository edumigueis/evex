class Subtipo {
  final int id;
  final String nome;

  Subtipo(this.id, this.nome);

  factory Subtipo.fromJson(Map<String, dynamic> json) {
    return Subtipo(json['id'], json['nome']);
  }
}
