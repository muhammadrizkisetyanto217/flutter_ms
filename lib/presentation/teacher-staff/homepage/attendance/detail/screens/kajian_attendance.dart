import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/model/kajian_attendance_request.dart';

import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/service/kajian_attendance_service.dart';

import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/cubit/kajian_attendance_cubit.dart';
import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/cubit/kajian_attendance_state.dart';

class MyLocationScreen extends StatefulWidget {
  @override
  _MyLocationScreenState createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  String lokasi = 'Belum didapatkan';
  String koordinat = '';
  String _waktu = '';
  String userId = '';
  LatLng? _currentLatLng;
  GoogleMapController? _mapController;

  final TextEditingController _materiController = TextEditingController();
  final TextEditingController _lainnyaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user_id') ?? '';
    });
  }

  @override
  void dispose() {
    _materiController.dispose();
    _lainnyaController.dispose();
    super.dispose();
  }

  void _kirimAbsensi() {
    if (_currentLatLng == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Lokasi belum didapatkan.')));
      return;
    }

    final request = KajianAttendanceRequest(
      userId: userId,
      latitude: _currentLatLng!.latitude,
      longitude: _currentLatLng!.longitude,
      address: lokasi,
      topic: _materiController.text,
      notes: _lainnyaController.text,
    );

    print('[DEBUG] === Payload yang dikirim ===');
    print(request.toJson());

    context.read<KajianAttendanceCubit>().submitAttendance(request);
  }

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
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 0,
          ),
        );

        koordinat = '${pos.latitude}, ${pos.longitude}';
        _currentLatLng = LatLng(pos.latitude, pos.longitude);

        List<Placemark> placemarks = await placemarkFromCoordinates(
          pos.latitude,
          pos.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          setState(() {
            lokasi =
                '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}\n\nKoordinat: $koordinat';
            _waktu = DateTime.now().toString();
          });

          _mapController?.animateCamera(
            CameraUpdate.newLatLng(_currentLatLng!),
          );
        } else {
          setState(() {
            lokasi = 'Alamat tidak ditemukan.\n\nKoordinat: $koordinat';
          });
        }
      } catch (e) {
        setState(() {
          lokasi = 'Terjadi kesalahan saat mendapatkan lokasi.\nDetail: $e';
        });
      }
    } else {
      setState(() {
        lokasi = 'Tidak dapat mengakses lokasi.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => KajianAttendanceCubit(
            KajianAttendanceService(
              dio: Dio(
                BaseOptions(baseUrl: 'https://url_internal'),
              ), // Ganti baseUrl kamu
            ),
          ),
      child: BlocListener<KajianAttendanceCubit, KajianAttendanceState>(
        listener: (context, state) {
          if (state is KajianAttendanceLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mengirim absensi...')),
            );
          } else if (state is KajianAttendanceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Absensi berhasil dikirim!')),
            );
            context.pop();
          } else if (state is KajianAttendanceFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Gagal: ${state.message}')));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Lacak Lokasi saya'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Lokasi Saat Ini:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(lokasi, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _getLocation,
                    child: const Text('Dapatkan Lokasi'),
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    'Materi Hari Ini',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _materiController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Isi materi kajian atau pelajaran...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Hal Lainnya',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _lainnyaController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Catatan tambahan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Waktu Akses Lokasi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    enabled: false,
                    controller: TextEditingController(text: _waktu),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Waktu akan tampil setelah lokasi didapat',
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: 250,
                    child:
                        _currentLatLng != null
                            ? GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: _currentLatLng!,
                                zoom: 16,
                              ),
                              onMapCreated: (controller) {
                                _mapController = controller;
                              },
                              markers: {
                                Marker(
                                  markerId: const MarkerId('lokasi_saya'),
                                  position: _currentLatLng!,
                                  infoWindow: const InfoWindow(
                                    title: 'Lokasi Anda',
                                  ),
                                ),
                              },
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                            )
                            : const Center(
                              child: Text(
                                'Belum ada lokasi.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: _kirimAbsensi,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Kirim Absensi',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
