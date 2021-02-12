import 'package:flutter/material.dart';
import 'package:hava_durumu_app/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';

class HavaDurumuResimWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weatherWievModel = Provider.of<WeatherViewModel>(context);
    var havaDurumuKisaltmasi = _weatherWievModel.getirilenWeather.consolidatedWeather[0].weatherStateAbbr;
    return Column(
      children: [
        Text("${_weatherWievModel.getirilenWeather.consolidatedWeather[0].theTemp.floor()} C",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),),
        Image.network("https://www.metaweather.com/static/img/weather/png/$havaDurumuKisaltmasi.png",
          height: 150,
          width: 150,
        ),
      ],
    );
  }
}
