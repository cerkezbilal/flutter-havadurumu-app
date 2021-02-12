import 'package:hava_durumu_app/data/weather_api_client.dart';
import 'package:hava_durumu_app/locator.dart';
import 'package:hava_durumu_app/models/weather.dart';

class WeatherRepository{

  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();
  Future<Weather> getWeather(String sehir) async {



    final int sehirID = await weatherApiClient.getLocationId(sehir);

    return await weatherApiClient.getWeather(sehirID);

  }

}