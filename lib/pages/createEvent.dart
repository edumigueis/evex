import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateEvent extends StatefulWidget {
  CreateEvent({Key key}) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEvent> {
  String dropdownValue = 'One';
  String dropdownValueLoc = 'One';
  DateTime selectedDate = DateTime.now();
  _register() {}
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
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF1C1C1E)),
                          iconSize: 24,
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Color(0xFF1C1C1E)),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          isExpanded: true,
                          items: <String>['One', 'Two', 'Free', 'Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
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
                        child: DropdownButton<String>(
                          value: dropdownValueLoc,
                          underline: SizedBox(),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF1C1C1E)),
                          iconSize: 24,
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Color(0xFF1C1C1E)),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValueLoc = newValue;
                            });
                          },
                          isExpanded: true,
                          items: <String>['One', 'Two', 'Free', 'Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
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
