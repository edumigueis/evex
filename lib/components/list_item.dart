import 'package:evex/models/event.dart';
import 'package:evex/pages/event.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ListItem extends StatelessWidget {
  ListItem({Key key, this.event}) : super(key: key);

  final Event event;

  final colors = [
    Color(0xFFFFD23F),
    Color(0xFFEE4266),
    Color(0xFF623CEA),
    Color(0xFF04E762),
    Color(0xFF00A1E4),
    Color(0xFF977EF1),
    Color(0xFFF58FA5),
    Color(0xFFFFDE70),
    Color(0xFF5EFDA0),
    Color(0xFF70D4FF),
  ];
  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    int nm = rng.nextInt(10);
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EventPage(event: this.event, color: colors[nm])),
          );
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(vertical: 11, horizontal: 22),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "MEETING",
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11.0),
                            ),
                            Text(
                              event.title,
                              style: TextStyle(
                                  color: Color(0xFF1C1C1E),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Helena Coffer",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0),
                                ))
                          ]),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("JAN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF1C1C1E),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                          Text("21",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF1C1C1E),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0)),
                        ],
                      )
                    ],
                  )),
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: colors[nm],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
              )
            ])));
  }
}
