import 'departamento.dart';

class Funcionario {
  final int id;
  final String nome;
  final String apelido;
  final Departamento departamento;

  Funcionario(this.id, this.nome, this.apelido, this.departamento);

  factory Funcionario.fromJson(Map<String, dynamic> json) {
    return Funcionario(json['id'], json['nome'], json['apelido'],
        Departamento.fromJson(json['departamento']));
  }
}
