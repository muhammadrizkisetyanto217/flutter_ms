import 'package:flutter/material.dart';
import 'package:flutter_ms/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final String? imagePath;
  final double? height;
  final bool? backArrow;
  final EdgeInsetsGeometry? padding;

  const CustomAppBar({
    super.key,
    this.titleText,
    this.imagePath,
    this.height,
    this.backArrow,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return PreferredSize(
      preferredSize: Size.fromHeight(height ?? kToolbarHeight),
      child: Container(
        color: isDarkMode ? Colors.black : Colors.white, // Warna latar belakang
        child: Padding(
          padding: padding ??
              EdgeInsets.only(
                left: (backArrow ?? false) ? 0 : 12,
                right: 0,
              ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: backArrow ?? false,
            titleSpacing: 0,
            centerTitle: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (titleText != null)
                  Text(
                    titleText!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                Row(
                  children: [
                    // 🔥 Popup Menu
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.more_vert,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      offset: const Offset(0, 50),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'theme',
                          onTap: () {
                            // 🔥 Panggil toggleTheme saat item diklik
                            themeProvider.toggleTheme();
                          },
                          child: Row(
                            children: [
                              Icon(
                                isDarkMode
                                    ? Icons.dark_mode
                                    : Icons
                                        .light_mode, // 🔥 Ikon berubah sesuai mode
                                color: isDarkMode
                                    ? Colors.yellow
                                    : Colors
                                        .black, // 🔥 Warna ikon mengikuti mode
                              ),
                              const SizedBox(
                                  width: 8), // 🔥 Jarak antara ikon dan teks
                              Text(isDarkMode
                                  ? 'Mode Gelap'
                                  : 'Mode Terang'), // 🔥 Teks mengikuti mode
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'settings',
                          child: Text('Pengaturan'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'menu',
                          child: Text('Menu'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}
