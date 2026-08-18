import 'package:trip_planner/entities/entity_user.dart';
import 'package:trip_planner/modules/auth/auth_spec.dart';

AuthUseCase newAuthUseCase(AuthRepository authRepository) {
  return _AuthUseCase(authRepository);
}

class _AuthUseCase implements AuthUseCase {
  const _AuthUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<void> attemptLogin(UserCredentials credentials) async {
    return await _authRepository.attemptLogin(credentials);
  }

  @override
  Future<void> attemptRegister(UserCredentials credentials) async {
    return await _authRepository.attemptRegister(credentials);
  }
}
