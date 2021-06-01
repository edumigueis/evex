import 'dart:ui';
import 'package:evex/models/event.dart';
import 'package:evex/components/list_item.dart';
import 'package:evex/pages/createEvent.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> events = [];

  Future<List<Event>> _fetchData() async {
    final response =
        await http.get(Uri.parse('http://143.106.202.70:3000/eventos'));

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
              Padding(
                  padding: EdgeInsets.only(left: 5, right: 20),
                  child: Icon(Icons.more_vert))
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
