import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hava_durumu_app/viewmodels/mytheme_view_model.dart';
import 'package:hava_durumu_app/viewmodels/weather_view_model.dart';
import 'package:hava_durumu_app/widget/gecisli_arkaplan_widget.dart';
import 'package:hava_durumu_app/widget/sehir_sec.dart';
import 'package:provider/provider.dart';
import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_ve_min_sicakliklar.dart';
import 'son_guncelleme.dart';

class WeatherApp extends StatelessWidget {
  String kullanicininGirdigisehir = "Ankara";
  WeatherViewModel _weatherViewModel;


  @override
  Widget build(BuildContext context) {
    _weatherViewModel= Provider.of<WeatherViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Hava Durumu"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () async{
            kullanicininGirdigisehir = await Navigator.push(context, MaterialPageRoute(builder: (context)=>SehirSecWidget()));
            debugPrint(kullanicininGirdigisehir);
            _weatherViewModel.havaDurumunuGetir(kullanicininGirdigisehir);

          })
        ],
      ),
      body: Center(

         child: (_weatherViewModel.state == WeatherState.WeatherLoadedState) ? HavaDurumuGeldi():
         (_weatherViewModel.state == WeatherState.WeatherLoadingState) ? havaDurumuGetiriliyor() :
         (_weatherViewModel.state == WeatherState.WeatherErrorState) ?  havaDurumuGetirHata():
         Text("Şehir Seçiniz"),

      ),
    );
  }




  havaDurumuGetiriliyor() {
    return CircularProgressIndicator();
  }

  havaDurumuGetirHata() {
    return Text('Hava Durumu Getirilirken Hata Oluştu...');
  }
}

class HavaDurumuGeldi extends StatefulWidget {
  @override
  _HavaDurumuGeldiState createState() => _HavaDurumuGeldiState();
}

class _HavaDurumuGeldiState extends State<HavaDurumuGeldi> {
  WeatherViewModel _weatherViewModel;
  Completer<void> _refreshIndicator;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshIndicator = Completer<void>();
    debugPrint("init state tetiklendi");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var kisaltma =
      Provider.of<WeatherViewModel>(context, listen: false).havaDurumuKisaltmasi();
      debugPrint("kısaltma: $kisaltma");
      Provider.of<MyThemeViewModel>(context, listen: false).temaDegistir(kisaltma);
    });
  }

  @override
  Widget build(BuildContext context) {

    debugPrint("widget build tetiklendi");

    _refreshIndicator.complete();
    _refreshIndicator = Completer<void>();

    _weatherViewModel = Provider.of<WeatherViewModel>(context);

    String kullanicininSectigiSehir = _weatherViewModel.getirilenWeather.title;
    return  GecisliRenkContainer(
      renk: Provider.of<MyThemeViewModel>(context).myTheme.renk,
      child: RefreshIndicator(
        onRefresh: (){
          _weatherViewModel.havaDurumunuGuncelle(kullanicininSectigiSehir);
          return _refreshIndicator.future;
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: LocationWidget(secilenSehir: kullanicininSectigiSehir)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: SonGuncellemeWidget()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: HavaDurumuResimWidget()),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: MaxVeMinSicakliklar(_weatherViewModel.getirilenWeather.consolidatedWeather[0])),
            ),
          ],
        ),
      ),
    );
  }
}

