import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_database/core/constants.dart';
import 'package:local_database/database/user_database_helper_i.dart';
import 'package:local_database/models/user.dart';

class UserHiveDatabaseHelper implements UserDatabaseHelperI {
  final Box<Map<String, dynamic>> userBox;
  final Box<int> idBox;

  UserHiveDatabaseHelper({required this.userBox, required this.idBox});

  @override
  Future<bool> deleteUser(int id) async {
    try {
      await userBox.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<User> getUser(int id) async {
    return User.fromJson(userBox.get(id)!);
  }

  @override
  Future<List<User>> getUsers() async {
    return userBox.values.map(User.fromJson).toList();
  }

  @override
  Future<User> insertUser(User user) async {
    int id = idBox.get(HiveConstants.currentId, defaultValue: 0) ?? 0;
    id++;
    user.id = id;
    await userBox.put(user.id, user.toJson());
    await idBox.put(HiveConstants.currentId, id);
    return user;
  }

  @override
  Future<bool> updateUser(User user) async {
    try {
      await userBox.put(user.id, user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
