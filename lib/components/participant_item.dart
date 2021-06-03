import 'package:evex/models/funcionario.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ParticipantItem extends StatelessWidget {
  ParticipantItem({Key key, this.participant}) : super(key: key);

  final Funcionario participant;
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
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    int randInt = random.nextInt(colors.length - 1);
    return Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Row(children: [
          Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: colors[randInt])),
          Padding(
              padding: EdgeInsets.only(left: 7),
              child: Text(
                participant.nome,
                style: TextStyle(
                    color: Color(0xFF1C1C1E),
                    fontWeight: FontWeight.w500,
                    fontSize: 13.0),
              ))
        ]));
  }
}
