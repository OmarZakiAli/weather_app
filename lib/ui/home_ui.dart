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
  utils.Weather _weather = utils.Weather();

  void show() async {
    Map m = await getWeatherData("Cairo");
    String city = m["name"];
    String desc = m["weather"][0]["description"];
    num temp = m["main"]["temp"];
    num hum = m["main"]["humidity"];
    _weather =
        utils.Weather(city: city, description: desc, temp: temp, hum: hum);
    debugPrint(
        "city is ${_weather.city},  ${_weather.description}  temp is ${_weather.temp}");
    setState(() {});
  }

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
            onPressed: () => show(),
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
            child: Text("${_weather.city}", style: getCityStyle()),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset("images/light_rain.png"),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(60.0, 340.0, 0.0, 0.0),
            child: Text(
              "${_weather.temp}'c",
              style: tempstyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(60.0, 390.0, 0.0, 0.0),
            child: Text(
              "${_weather.hum}'h",
              style: tempstyle(),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30),
            alignment: Alignment.bottomCenter,
            child: Text(
              "${_weather.description}",
              style: tempstyle(),
            ),
          )
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
}

TextStyle tempstyle() {
  return TextStyle(
      color: Colors.white, fontSize: 44, fontWeight: FontWeight.w700);
}

TextStyle getCityStyle() {
  return TextStyle(
      color: Colors.white, fontSize: 32, fontStyle: FontStyle.italic);
}
