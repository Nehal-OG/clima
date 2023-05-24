import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '79a038fef48191504e3bbaf9e2158463';
const openweatherAPI = 'https://api.openweathermap.org/data/2.5/weather';

Location located = Location();

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Api apiget = Api('$openweatherAPI?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await apiget.getData();
    return weatherData;
  }

  Future<dynamic> getweatherData() async {
    await located.getCurrentLocation();

    Api apiget = Api(
        '$openweatherAPI?lat=${located.latitude}&lon=${located.longitude}&appid=$apiKey&units=metric');

    var weatherData = await apiget.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp, condition) {
    if (temp > 25 && condition == 800) {
      return 'It\'s 🍦 time' 'and' 'Time for shorts and 👕';
    } else if (temp < 10 || condition == 700) {
      return 'You\'ll need 🧣 and 🧤';
    } else if (temp > 25 || condition == 400 || condition == 600) {
      return 'Bring ☔️  just in case';
    } else if (temp > 20 && condition == 800) {
      return 'Time for shorts and 👕';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
