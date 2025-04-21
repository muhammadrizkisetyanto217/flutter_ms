abstract class KajianAttendanceState {}

class KajianAttendanceInitial extends KajianAttendanceState {}

class KajianAttendanceLoading extends KajianAttendanceState {}

class KajianAttendanceSuccess extends KajianAttendanceState {}

class KajianAttendanceFailure extends KajianAttendanceState {
  final String message;
  KajianAttendanceFailure(this.message);
}
