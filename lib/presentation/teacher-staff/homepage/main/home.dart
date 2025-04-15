import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_ms/core/themes/theme-cubit.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data untuk icon dan title
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.location_on,
        'title': 'Lacak Lokasi',
        'route': '/mylocation',
      },
      {'icon': Icons.person, 'title': 'Profil', 'route': '/profile'},
      {'icon': Icons.settings, 'title': 'Absensi', 'route': '/absence'},
      {'icon': Icons.book, 'title': 'Buku', 'route': '/books'},
      {
        'icon': Icons.notifications,
        'title': 'Notifikasi',
        'route': '/notifications',
      },
      {'icon': Icons.help, 'title': 'Bantuan', 'route': '/help'},
      // Tambahkan lagi jika perlu
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Pengajar')),
      body: GridView.builder(
        itemCount: menuItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item['icon'], size: 36, color: Color(0xff0E592C)),
                const SizedBox(height: 10),
                Text(
                  item['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
