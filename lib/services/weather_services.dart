import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';//for latitudinal and longitudinal location of current device
import 'package:flutter/material.dart';

class WeatherService{
    final String apiKey='d46da07e3c7a4db766363296651e8fe4';
    Future <Map<String,dynamic>> getWeather(String cityName) async{
        final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric'));
        if(response.statusCode==200){
        return jsonDecode(response.body);
    }
    else{
        throw Exception('Failed to load weather');
    }
    }
    
    Future <Map<String,dynamic>> fetchWeather(String cityName) async{
        Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        double lat=position.latitude;
        double long=position.longitude;
        final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric'));
        if(response.statusCode==200){
        return jsonDecode(response.body);
    }
    else{
        throw Exception('Failed to load weather');
    }
    }
    
}
    