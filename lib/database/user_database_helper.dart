import 'package:local_database/core/constants.dart';
import 'package:local_database/database/user_database_helper_i.dart';
import 'package:local_database/models/user.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDatabaseHelper implements UserDatabaseHelperI {
  final Database database;
  UserDatabaseHelper(this.database);

  @override
  Future<User> insertUser(User user) async {
    user.id = await database.insert(UsersTable.tableName, user.toJson());
    return user;
  }

  @override
  Future<User> getUser(int id) async {
    final List<Map<String, dynamic>> queryResponse =
        await database.rawQuery(DatabaseQuery.fetchUserById(id));
    return User.fromJson(queryResponse.first);
  }

  @override
  Future<bool> updateUser(User user) async {
    int success = await database.update(UsersTable.tableName, user.toJson(),
        where: '${UsersTable.id} =?', whereArgs: [user.id]);
    return success == 1;
  }

  @override
  Future<bool> deleteUser(int id) async {
    int deleted = await database.delete(UsersTable.tableName,
        where: '${UsersTable.id} =?', whereArgs: [id]);
    return deleted == 1;
  }

  @override
  Future<List<User>> getUsers() async {
    final queryResponse = await database.rawQuery(DatabaseQuery.fetchUsers);
    return queryResponse.map(User.fromJson).toList();
  }
}
