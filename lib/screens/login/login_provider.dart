import 'package:contactlist/models/data_response.dart';
import 'package:flutter/widgets.dart';

import '../../repository/login_repository.dart';

class LoginProvider extends ChangeNotifier {

  bool isLoading = false;

  final LoginRepository _repository;
  LoginProvider(this._repository);

  Future<DataResponse> login({
    required String username,
    required String password,
  }) async {
    setIsLoading(true);
    var response = await _repository.login(username: username, password: password);
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
