class Localizacao {
  final int id;
  final String nome;

  Localizacao(this.id, this.nome);

  factory Localizacao.fromJson(Map<String, dynamic> json) {
    return Localizacao(json['id'], json['nome']);
  }
}
