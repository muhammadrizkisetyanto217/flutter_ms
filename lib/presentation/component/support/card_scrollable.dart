import 'package:flutter/material.dart';
import 'package:flutter_ppkd/core/constants/app_color.dart';
import 'package:flutter_ppkd/providers/theme_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final String program;
  final String route;
  final String description;
  final String dateRegister;
  final String? createdAt; // ✅ Buat nullable (opsional)

  const CardItem({
    super.key,
    required this.program,
    required this.route,
    required this.description,
    required this.dateRegister,
    this.createdAt, // ✅ Tidak wajib diisi
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: () => context.push(route),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: themeProvider.themeMode == ThemeMode.light
                  ? AppColors.light.secondary
                  : AppColors.dark.secondary,
              width: 1,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),

              // ✅ **Judul Program**
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      program,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.themeMode == ThemeMode.light
                            ? AppColors.light.primary
                            : AppColors.dark.primary,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // ✅ **Tampilkan `createdAt` hanya jika tidak null**
                  if (createdAt != null) ...[
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: themeProvider.themeMode == ThemeMode.light
                          ? AppColors.light.primary
                          : AppColors.dark.primary,
                    ),
                    const SizedBox(width: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        createdAt!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ] else
                    const SizedBox
                        .shrink(), // ✅ Jika `createdAt` null, sembunyikan
                ],
              ),
              const SizedBox(height: 8),

              // ✅ **Deskripsi**
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // ✅ **Tanggal Pendaftaran**
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    size: 16,
                    color: themeProvider.themeMode == ThemeMode.light
                        ? AppColors.light.primary
                        : AppColors.dark.primary,
                  ),
                  const SizedBox(width: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dateRegister,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
