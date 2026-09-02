//this is comment==============================
//login_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: "Email/Password can't be empty",
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    try {
      await _authRepository.login(email, password);

      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString().replaceAll("Exception: ", ""),
        ),
      );
    }
  }
}
