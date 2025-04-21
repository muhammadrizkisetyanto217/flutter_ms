import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/login/service/auth_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthServiceLogin authService;

  LoginCubit(this.authService) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    final result = await authService.login(email, password);

    if (result != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result.token);
      await prefs.setString('user_name', result.user.userName); // tambahin ini
      await prefs.setString('role', result.user.role); // dan ini
      await prefs.setString('user_id', result.user.id); // ✅ tambahkan ini

      emit(LoginSuccess(result.token, result.user.role));
    } else {
      emit(LoginFailure('Login gagal. Periksa email dan password.'));
    }
  }
}
