import 'package:flutter/material.dart';
import 'package:hava_durumu_app/locator.dart';
import 'package:hava_durumu_app/viewmodels/mytheme_view_model.dart';
import 'package:hava_durumu_app/viewmodels/weather_view_model.dart';
import 'package:provider/provider.dart';

import 'widget/weather_app.dart';

void main() {

  setupLocator();
  runApp(ChangeNotifierProvider(
      create: (context)=>MyThemeViewModel(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeViewModel>(
      builder: (context,MyThemeViewModel myThemeViewModel,childs)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hava Durumu",
        theme: myThemeViewModel.myTheme.tema,
        home: ChangeNotifierProvider<WeatherViewModel>(
            create: (context)=>locator<WeatherViewModel>(),
            child: WeatherApp(),
        ),
      ),
    );
  }
}

