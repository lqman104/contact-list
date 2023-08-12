import 'package:contactlist/models/data_response.dart';
import 'package:flutter/widgets.dart';

import '../../repository/login/login_repository.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;

  final LoginRepository _repository;

  LoginProvider(this._repository);

  Future<DataResponse> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty) {
      return Failed("Username can't be empty");
    }

    if (password.isEmpty) {
      return Failed("Password can't be empty");
    }

    setIsLoading(true);
    var response =
        await _repository.login(username: username, password: password);
    setIsLoading(false);
    return response;
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    return await _repository.isLoggedIn();
  }
}
