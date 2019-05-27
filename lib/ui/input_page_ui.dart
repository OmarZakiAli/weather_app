import 'package:flutter/material.dart';
import './home_ui.dart';

class InputUi extends StatefulWidget {
  @override
  _InputUiState createState() => _InputUiState();
}

class _InputUiState extends State<InputUi> {
  @override
  Widget build(BuildContext context) {
    var _cityController = TextEditingController();

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          "weater forecast",
          style: TextStyle(color: Colors.green.shade50, fontSize: 24),
        ),
      ),
      backgroundColor: Colors.red.shade50,
      body: ListView(
        padding: EdgeInsets.only(top: 100),
        children: <Widget>[
          TextField(
            controller: _cityController,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.map,
                  color: Colors.red,
                ),
                hintText: "first letter upper case",
                labelText: "enter city name",
                fillColor: Colors.green.shade200),
          ),
          Padding(padding: EdgeInsets.only(top: 70)),
          FlatButton(
            onPressed: () {
              debugPrint("wtf2");
              var router = MaterialPageRoute(builder: (BuildContext context) {
                return Home(city: _cityController.value.text);
              });
              Navigator.of(context).push(router);
            },
            color: Colors.red,
            child: Text(
              "show weather",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    ));
  }
}
