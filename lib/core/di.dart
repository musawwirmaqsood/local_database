import 'package:get_it/get_it.dart';
import 'package:local_database/database/database_service.dart';
import 'package:local_database/database/user_database_helper.dart';
import 'package:local_database/database/user_database_helper_i.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  getIt.registerSingleton<UserDatabaseHelperI>(
      UserDatabaseHelper(await DatabaseService().init()));
}
