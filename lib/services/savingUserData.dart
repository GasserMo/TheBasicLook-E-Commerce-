import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  saveData(
      {required String token,
      required String role,
      required String userId}) async {
    await GetStorage().write('token', token);
    await GetStorage().write('role', role);
    await GetStorage().write('userId', userId);
  }
}
