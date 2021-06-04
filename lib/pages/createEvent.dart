import 'package:evex/components/event_participant_item.dart';
import 'package:evex/models/event.dart';
import 'package:evex/models/funcionario.dart';
import 'package:evex/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:evex/models/tipo.dart';
import 'package:evex/models/localizacao.dart';
import 'package:evex/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';

class CreateEvent extends StatefulWidget {
  CreateEvent({Key key, this.eventId}) : super(key: key);

  final int eventId;

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEvent> {
  Event event;
  List<Tipo> types = [];
  List<Localizacao> locations = [];
  List<Funcionario> participants = [];

  dynamic sessionId;

  Tipo dropdownCurType;
  Localizacao dropdownCurLocation;
  DateTime selectedDate = DateTime.now();

  Future<Event> _fetchEvent() async {
    final response = await http.get(Uri.parse(
        'http://' + Consts.ip + '/eventos?id=' + widget.eventId.toString()));

    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Tipo>> _fetchTypes() async {
    final response =
        await http.get(Uri.parse('http://' + Consts.ip + '/tipos'));

    if (response.statusCode == 200) {
      List<Tipo> ret = [];
      int length = jsonDecode(response.body).length;
      for (int i = 0; i < length; i++)
        ret.add(Tipo.fromJson(jsonDecode(response.body)[i]));
      return ret;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Localizacao>> _fetchLocations() async {
    final response =
        await http.get(Uri.parse('http://' + Consts.ip + '/locais'));

    if (response.statusCode == 200) {
      List<Localizacao> ret = [];
      int length = jsonDecode(response.body).length;
      for (int i = 0; i < length; i++)
        ret.add(Localizacao.fromJson(jsonDecode(response.body)[i]));
      return ret;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<Funcionario> _fetchFuncionarioAtual() async {
    sessionId = await FlutterSession().get("id");
    return _fetchFuncionario(sessionId);
  }

  Future<Funcionario> _fetchFuncionario(int id) async {
    final response = await http.get(
        Uri.parse('http://' + Consts.ip + '/funcionarios?id=' + id.toString()));

    if (response.statusCode == 200)
      return Funcionario.fromJson(jsonDecode(response.body));
    else
      throw Exception('Failed to load');
  }

  void _addParticipant() async {
    int partId = int.parse(_partController.text);
    Funcionario part = await _fetchFuncionario(partId);
    setState(() {
      participants.add(part);
    });
    _partController.clear();
  }

  initState() {
    super.initState();

    if (widget.eventId != null) {
      _fetchEvent().then((value) => {
            setState(() {
              event = value;
              _titleController.text = event.title;
              _descController.text = event.description;
              dropdownCurType = event.type;
              dropdownCurLocation = event.location;
              selectedDate = event.date;
            })
          });
    }

    _fetchTypes().then((value) => {
          setState(() {
            types = value;
            dropdownCurType = types[0];
          })
        });
    _fetchLocations().then((value) => {
          setState(() {
            locations = value;
            dropdownCurLocation = locations[0];
          })
        });
    _fetchFuncionarioAtual().then((value) => {
          setState(() {
            participants.add(value);
          })
        });
  }

  void _register() async {
    dynamic id = await FlutterSession().get("id");
    var response;
    if (widget.eventId == null) {
      response = await http.post(
        Uri.parse('http://' + Consts.ip + '/eventos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'titulo': _titleController.text,
          'descricao': _descController.text,
          'responsavel': id.toString(),
          'tipo': dropdownCurType.id.toString(),
          'subtipo': null,
          'datahora': selectedDate.toString(),
          'localizacao': dropdownCurLocation.id.toString(),
        }),
      );
    } else {
      response = await http.put(
        Uri.parse('http://' + Consts.ip + '/eventos'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'id': widget.eventId.toString(),
          'titulo': _titleController.text,
          'descricao': _descController.text,
          'responsavel': id.toString(),
          'tipo': dropdownCurType.id.toString(),
          'subtipo': null,
          'datahora': selectedDate.toString(),
          'localizacao': dropdownCurLocation.id.toString(),
        }),
      );
    }

    int eventId;
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      eventId = int.parse(body.toString());
    } else
      throw Exception('Failed to load');

    participants.forEach((p) async {
      await http.post(
        Uri.parse('http://' + Consts.ip + '/participantes'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'evento': eventId.toString(),
          'funcionario': p.id.toString(),
        }),
      );
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _partController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: false,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
              padding: EdgeInsets.only(left: 26, right: 26, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Event Name",
                      style: TextStyle(
                          color: Color(0xFF1C1C1E),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    style: TextStyle(fontSize: 15.0, color: Color(0xFF1C1C1E)),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        )),
                    controller: _titleController,
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 26, right: 26, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Description",
                      style: TextStyle(
                          color: Color(0xFF1C1C1E),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  TextField(
                    autofocus: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    style: TextStyle(fontSize: 15.0, color: Color(0xFF1C1C1E)),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        )),
                    controller: _descController,
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 26, right: 26, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Category",
                      style: TextStyle(
                          color: Color(0xFF1C1C1E),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<Tipo>(
                        value: dropdownCurType,
                        underline: SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF1C1C1E)),
                        iconSize: 24,
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Color(0xFF1C1C1E)),
                        onChanged: (Tipo newValue) {
                          setState(() {
                            dropdownCurType = newValue;
                          });
                        },
                        isExpanded: true,
                        items: types.map((Tipo tipo) {
                          return new DropdownMenuItem<Tipo>(
                            value: tipo,
                            child: new Text(
                              tipo.nome,
                              style: new TextStyle(
                                  color: Color(0xFF1C1C1E),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 26, right: 26, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Location",
                      style: TextStyle(
                          color: Color(0xFF1C1C1E),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: DropdownButton<Localizacao>(
                        value: dropdownCurLocation,
                        underline: SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF1C1C1E)),
                        iconSize: 24,
                        dropdownColor: Colors.white,
                        style: const TextStyle(color: Color(0xFF1C1C1E)),
                        onChanged: (Localizacao newValue) {
                          setState(() {
                            dropdownCurLocation = newValue;
                          });
                        },
                        isExpanded: true,
                        items: locations.map((Localizacao localizacao) {
                          return new DropdownMenuItem<Localizacao>(
                            value: localizacao,
                            child: new Text(
                              localizacao.nome,
                              style: new TextStyle(
                                  color: Color(0xFF1C1C1E),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 26, right: 26, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Date",
                      style: TextStyle(
                          color: Color(0xFF1C1C1E),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(8.0),
                          ),
                          color: Colors.white,
                        ),
                        child: TextButton(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$selectedDate",
                                  ),
                                  Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Color(0xFF1C1C1E))
                                ],
                              )),
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2500, 12, 1),
                                onChanged: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            }, onConfirm: (date) {
                              setState(() {
                                selectedDate = date;
                              });
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ))),
                        ),
                      ))
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 26, right: 26, top: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Participants",
                        style: TextStyle(
                            color: Color(0xFF1C1C1E),
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                    TextField(
                      autofocus: false,
                      style:
                          TextStyle(fontSize: 15.0, color: Color(0xFF1C1C1E)),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(8.0),
                            ),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          )),
                      controller: _partController,
                    ),
                    TextButton.icon(
                        onPressed: _addParticipant,
                        icon: Icon(Icons.add),
                        label: Text("Add participant")),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(participants.length, (i) {
                        return EventParticipantItem(
                          participant: participants[i],
                          removable: participants[i].id != sessionId,
                        );
                      }),
                    )
                  ])),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26, vertical: 40),
            child: SizedBox(
              height: 40,
              child: TextButton(
                child: Text(
                  "Cadastrar",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF1C1C1E))),
                onPressed: _register,
              ),
            ),
          )
        ],
      ),
    );
  }
}
