import 'package:contactlist/models/data_response.dart';
import 'package:contactlist/repository/user/user_local_source.dart';

import '../../models/contact.dart';
import 'user_remote_source.dart';

class ContactRepository {
  final ContactLocalSource _localSource;
  final ContactRemoteSource _remoteSource;

  ContactRepository(this._localSource, this._remoteSource);

  Future<DataResponse> fetch() async {
    try {
      List<Contact> contacts = await _remoteSource.fetch();
      return Success(contacts);
    } catch (e) {
      return Failed(e.toString());
    }
  }
}
