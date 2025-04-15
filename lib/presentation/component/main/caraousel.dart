// ✅ Widget CustomCarouselSlider
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> images; // 📌 List gambar carousel
  final List<String> ids; // 📌 List ID halaman untuk navigasi
  final bool autoSlide; // 📌 Aktifkan/Nonaktifkan auto-slide
  final bool infiniteScroll; // 📌 Aktifkan/Nonaktifkan looping carousel
  final Duration slideDuration; // 📌 Interval waktu antar-slide

  const CustomCarouselSlider({
    super.key,
    required this.images,
    required this.ids,
    this.autoSlide = true,
    this.infiniteScroll = true,
    this.slideDuration = const Duration(seconds: 10),
  });

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  late final PageController
      _pageController; // 📌 Controller untuk slide carousel
  int _currentIndex = 0; // 📌 Indeks gambar yang sedang aktif
  Timer? _timer; // 📌 Timer untuk auto-slide

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.infiniteScroll ? 1000 : 0);
    if (widget.autoSlide) {
      _startAutoSlide();
    }
  }

  // 📌 Fungsi untuk menjalankan auto-slide
  void _startAutoSlide() {
    _timer = Timer.periodic(widget.slideDuration, (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 📌 Matikan timer saat widget dihapus
    _pageController
        .dispose(); // 📌 Dispose controller untuk menghindari memory leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.infiniteScroll ? null : widget.images.length,
            onPageChanged: (index) => setState(() {
              _currentIndex = index % widget.images.length;
            }),
            itemBuilder: (context, index) => CarouselImage(
              url: widget.images[index % widget.images.length],
              id: widget.ids[index % widget.ids.length],
            ),
          ),
        ),
        const SizedBox(height: 10),
        CarouselIndicator(
          currentIndex: _currentIndex,
          itemCount: widget.images.length,
          controller: _pageController,
        ),
      ],
    );
  }
}

// ✅ Widget indikator posisi gambar carousel
class CarouselIndicator extends StatelessWidget {
  final int currentIndex; // 📌 Indeks gambar aktif
  final int itemCount; // 📌 Jumlah total gambar
  final PageController controller; // 📌 Controller untuk perpindahan slide

  const CarouselIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return GestureDetector(
          onTap: () => controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: currentIndex == index ? 16 : 8,
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: currentIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}

// ✅ Widget gambar carousel dengan navigasi
class CarouselImage extends StatelessWidget {
  final String url; // 📌 URL gambar
  final String id; // 📌 ID halaman navigasi

  const CarouselImage({super.key, required this.url, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push('/$id'), // 📌 Navigasi ke halaman berdasarkan ID
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
      ),
    );
  }
}
