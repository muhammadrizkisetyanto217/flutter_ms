import 'package:dio/dio.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/login/model/model_response.dart';

class AuthServiceLogin {
  static const String _baseUrl =
      'https://arabiya-syari-fiber-production.up.railway.app'; // ✅ Simpan URL di sini

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {"identifier": email, "password": password},
      );
      return LoginResponse.fromJson(response.data); // ✅ pakai model
    } catch (e) {
      print("❌ Error login: $e");
      return null;
    }
  }
}
