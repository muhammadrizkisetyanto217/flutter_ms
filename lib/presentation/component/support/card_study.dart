import 'package:flutter/material.dart';
import 'package:flutter_ppkd/catatan-ppkd/data/section_list.dart';

class CardStudy extends StatelessWidget {
  final int index; // ✅ Tambahkan parameter index
  const CardStudy(
      {super.key, required this.index}); // ✅ Tambahkan required index
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Text(
        sectionQuizzesList[index].title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
