import 'dart:ui';
import 'package:evex/utils/consts.dart';
import 'package:evex/models/event.dart';
import 'package:evex/components/list_item.dart';
import 'package:evex/pages/createEvent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> events = [];
  final _idController = TextEditingController();

  Future<List<Event>> _fetchData() async {
    final response =
        await http.get(Uri.parse('http://' + Consts.ip + '/eventos'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<Event> ret = [];
      int length = jsonDecode(response.body).length;
      for (int i = 0; i < length; i++) {
        ret.add(Event.fromJson(jsonDecode(response.body)[i]));
      }
      return ret;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  _setId() async {
    await FlutterSession().set("id", int.parse(_idController.text));
    dynamic id = await FlutterSession().get("id");
  }

  initState() {
    super.initState();
    _fetchData().then((value) => {
          setState(() {
            events = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: CustomScrollView(
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            pinned: true,
            floating: false,
            snap: false,
            leading: Padding(
                padding: EdgeInsets.only(left: 20), child: Icon(Icons.ac_unit)),
            actions: [
              Icon(Icons.search),
              GestureDetector(
                  onTap: () => {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 150,
                                color: Color(0xFFEEEEEE),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: 10, top: 30),
                                        child: Text(
                                          "Change your ID",
                                          style: TextStyle(
                                              color: Color(0xFF1C1C1E),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  7),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    autofocus: false,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        color:
                                                            Color(0xFF1C1C1E)),
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 8.0,
                                                                top: 8.0),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            const Radius
                                                                .circular(8.0),
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        )),
                                                    controller: _idController,
                                                  ),
                                                ),
                                                IconButton(
                                                    icon: Icon(
                                                        Icons.arrow_forward),
                                                    color: Color(0xFF1C1C1E),
                                                    onPressed: () => {
                                                          _setId(),
                                                          Navigator.pop(context)
                                                        })
                                              ]))
                                    ],
                                  ),
                                ),
                              );
                            })
                      },
                  child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 20),
                      child: Icon(Icons.more_vert)))
            ],
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('All Events',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/443383/pexels-photo-443383.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: new Container(
                  decoration: new BoxDecoration(
                      color: Color(0xFF1C1C1E).withOpacity(0.65)),
                ),
              ),
            ),
          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
              (context, index) => ListItem(event: events[index]),
              childCount: events.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEvent()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Color(0xFF1C1C1E),
      ),
    );
  }
}
