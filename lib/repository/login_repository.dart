import 'package:contactlist/models/data_response.dart';
import 'package:contactlist/repository/login_local_source.dart';

import '../models/user.dart';
import 'login_remote_source.dart';

class LoginRepository {
  final LoginLocalSource _localSource;
  final LoginRemoteSource _remoteSource;

  LoginRepository(this._localSource, this._remoteSource);

  Future<DataResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      User user = await _remoteSource.login(
        username: username,
        password: password,
      );
      await _localSource.storeToken(user.token);
      return Success(null);
    } catch (e) {
      return Failed(e.toString());
    }
  }

  Future<bool> isLoggedIn() async {
    return await _localSource.isLogin();
  }
}
