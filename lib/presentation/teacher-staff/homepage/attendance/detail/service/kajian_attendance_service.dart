import 'package:dio/dio.dart';
import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/model/kajian_attendance_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KajianAttendanceService {
  final Dio dio;

  KajianAttendanceService({required this.dio});

  Future<bool> postAttendance(KajianAttendanceRequest data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      print('[DEBUG] Token yang dikirim: $token');
      print('[DEBUG] Data payload: ${data.toJson()}');

      final response = await dio.post(
        '/api/kajian-attendances',
        data: data.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('[DEBUG] Response status: ${response.statusCode}');
      print('[DEBUG] Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print('[DIO ERROR] ${e.response?.statusCode} => ${e.response?.data}');
      return false;
    } catch (e) {
      print('[ERROR] Terjadi kesalahan lain: $e');
      return false;
    }
  }
}
