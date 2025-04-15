import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class MyLocationPage extends StatefulWidget {
  @override
  _MyLocationPageState createState() => _MyLocationPageState();
}

class _MyLocationPageState extends State<MyLocationPage> {
  String lokasi = 'Belum didapatkan';
  String koordinat = '';

  Future<void> _getLocation() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      try {
        bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!isServiceEnabled) {
          setState(() {
            lokasi = 'Layanan lokasi tidak aktif. Silakan aktifkan GPS.';
          });
          return;
        }

        Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        koordinat = '${pos.latitude}, ${pos.longitude}';

        List<Placemark> placemarks = await placemarkFromCoordinates(
          pos.latitude,
          pos.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          setState(() {
            lokasi =
                '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}\n\nKoordinat: $koordinat';
          });
        } else {
          setState(() {
            lokasi = 'Alamat tidak ditemukan.\n\nKoordinat: $koordinat';
          });
        }
      } catch (e) {
        print('[ERROR] Gagal mendapatkan lokasi: $e');
        setState(() {
          lokasi = 'Terjadi kesalahan saat mendapatkan lokasi.\nDetail: $e';
        });
      }
    } else if (status.isDenied) {
      setState(() {
        lokasi = 'Izin lokasi ditolak. Aktifkan izin di pengaturan aplikasi.';
      });
    } else if (status.isPermanentlyDenied) {
      setState(() {
        lokasi =
            'Izin lokasi ditolak permanen. Buka pengaturan aplikasi untuk mengaktifkan izin.';
      });
    } else {
      setState(() {
        lokasi = 'Tidak dapat mengakses lokasi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lacak Lokasi')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Lokasi Saat Ini:'),
              SizedBox(height: 10),
              Text(
                lokasi,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _getLocation,
                child: Text('Dapatkan Lokasi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
