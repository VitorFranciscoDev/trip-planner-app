import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trip_planner/entities/entity_user.dart';
import 'package:trip_planner/modules/app_user/app_user_spec.dart';

AppUserRepository newAppUserRepository(FlutterSecureStorage storage) {
  return _AppUserRepository(storage);
}

class _AppUserRepository implements AppUserRepository {
  const _AppUserRepository(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<AppUser?> getUserInformation() async {
    final user = await _storage.read(key: 'app_user');
    if (user == null) {
      return null;
    }

    return AppUser.fromJSON(jsonDecode(user));
  }
}
