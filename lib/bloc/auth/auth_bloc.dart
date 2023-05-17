import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    FirebaseAuth auth = FirebaseAuth.instance;
    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await auth.signInWithEmailAndPassword(
            email: event.email!, password: event.password!);
        emit(AuthStateLogin());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(message: e.message!));
      } catch (e) {
        emit(AuthStateError(message: e.toString()));
      }
    });
    on<AuthEventLogout>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await auth.signOut();
        emit(AuthStateLogout());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(message: e.message!));
      } catch (e) {
        emit(AuthStateError(message: e.toString()));
      }
    });
  }
}
