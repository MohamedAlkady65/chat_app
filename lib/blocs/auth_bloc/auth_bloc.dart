
import 'package:chat_app/blocs/auth_bloc/auth_events.dart';
import 'package:chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
     on<AuthEvent>( (event, emit) async {
      if(event is AuthLoginEvent)
      {
            emit(LoginLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: event.email, password: event.Password);
      emit(LoginSuccessState());

    } on FirebaseAuthException catch (ex) {
      if (ex.code == "wrong-password") {
        emit(LoginFailureState(message: "Password Is Wrong"));
      } else if (ex.code == "user-not-found") {
        emit(LoginFailureState(message: "No User Found For That Email"));
      } else if (ex.code == "invalid-email") {
        emit(LoginFailureState(message: "Please Enter Valid Email"));
      }
    } catch (ex) {
      emit(LoginFailureState(message: "SomeThing Went Wrong"));
    }
      }
    });
  }
}
