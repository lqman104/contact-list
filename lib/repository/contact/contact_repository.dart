import 'package:contactlist/models/data_response.dart';

import '../../models/contact.dart';
import 'contact_local_source.dart';
import 'contact_remote_source.dart';

class ContactRepository {
  final ContactLocalSource _localSource;
  final ContactRemoteSource _remoteSource;

  ContactRepository(this._localSource, this._remoteSource);

  Future<DataResponse> fetch(String? query) async {
    try {
      final List<Contact> contacts;
      bool isEmpty = await _localSource.count() == 0;

      if (isEmpty) {
        contacts = await _remoteSource.fetch();
        await _localSource.inserts(contacts);

        return Success(contacts);
      } else {
        contacts = await _localSource.fetch(query);
        return Success(contacts);
      }
    } catch (e) {
      return Failed(e.toString());
    }
  }

  Future<DataResponse> store(Contact contact) async {
    try {
      await _localSource.inserts([contact]);
      return Success(null);
    } catch (e) {
      return Failed(e.toString());
    }
  }
}
