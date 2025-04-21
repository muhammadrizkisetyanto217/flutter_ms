import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

class AbsensiScreen extends StatefulWidget {
  const AbsensiScreen({super.key});

  @override
  State<AbsensiScreen> createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Simulasi data dari API
  final List<Map<String, String>> absensiList = [
    {"week": "Pekan ke-1", "meet": "Pertemuan ke-1", "subject": "Qiroah"},
    {"week": "Pekan ke-1", "meet": "Pertemuan ke-2", "subject": "Tajwid"},
    {"week": "Pekan ke-2", "meet": "Pertemuan ke-3", "subject": "Fiqih"},
  ];

  // Tambahkan ini dalam class State (misal _MyPageState)
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Kalau pakai API, di sini bisa panggil fetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTerbaruTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: absensiList.length,
      itemBuilder: (context, index) {
        final info = absensiList[index];
        return GestureDetector(
          onTap: () {
            context.go('/home/attendance/mylocation');
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          info['week']!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(info['meet']!, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(info['subject']!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // aksi
                        },
                        icon: const Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Kehadiran",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          minimumSize: const Size(
                            0,
                            32,
                          ), // <— kontrol tinggi minimum
                          tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap, // hilangkan padding default
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          // aksi
                        },
                        icon: const Icon(
                          Icons.description,
                          size: 16,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Laporan",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          minimumSize: const Size(0, 32),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTanggalTab() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: ElevatedButton.icon(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _focusedDay,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                setState(() {
                  _focusedDay = picked;
                  _selectedDay = picked;
                });
              }
            },
            icon: Icon(Icons.calendar_today, size: 18),
            label: Text("Pilih Tanggal"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(); // 👈 kembali ke halaman sebelumnya (GoRouter)
          },
        ),
        title: const Text('Absensi Guru'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: 'Terbaru'), Tab(text: 'Tanggal')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildTerbaruTab(), _buildTanggalTab()],
      ),
    );
  }
}
