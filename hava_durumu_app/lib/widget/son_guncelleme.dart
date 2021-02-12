import 'package:flutter/material.dart';
import 'package:hava_durumu_app/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';

class SonGuncellemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final _weatherWievModel = Provider.of<WeatherViewModel>(context);
    var yeniTarih = _weatherWievModel.getirilenWeather.time.toLocal();
    return Text("Son Güncelleme "+ TimeOfDay.fromDateTime(yeniTarih).format(context),
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    );
  }
}
