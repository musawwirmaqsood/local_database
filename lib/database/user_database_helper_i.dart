import 'package:local_database/models/user.dart';

abstract class UserDatabaseHelperI {
  Future<User> insertUser(User user);

  Future<User> getUser(int id);

  Future<bool> updateUser(User user);

  Future<bool> deleteUser(int id);

  Future<List<User>> getUsers();
}
