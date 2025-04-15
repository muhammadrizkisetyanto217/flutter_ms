import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ms/presentation/teacher-staff/login-register/register/service/auth_service.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthServiceRegister authService;

  RegisterCubit(this.authService) : super(RegisterInitial());

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoading());

    final result = await authService.register(name, email, password);

    if (result != null &&
        (result['message']?.toString().toLowerCase().contains('success') ??
            false)) {
      emit(RegisterSuccess());
    } else {
      final msg = result?['message'] ?? 'Registrasi gagal.';
      emit(RegisterFailure(msg));
    }
  }
}