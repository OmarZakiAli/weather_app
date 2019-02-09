import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import '../util/utils.dart' as utils;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  String city = "Cairo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "weather forecast",
          style: TextStyle(fontSize: 24, color: Colors.greenAccent.shade50),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => debugPrint("button pressed"),
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              'images/umbrella.png',
              width: 500,
              height: 1000,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(right: 40, top: 30),
            child: getCity(context),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset("images/light_rain.png"),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(60.0, 340.0, 0.0, 0.0),
              child: getTemp(context)),
          Container(
              margin: EdgeInsets.fromLTRB(60.0, 390.0, 0.0, 0.0),
              child: getHum(context)),
          Container(
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30),
              alignment: Alignment.bottomCenter,
              child: getDesc(context))
        ],
      ),
    );
  }

  Future<Map> getWeatherData(String city) async {
    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?q=$city,EG&appid=${utils.appid}&units=metric";
    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  TextStyle tempstyle() {
    return TextStyle(
        color: Colors.white, fontSize: 44, fontWeight: FontWeight.w700);
  }

  TextStyle getCityStyle() {
    return TextStyle(
        color: Colors.white, fontSize: 32, fontStyle: FontStyle.italic);
  }

  getCity(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          return Text("${snapshot.data["name"]}", style: getCityStyle());
        } else {
          return Container();
        }
      },
      future: getWeatherData(city),
    );
  }

  getTemp(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          return Text(
            "${snapshot.data["main"]["temp"]}'c",
            style: tempstyle(),
          );
        } else {
          return Container();
        }
      },
      future: getWeatherData(city),
    );
  }

  getHum(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          return Text(
            "${snapshot.data["main"]["humidity"]}'h",
            style: tempstyle(),
          );
        } else {
          return Container();
        }
      },
      future: getWeatherData(city),
    );
  }

  getDesc(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          return Text(
            "${snapshot.data["weather"][0]["description"]}",
            style: tempstyle(),
          );
        } else {
          return Container();
        }
      },
      future: getWeatherData(city),
    );
  }
}
