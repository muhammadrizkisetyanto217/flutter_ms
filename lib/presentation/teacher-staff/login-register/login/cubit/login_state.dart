abstract class LoginState {}

//Step-step disini apa aja

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final String role;

  LoginSuccess(this.token, this.role);
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
