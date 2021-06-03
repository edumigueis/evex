import 'dart:convert';

import 'package:evex/models/event.dart';
import 'package:evex/models/funcionario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:evex/components/participant_item.dart';

class EventPage extends StatefulWidget {
  EventPage({Key key, this.color, this.event}) : super(key: key);

  final Color color;
  final Event event;

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Funcionario> participantes = [];

  Future<List<Funcionario>> _fetchData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.100:3000/participantes?evento=' +
            widget.event.id.toString()));

    if (response.statusCode == 200) {
      List<Funcionario> ret = [];
      int length = jsonDecode(response.body).length;
      for (int i = 0; i < length; i++)
        ret.add(Funcionario.fromJson(jsonDecode(response.body)[i]));
      return ret;
    } else {
      throw Exception('Failed to load');
    }
  }

  initState() {
    super.initState();
    _fetchData().then((value) => {
          setState(() {
            participantes = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Color(0xFF1C1C1E)),
          actions: [
            Icon(Icons.notifications_outlined),
            Padding(
                padding: EdgeInsets.only(left: 5, right: 20),
                child: Icon(Icons.more_vert))
          ],
        ),
        extendBodyBehindAppBar: true,
        body: Column(children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    child: Text(
                      widget.event.title,
                      style: TextStyle(
                          color: Color(0xFF1C1C1E),
                          fontWeight: FontWeight.w600,
                          fontSize: 19.0),
                    )),
                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.color,
                  ),
                )
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.event.type.nome.toString(),
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0)),
                        Text(
                            DateFormat('dd/MMM/yyyy H:m')
                                .format(widget.event.date.toLocal())
                                .toLowerCase(),
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0))
                      ]),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 8),
                      child: () {
                        if (widget.event.description != "") {
                          return Text(
                            "Details",
                            style: TextStyle(
                                color: Color(0xFF1C1C1E),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                          );
                        } else
                          return Text(" ");
                      }()),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(widget.event.description,
                          style: TextStyle(
                              color: Color(0xFF1C1C1E),
                              fontWeight: FontWeight.w400,
                              fontSize: 13.0))),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Participants",
                      style: TextStyle(
                          color: Color(0xFF1C1C1E),
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(participantes.length, (i) {
                          return ParticipantItem(participant: participantes[i]);
                        }),
                      )),
                ],
              ))
        ]));
  }
}
