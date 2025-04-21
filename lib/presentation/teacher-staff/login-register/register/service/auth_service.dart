import 'dart:convert';
import 'package:dio/dio.dart';

class AuthServiceRegister {
  static const String _baseUrl = 'https://quiz-fiber-production.up.railway.app';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {'Content-Type': 'application/json'}, // ✅ penting!
    ),
  );

  Future<Map<String, dynamic>?> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final data = {"user_name": name, "email": email, "password": password};

      print("🚀 Sending register data: $data");

      final response = await _dio.post(
        '/auth/register',
        data: jsonEncode(data), // ✅ harus jsonEncode!
      );

      print("✅ Register success: ${response.data}");
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print("❌ Status: ${e.response?.statusCode}");
        print("📩 Error message: ${e.response?.data}");
      } else {
        print("❌ Dio error: ${e.message}");
      }
      return null;
    }
  }
}
