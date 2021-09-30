import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void getlocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var networkdata = await weatherModel.getlocationdata();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            locationweather: networkdata,
          );
        },
      ),
    );
  }

  void initState() {
    super.initState();
    getlocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitRipple(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}
