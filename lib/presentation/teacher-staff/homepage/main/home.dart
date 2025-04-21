import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String role = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    print('🧩 SharedPreferences Keys: $keys');
    print('🪵 user_name: ${prefs.getString('user_name')}');
    print('🪵 role: ${prefs.getString('role')}');

    setState(() {
      userName = prefs.getString('user_name') ?? 'Pengguna';
      role = prefs.getString('role') ?? '-';
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.location_on, 'title': 'Lacak', 'route': '/mylocation'},
      {'icon': Icons.person, 'title': 'Profil', 'route': '/profile'},
      {
        'icon': Icons.settings,
        'title': 'Kehadiran',
        'route': '/home/attendance',
      },
      {'icon': Icons.book, 'title': 'Buku', 'route': '/books'},
      {
        'icon': Icons.notifications,
        'title': 'Notifikasi',
        'route': '/notifications',
      },
      {'icon': Icons.help, 'title': 'Bantuan', 'route': '/help'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assalamualaykum, $userName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Peran: $role',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return InkWell(
                    onTap: () {
                      context.go(item['route']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item['icon'], size: 32.0),
                          const SizedBox(height: 8.0),
                          Text(item['title'], textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
