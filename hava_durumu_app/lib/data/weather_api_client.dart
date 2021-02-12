import 'dart:convert';

import 'package:hava_durumu_app/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApiClient{

  static const String baseUrl = "https://www.metaweather.com";
  final http.Client httpClient = http.Client();
  Future<int> getLocationId(String sehirAdi) async{

    final String sehirUrl = baseUrl+"/api//location/search/?query="+sehirAdi;
   final gelenCevap = await httpClient.get(sehirUrl);

   if(gelenCevap.statusCode != 200){
     throw Exception("Veri Getirilemedi");
   }

   final gelenCevapJSON = (json.decode(gelenCevap.body)) as List;
   return gelenCevapJSON[0]['woeid'];
  }

  Future<Weather> getWeather ( int sehirId) async{

    final havaDurumuUrl = baseUrl+"/api/location/$sehirId";
    final havaDurumuGelenCevap = await httpClient.get(havaDurumuUrl);

    if(havaDurumuGelenCevap.statusCode != 200){
      throw Exception("Veri Getirilemedi");
    }

    final havaDurumuGelenCevabinJSON = json.decode(havaDurumuGelenCevap.body);

    return Weather.fromJson(havaDurumuGelenCevabinJSON);



  }




}