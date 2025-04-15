import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ms/providers/theme_provider.dart';

class AppBarQuiz extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final String? imagePath;
  final bool
      showBackButton; // Agar bisa diatur apakah ada tombol back atau tidak
  final double bottomMargin; // Tambahan margin bawah AppBar

  const AppBarQuiz({
    super.key,
    this.titleText,
    this.imagePath,
    this.showBackButton = true, // Default ada tombol back
    this.bottomMargin = 10.0, // Default margin bawah 10px
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
        final iconColor = isDarkMode ? Colors.white : Colors.black;

        return Column(
          mainAxisSize: MainAxisSize.min, // Tidak mengambil seluruh layar
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: isDarkMode ? Colors.black : Colors.white,
              titleSpacing: 0,
              leading: showBackButton
                  ? Transform.translate(
                      offset: const Offset(-10, 0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: iconColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                    )
                  : null, // Tidak tampil jika `showBackButton` = false
              title: Row(
                children: [
                  if (imagePath != null) // Jika ada gambar, tampilkan
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(imagePath!, height: 30),
                    ),
                  if (titleText !=
                      null) // Jika titleText diberikan, tampilkan teks
                    Text(
                      titleText!,
                      style: TextStyle(
                        fontSize: 24,
                        color: iconColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
              actions: [
                Transform.translate(
                  offset: const Offset(20, 0),
                  child: PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: iconColor),
                    offset: const Offset(-10, 50),
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'settings',
                        child: Text('Pengaturan'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'menu',
                        child: Text('Menu'),
                      ),
                      // PopupMenuItem<String>(
                      //   value: 'theme',
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       const Text('Tema'),
                      //       StatefulBuilder(
                      //         builder: (context, setState) {
                      //           return Switch(
                      //             value:
                      //                 themeProvider.themeMode == ThemeMode.dark,
                      //             onChanged: (value) {
                      //               themeProvider.toggleTheme();
                      //               setState(() {}); // Perbarui tampilan Switch
                      //             },
                      //           );
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: bottomMargin), // Tambahkan margin bawah AppBar
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
