import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apikey = '33f7bcfb0a2b5eec9a2a2b61e6af703a';
const openweathermap = 'https://api.openweathermap.org/data/2.5/find';
class WeatherModel {

  Future<dynamic> getcitydata(String cityName) async{
    var url = '$openweathermap?q=$cityName&appid=$apikey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var data = await networkHelper.get_weather();
    return(data);
  }

  Future<dynamic> getlocationdata() async {
    Location location = Location();
    await location.getlocation();
    NetworkHelper networkHelper = NetworkHelper('$openweathermap?lat=${location.latitude}&lon=${location.longitude}&cnt=10&appid=$apikey&units=metric');
    var networkdata = await networkHelper.get_weather();
    return networkdata;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
