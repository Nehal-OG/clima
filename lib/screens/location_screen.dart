import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  // String temp = weatherData['main']['temp'];

  LocationScreen({this.locationWeatherData});

  final locationWeatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temprature;
  int condition;
  String cityname;
  String getMessage;
  String weatherIcon;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeatherData);
    print(widget.locationWeatherData);
  }

  void updateUI(weatherData) {
    setState(() {
      if (weatherData == null) {
        print("null");
        temprature = 0;
        weatherIcon = ' Error';
        getMessage = 'Unable to get weather data';
        cityname = '';
        return;
      } else {
        double temp = weatherData['main']['temp'];
        temprature = temp.toInt();
        condition = weatherData['weather'][0]['id'];
        cityname = weatherData['name'];
        getMessage = weather.getMessage(temprature, condition);
        weatherIcon = weather.getWeatherIcon(condition);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () async {
                      var weatherData = await weather.getweatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 45.0,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      String Typecity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      print(Typecity);
                      if (Typecity != null) {
                        var weatherData =
                            await weather.getCityWeather(Typecity);
                        print(weatherData);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 45.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$getMessage in $cityname',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
