import '../../data/models/collection.dart';
import '../../data/models/user_object.dart';
import '../../data/repositories/api.dart';
import 'base_services.dart';

class DatabaseServices implements BaseServices {
  factory DatabaseServices() => _instance;
  DatabaseServices._internal();
  static final DatabaseServices _instance = DatabaseServices._internal();
  BaseServices api = API();

  @override
  Future<int> getExample() {
    return api.getExample();
  }

  @override
  Future<UserObject?> getUser() async {
    return api.getUser();
  }

  @override
  Future<List<CollectionObject>> getCollections({String? languageCode}) async {
    return api.getCollections(languageCode: languageCode);
  }
}
