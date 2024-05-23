import '../../data/models/collection.dart';
import '../../data/models/user_object.dart';

abstract class BaseServices {
  Future<int> getExample();
  Future<UserObject?> getUser();
  Future<List<CollectionObject>> getCollections({String? languageCode});
}
