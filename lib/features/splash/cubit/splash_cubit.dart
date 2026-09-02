//this is comment==============================
//splash_cubit.dart (updated)
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../service/local_storage/local_storage_service.dart';
import 'splash_state.dart';


class SplashCubit extends Cubit<SplashState> {

  final TokenStorageService _tokenStorage;

  SplashCubit(this._tokenStorage) : super(const SplashState());

  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));


    final String? token = await _tokenStorage.getToken();

    if (token != null && token.isNotEmpty) {
      emit(state.copyWith(status: SplashStatus.authenticated));
    } else {
      emit(state.copyWith(status: SplashStatus.unauthorized));
    }


  }
}