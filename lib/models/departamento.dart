class Departamento {
  final int id;
  final String nome;
  Departamento(this.id, this.nome);

  factory Departamento.fromJson(Map<String, dynamic> json) {
    return Departamento(json['id'], json['nome']);
  }
}
