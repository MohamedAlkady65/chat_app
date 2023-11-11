abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  AuthLoginEvent({required this.email, required this.Password});
  String email;
  String Password;
}

class ResgisterLoginEvent extends AuthEvent {
  ResgisterLoginEvent({required this.email, required this.Password});
  String email;
  String Password;
}
