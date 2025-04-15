import 'package:flutter/material.dart';

class InputUser extends StatefulWidget {
  final TextEditingController? controller;
  final IconData icon; // Ikon dinamis
  final bool obscureText; // Menyembunyikan teks untuk password
  final String? hintText; // ✅ Label dinamis

  const InputUser({
    super.key,
    this.controller,
    this.hintText, // ✅ Bisa null
    required this.icon,
    this.obscureText = false, // Default tidak disembunyikan
  });

  @override
  InputUserState createState() => InputUserState();
}

class InputUserState extends State<InputUser> {
  late bool isObscured;
  late FocusNode _focusNode;
  bool _isFocused = false; // ✅ State untuk mendeteksi apakah input sedang aktif

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
    _focusNode = FocusNode();
    // ✅ Tambahkan listener untuk mendeteksi fokus
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void toggleObscure() {
    setState(() {
      isObscured = !isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        focusNode: _focusNode, // ✅ Tambahkan focus node
        obscureText: isObscured,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText:
              _isFocused ? null : widget.hintText, // ✅ Hilangkan saat diketik
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            widget.icon,
            color: Colors.grey,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: toggleObscure,
                )
              : null, // Jika bukan password, tidak ada suffix icon
        ),
      ),
    );
  }
}
