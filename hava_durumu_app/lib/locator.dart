import 'package:get_it/get_it.dart';
import 'package:hava_durumu_app/viewmodels/weather_view_model.dart';


import 'data/weather_api_client.dart';
import 'data/weather_repository.dart';


GetIt locator = GetIt.instance;

void setupLocator(){

  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
  locator.registerFactory(() => WeatherViewModel());


}