import 'package:contactlist/database/contact_entity.dart';
import 'package:contactlist/database/database.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/contact.dart';

class ContactLocalSource {
  Future<int> count() async {
    final db = MyDatabase.database;
    int count = Sqflite.firstIntValue(await db
            .rawQuery('SELECT COUNT(*) FROM ${ContactEntity.tableName}')) ??
        0;
    return count;
  }

  Future<void> inserts(List<Contact> contacts) async {
    final db = MyDatabase.database;

    Batch batch = db.batch();
    for (Contact contact in contacts) {
      ContactEntity entity = ContactEntity(
        id: contact.id,
        username: contact.username,
        lastName: contact.lastName,
        email: contact.email,
        gender: contact.gender,
        avatar: contact.avatar,
      );

      batch.insert(
        ContactEntity.tableName,
        entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<Contact>> fetch() async {
    final db = MyDatabase.database;

    final List<Map<String, dynamic>> maps =
        await db.query(ContactEntity.tableName);

    List<ContactEntity> list = List.generate(maps.length, (i) {
      return ContactEntity(
        id: maps[i][ContactEntity.idField],
        username: maps[i][ContactEntity.usernameField],
        lastName: maps[i][ContactEntity.lastNameField],
        email: maps[i][ContactEntity.emailField],
        gender: maps[i][ContactEntity.genderField],
        avatar: maps[i][ContactEntity.avatarField],
      );
    });

    return list
        .map<Contact>((contact) => Contact(
              id: contact.id,
              username: contact.username,
              lastName: contact.lastName,
              email: contact.email,
              gender: contact.gender,
              avatar: contact.avatar,
            ))
        .toList();
  }

  Future<void> delete(String id) async {
    final db = MyDatabase.database;

    // Remove the Dog from the database.
    await db.delete(
      ContactEntity.tableName,
      where: '${ContactEntity.idField} = ?',
      whereArgs: [id],
    );
  }
}
