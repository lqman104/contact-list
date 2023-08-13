import 'package:contactlist/models/data_response.dart';
import 'package:contactlist/repository/contact/contact_repository.dart';
import 'package:flutter/widgets.dart';

import '../../repository/login/login_repository.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;

  final LoginRepository _repository;
  final ContactRepository _contactRepository;

  LoginProvider(this._repository, this._contactRepository);

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

  Future<DataResponse> logout() async {
    setIsLoading(true);
    var response =
    await _repository.logout();
    await _contactRepository.clear();
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
