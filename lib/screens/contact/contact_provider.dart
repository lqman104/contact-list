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
  String username = "";
  String lastName = "";
  String _gender = "male";
  String email = "";

  ContactProvider(this._repository);

  Future<DataResponse> fetch() async {
    return await _repository.fetch(query);
  }

  void resetForm() {
    photoPath = "";
    username = "";
    lastName = "";
    _gender = "male";
    email = "";
  }

  void setPhotoPath(String path) {
    photoPath = path;
    notifyListeners();
  }

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  String get gender => _gender;

  void refresh() {
    notifyListeners();
  }

  void search(String query) {
    this.query = query;
    notifyListeners();
  }

  Future<DataResponse> save() async {
    if (photoPath.isEmpty) {
      return Failed("Photo can't be empty");
    }

    if (username.isEmpty) {
      return Failed("Username can't be empty");
    }

    if (lastName.isEmpty) {
      return Failed("Last name can't be empty");
    }

    if (_gender.isEmpty) {
      return Failed("Gender can't be empty");
    }

    if (email.isEmpty) {
      return Failed("Email can't be empty");
    }

    if (!isValidEmail(email)) {
      return Failed("Format email not valid");
    }

    const Uuid uuid = Uuid();
    Contact contact = Contact(
      id: uuid.v1(),
      username: username,
      lastName: lastName,
      email: email,
      gender: _gender,
      avatar: photoPath,
    );

    _setIsLoading(true);
    var response = await _repository.store(contact);
    resetForm();
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

  bool isValidEmail(String email) {
    return RegExp(
            "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
        .hasMatch(email);
  }
}
