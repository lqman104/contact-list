import 'package:contactlist/models/data_response.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../../models/contact.dart';
import '../../repository/contact/contact_repository.dart';

class ContactProvider extends ChangeNotifier {
  final ContactRepository _repository;
  bool isLoading = false;
  String? query;
  String photoPath = "";

  ContactProvider(this._repository);

  Future<DataResponse> fetch() async {
    return await _repository.fetch(query);
  }

  setPhotoPath(String path) {
    photoPath = path;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  void search(String query) {
    this.query = query;
    notifyListeners();
  }

  Future<DataResponse> save({
    required String username,
    required String lastName,
    required String gender,
    required String email,
  }) async {
    if (username.isEmpty) {
      return Failed("Username can't be empty");
    }

    if (lastName.isEmpty) {
      return Failed("Last name can't be empty");
    }

    if (gender.isEmpty) {
      return Failed("Gender can't be empty");
    }

    if (email.isEmpty) {
      return Failed("Email can't be empty");
    }

    if (photoPath.isEmpty) {
      return Failed("Photo can't be empty");
    }

    const Uuid uuid = Uuid();
    Contact contact = Contact(
        id: uuid.v1(),
        username: username,
        lastName: lastName,
        email: email,
        gender: gender,
        avatar: photoPath,
    );

    _setIsLoading(true);
    var response = await _repository.store(contact);
    photoPath = "";
    _setIsLoading(false);
    return response;
  }

  void _setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<DataResponse> delete(String id) async {
    _setIsLoading(true);
    var response = await _repository.delete(id);
    _setIsLoading(false);
    return response;
  }
}
