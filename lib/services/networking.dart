import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper{

  NetworkHelper(this.url);
  final String url;
  Future get_weather() async {
    Response request = await get(Uri.parse(url));
    if (request.statusCode == 200){
      String data = request.body;
      return(jsonDecode(data));


    }
    else{
      print(request.statusCode);
    }
  }
}