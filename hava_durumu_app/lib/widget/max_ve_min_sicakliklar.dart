import 'package:flutter/material.dart';
import 'package:hava_durumu_app/models/weather.dart';

class  MaxVeMinSicakliklar extends StatelessWidget {

  ConsolidatedWeather bugununDegerleri;
  MaxVeMinSicakliklar(this.bugununDegerleri);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Maksimum: ${bugununDegerleri.maxTemp.floor()} C", style: TextStyle(fontSize: 20),),
        Text("Minimum: ${bugununDegerleri.minTemp.floor()} C", style: TextStyle(fontSize: 20),),
      ],
    );
  }
}
