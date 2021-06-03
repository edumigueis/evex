import 'package:evex/models/localizacao.dart';

import 'funcionario.dart';
import 'tipo.dart';
import 'subtipo.dart';
import 'localizacao.dart';

class Event {
  final int id;
  final String title;
  final String description;
  final Funcionario creator;
  final Tipo type;
  final Subtipo subtype;
  final DateTime date;
  final Localizacao location;

  Event(this.id, this.title, this.description, this.creator, this.type,
      this.subtype, this.date, this.location);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      json['id'],
      json['titulo'],
      json['descricao'] != null ? json['descricao'] : "",
      Funcionario.fromJson(json['responsavel']),
      Tipo.fromJson(json['tipo']),
      json['subtipo'] != null ? Subtipo.fromJson(json['subtipo']) : null,
      DateTime.parse(json['datahora']),
      Localizacao.fromJson(json['localizacao']),
    );
  }
}
