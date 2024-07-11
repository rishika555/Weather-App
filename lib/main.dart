import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for DateFormat
import 'widget/weather_data.dart';
import 'services/weather_services.dart'; // Assuming WeatherService is in this file
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  String _bgImg = 'assets/images/background.jpeg';
  String _iconImg = 'assets/icons/haze.png';
  String cityName = '';
  String temp = '';
  String tempMax = '';
  String tempMin = '';
  String sunrise = '';
  String sunset = '';
  String humidity = '';
  String main = '';
  String visibility = '';
  String windSpeed = '';

  getData(String cityName) async {
    final weatherService = WeatherService();
    var weatherData;
    if(cityName == '') {
      weatherData = await weatherService.fetchWeather('');
    }
    else {
    weatherData = await weatherService.getWeather(cityName);
    }
    setState(() {
      this.cityName = weatherData['name'];
      temp = weatherData['main']['temp'].toString();
      tempMax = weatherData['main']['temp_max'].toString();
      tempMin = weatherData['main']['temp_min'].toString();
      sunrise = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunrise'] * 1000));
      sunset = DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(weatherData['sys']['sunset'] * 1000));
      humidity = weatherData['main']['humidity'].toString();
      main = weatherData['weather'][0]['main'];
      visibility = weatherData['visibility'].toString();
      windSpeed = weatherData['wind']['speed'].toString();
      if (main == 'Haze') {
        _bgImg = 'assets/images/haze.jpg';
        _iconImg = 'assets/icons/haze.png';
      } else if (main == 'Clouds') {
        _bgImg = 'assets/images/cloudy.jpg';
        _iconImg = 'assets/icons/cloudy.png';
      } else if (main == 'Clear') {
        _bgImg = 'assets/images/clear.jpg';
        _iconImg = 'assets/icons/clear.png';
      } else if (main == 'Rain') {
        _bgImg = 'assets/images/rainy.jpeg';
        _iconImg = 'assets/icons/rainy.png';
      } else if (main == 'Snow') {
        _bgImg = 'assets/images/snowy.jpeg';
        _iconImg = 'assets/icons/snowy.png';
      } else if (main == 'Thunderstorm') {
        _bgImg = 'assets/images/thunderstorm.jpeg';
        _iconImg = 'assets/icons/thunderstorm.png';
      } else if (main == 'Fog') {
        _bgImg = 'assets/images/fog.jpg';
        _iconImg = 'assets/icons/fog.png';
      }
    });
  }

  Future<bool> _checkLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
      getData('');
    }
    getData('');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            _bgImg,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  TextField(
                    controller: _controller,
                    onChanged: (value) {
                      getData(value);
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Enter City',
                      hintText: 'Enter City',
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        cityName.isNotEmpty ? cityName : 'Enter a city name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Text(
                    temp.isNotEmpty ? '$temp°C' : 'Loading...',
                    style: TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    main.isNotEmpty ? main : '',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        main,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(_iconImg, height: 80, width: 80),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.arrow_upward),
                      Text(
                        tempMax.isNotEmpty ? '$tempMax°C' : '',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Icon(Icons.arrow_downward),
                      Text(
                        tempMin.isNotEmpty ? '$tempMin°C' : '',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Card(
                    elevation: 10,
                    color: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          WeatherData(
                            index1: 'Sunrise',
                            index2: 'Sunset',
                            value1: sunrise,
                            value2: sunset,
                          ),
                          SizedBox(height: 15),
                          WeatherData(
                            index1: 'Humidity',
                            index2: 'Visibility',
                            value1: humidity,
                            value2: visibility,
                          ),
                          SizedBox(height: 15),
                          WeatherData(
                            index1: 'Wind Speed',
                            index2: 'Weather',
                            value1: windSpeed,
                            value2: main,
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
