import 'package:get/get.dart';

class ExampleController extends GetxController {
  final RxList<int> _exampleList = RxList<int>();
  List<int> get getUserCoins => _exampleList;

  @override
  Future<void> onInit() async {
    ever(_exampleList, _handleExampleUpdate);

    super.onInit();
  }

  void _handleExampleUpdate(List<int> callback) {
    if (callback.isNotEmpty) {
      _exampleList.value = callback;
    }
  }
}
