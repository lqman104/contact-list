import 'package:contactlist/models/data_response.dart';
import 'package:flutter/widgets.dart';

import '../../repository/login_repository.dart';

class LoginProvider extends ChangeNotifier {

  final LoginRepository _repository;
  LoginProvider(this._repository);

  Future<DataResponse> login({
    required String username,
    required String password,
  }) async {
    return await _repository.login(username: username, password: password);
  }
}
