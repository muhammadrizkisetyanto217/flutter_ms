import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/model/kajian_attendance_request.dart';

import 'package:flutter_ms/presentation/teacher-staff/homepage/attendance/detail/service/kajian_attendance_service.dart';
import 'kajian_attendance_state.dart';

class KajianAttendanceCubit extends Cubit<KajianAttendanceState> {
  final KajianAttendanceService service;

  KajianAttendanceCubit(this.service) : super(KajianAttendanceInitial());

  Future<void> submitAttendance(KajianAttendanceRequest request) async {
    emit(KajianAttendanceLoading());
    try {
      final success = await service.postAttendance(request);
      if (success) {
        emit(KajianAttendanceSuccess());
      } else {
        emit(KajianAttendanceFailure("Gagal mengirim absensi"));
      }
    } catch (e) {
      emit(KajianAttendanceFailure(e.toString()));
    }
  }
}
