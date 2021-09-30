import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationweather;
  LocationScreen({this.locationweather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temprature;
  String city;
  String weatherIcon;
  String readabledata ;

  @override
  void initState(){
    super.initState();
    updateUI(widget.locationweather);
  }
  void updateUI(dynamic weatherdata){
    setState(() {
      if (weatherdata == null){
        temprature = 0;
        city = '';
        weatherIcon = 'Error';
        readabledata = 'unexpected Error';
        return;
      }
      var temp = weatherdata['list'][0]['main']['temp'];
      temprature = temp.toInt();
      city = weatherdata['list'][0]['name'];
      var condition = weatherdata['list'][0]['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      readabledata = weatherModel.getMessage(temprature);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
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
                  FlatButton(
                    onPressed: () async {
                      var weatherdata = await weatherModel.getlocationdata();
                      updateUI(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var searchcity = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },),);
                      if(searchcity != null){
                        var weatherdata = await weatherModel.getcitydata(searchcity);
                        updateUI(weatherdata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temprature}°',
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
                  "${readabledata} in ${city}",
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
