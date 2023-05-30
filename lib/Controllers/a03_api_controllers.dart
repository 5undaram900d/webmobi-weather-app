

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:webmobi_weather_app/Models/a02_weather_model.dart';


fetchWeather(String cityName) async {
  var uri = "https://yahoo-weather5.p.rapidapi.com/weather?location=${cityName.toString()=='' ? "kanpur" : cityName.toString()}";
  final url = Uri.parse(uri);
  final response = await http.get(
    url,
    headers: {
      'X-RapidAPI-Key': 'ab4256b002msh2c0e0c29e50a2c8p19ad4djsn9e903a26296f',
      'X-RapidAPI-Host': 'yahoo-weather5.p.rapidapi.com'
    }
  );

  if(response.statusCode==200){
    var data = weatherModelFromJson(response.body.toString());
    debugPrint("Fetching data successfully");
    return data;
  }
}