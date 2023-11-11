import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<UserCredential?> login(
      {required String email, required String password}) async {
    emit(LoginLoadingState());

    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessState());

      return user;
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
    return null;
  }

  Future<UserCredential?> Register(
      {required String email, required String password}) async {
    emit(RegisterLoadingState());

    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccessState());

      return user;
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "weak-password") {
        emit(RegisterFailureState(message: "Password Is Too Weak"));
      } else if (ex.code == "email-already-in-use") {
        emit(RegisterFailureState(message: "Email Is Already Used"));
      } else if (ex.code == "invalid-email") {
        emit(RegisterFailureState(message: "Please Enter Valid Email"));
      }
    } catch (ex) {
      emit(RegisterFailureState(message: "SomeThing Went Wrong"));
    }
    return null;
  }
}
