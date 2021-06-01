class Event {
  final int id;
  final String title;
  final String description;
  final int creator;
  final int type;
  final int subtype;
  final DateTime date;
  final int location;

  Event(this.id, this.title, this.description, this.creator, this.type,
      this.subtype, this.date, this.location);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      json['id'],
      json['titulo'],
      json['descricao'] != null ? json['descricao'] : "",
      json['responsavel'],
      json['tipo'],
      json['subtipo'],
      DateTime.parse(json['datahora']),
      json['localizacao'],
    );
  }
}
