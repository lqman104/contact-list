import 'package:contactlist/database/contact_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static late final Database database;

  Future<void> init() async {
    database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'contact_database.db'),
      onCreate: (db, version) {
        if (version == 1) {
          db.execute(
            '''
              CREATE TABLE ${ContactEntity.tableName}(
                ${ContactEntity.idField} TEXT PRIMARY KEY, 
                ${ContactEntity.usernameField} TEXT, 
                ${ContactEntity.lastNameField} TEXT, 
                ${ContactEntity.avatarField} TEXT, 
                ${ContactEntity.emailField} TEXT, 
                ${ContactEntity.genderField} TEXT
              )
            ''',
          );
        }
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }
}
