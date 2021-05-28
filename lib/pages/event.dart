import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  EventPage({Key key, this.color, this.code}) : super(key: key);

  final Color color;
  final int code;

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
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
            margin: EdgeInsets.only(top: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    child: Text(
                      "Weekly Briefing",
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
                        Text("MEETING - Work",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0)),
                        Text("JAN 21, 3PM PST",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0))
                      ]),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 8),
                    child: Text(
                      "Details",
                      style: TextStyle(
                          color: Color(0xFF1C1C1E),
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices convallis nisl, vitae blandit enim egestas nec. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ultrices convallis nisl, vitae blandit enim egestas nec. https://meet.google.com/lookup/bvsj5mbm",
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
                        children: [
                          Row(children: [
                            Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/2078265/pexels-photo-2078265.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  "Ron McRay",
                                  style: TextStyle(
                                      color: Color(0xFF1C1C1E),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0),
                                ))
                          ]),
                          SizedBox(height: 7),
                          Row(children: [
                            Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  "Cardi Bay",
                                  style: TextStyle(
                                      color: Color(0xFF1C1C1E),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0),
                                ))
                          ]),
                          SizedBox(height: 7),
                          Row(children: [
                            Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/428364/pexels-photo-428364.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Text(
                                  "Troye Bixenman",
                                  style: TextStyle(
                                      color: Color(0xFF1C1C1E),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.0),
                                ))
                          ]),
                        ],
                      )),
                ],
              ))
        ]));
  }
}
