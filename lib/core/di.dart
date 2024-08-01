import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_database/core/constants.dart';
import 'package:local_database/database/database_service.dart';
import 'package:local_database/database/user_database_helper.dart';
import 'package:local_database/database/user_database_helper_i.dart';
import 'package:local_database/database/user_hive_database_helper.dart';

bool setupHiveDatabase = true;

final getIt = GetIt.instance;

Future<void> setupDI() async {
  if (setupHiveDatabase) {
    getIt.registerSingleton<UserDatabaseHelperI>(UserHiveDatabaseHelper(
        userBox:
            await Hive.openBox<Map<String, dynamic>>(HiveConstants.userBox),
        idBox: await Hive.openBox<int>(HiveConstants.idBox)));
  } else {
    getIt.registerSingleton<UserDatabaseHelperI>(
        UserDatabaseHelper(await DatabaseService().init()));
  }
}
