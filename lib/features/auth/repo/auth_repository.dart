import '../../../service/local_storage/local_storage_service.dart';

class AuthRepository {
  final TokenStorageService _tokenStorage;

  AuthRepository(this._tokenStorage);

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email/Password");
    }

    await _tokenStorage.saveToken("dummy_auth_token_12345");
  }
}
