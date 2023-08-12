import 'package:contactlist/models/data_response.dart';
import 'package:contactlist/repository/user/user_repository.dart';
import 'package:flutter/widgets.dart';

class ContactProvider extends ChangeNotifier {
  bool isLoading = false;

  final ContactRepository _repository;

  ContactProvider(this._repository);

  Future<DataResponse> fetch() async {
    _setIsLoading(true);
    var response = await _repository.fetch();
    _setIsLoading(false);
    return response;
  }

  Future<DataResponse> test() async {
    return _repository.fetch();
  }

  void _setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
