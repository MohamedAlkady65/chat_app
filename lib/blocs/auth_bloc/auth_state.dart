abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoginSuccessState extends AuthState {}

class LoginFailureState extends AuthState {
  LoginFailureState({required this.message});

  String message;
}

class LoginLoadingState extends AuthState {}


class RegisterSuccessState extends AuthState {}

class RegisterFailureState extends AuthState {
  RegisterFailureState({required this.message});

  String message;
}

class RegisterLoadingState extends AuthState {}