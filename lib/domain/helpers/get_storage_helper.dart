import 'package:get_storage/get_storage.dart';

class GetStorageHelper {
  GetStorageHelper() {
    init();
  }

  late GetStorage box;

  Future<void> init() async {
    box = GetStorage();
  }

  void setDarkMode(bool darkMode) {
    box.write('dark_mode', darkMode);
  }

  bool getDarkMode() {
    return box.read('dark_mode') ?? false;
  }

  void setSeen(bool status) {
    box.write('seen', status);
  }

  bool getSeen() {
    return box.read('seen') ?? true;
  }

  Future<void> setLoggedIn(bool status) async {
    box.write('logged_in', status);
  }

  bool getLogedIn() {
    return box.read('logged_in') ?? false;
  }

  Future<void> setUserId(String? userId) async {
    box.write('user_id', userId);
  }

  String? getUserId() {
    return box.read('user_id');
  }

  void deleteUserId() {
    box.remove('user_id');
  }

  Future<void> setToken(String? token) async {
    if (token != null) {
      box.write('token', token);
    }
  }

  void deleteToken() {
    box.remove('token');
  }

  String? getToken() {
    return box.read('user_id');
  }

  Future<void> setNotificationStatus(bool status) async {
    box.write('notification_status', status);
  }

  bool getNotificationStatus() {
    return box.read('notification_status') ?? false;
  }
}
