import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HaritaSayfa extends StatefulWidget {
  const HaritaSayfa({super.key});

  @override
  State<HaritaSayfa> createState() => _HaritaSayfaState();
}

class _HaritaSayfaState extends State<HaritaSayfa> {
  Completer<GoogleMapController> haritaKontrol=Completer();

  //36.9973011,35.1232562,11z
  var baslangicKonum=const CameraPosition(target: LatLng(36.9973011, 35.1232562),zoom: 11);

  List<Marker> isaretler=<Marker>[];

  Future<void> konumaGit() async{
    GoogleMapController controller=await haritaKontrol.future;
   //41.0370013,28.974792,15z
    var gidilecekKonum=const CameraPosition(target: LatLng(41.0370013, 28.974792),zoom: 15);
    controller.animateCamera(CameraUpdate.newCameraPosition(gidilecekKonum));

    var gidilecekIsaret=const Marker(
      markerId: MarkerId("id"),
      position: LatLng(41.0370013, 28.974792),
      infoWindow: InfoWindow(title: "Taksim",snippet: "Taksim Meydan"),


    );
    setState(() {
      isaretler.add(gidilecekIsaret);
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Harita Kullanımı"),),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 300,height: 300,
              child: GoogleMap(
                  initialCameraPosition: baslangicKonum,
                mapType: MapType.normal,
                markers: Set<Marker>.of(isaretler),
                onMapCreated: (GoogleMapController controller){
                    haritaKontrol.complete(controller);
                },

              ),
            ),

            ElevatedButton(onPressed: (){
              konumaGit();


            }, child: const Text("Konuma Git")),

          ],
        ),
      ),
    );
  }
}
