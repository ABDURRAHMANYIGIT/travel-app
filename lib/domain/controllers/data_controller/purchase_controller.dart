import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../data/enums/product_type_enum.dart';
import '../../../presentation/global_components/message_dialog.dart';
import '../../../resources/i18n/app_sentences.dart';
import '../../utils/purchase_util.dart';

class PurchaseController extends GetxController {
  // final UserController _userController = Get.find();

  Rxn<List<Package>> packages = Rxn<List<Package>>(<Package>[]);
  Rxn<List<StoreProduct>> products = Rxn<List<StoreProduct>>(<StoreProduct>[]);
  List<Package> get getPackages => packages.value!;

  Package? get getProduct1 => getPackages.firstWhereOrNull((Package element) =>
      element.identifier == ProductType.product1.identifier);
  Package? get getProduct2 => getPackages.firstWhereOrNull((Package element) =>
      element.identifier == ProductType.product2.identifier);

  bool get isLoading => loading.value;
  RxBool loading = RxBool(false);
  RxBool initCheck = RxBool(false);

  @override
  Future<void> onInit() async {
    // TODO(ALL): UNCOMMENT FOLLOWING LINES AFTER ADDING STORE IDs
    //await PurchaseHelper().initPurchase();
    //packages.value = await PurchaseHelper().getPackages();
    // ever(_userController.userId, _handleAuthChange);

    super.onInit();
  }

  // Future<void> _handleAuthChange(String? userId) async {
  //   if (userId != null) {
  //     await checkUserProduct();
  //   }
  // }

  Future<void> checkUserProduct() async {
    loading.value = true;
    packages.value = await PurchaseHelper().loadProducts();

    initCheck.value = true;
    loading.value = false;
  }

  Future<bool> buyPackage(Package package) async {
    loading.value = true;
    try {
      return await PurchaseHelper().purchase(packageToPurchase: package);
    } on PlatformException catch (e) {
      final PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Oops!',
            message: 'Error!',
          ),
        );
        return false;
      }
    }
    loading.value = false;
    return false;
  }

  Future<void> buyProduct(ProductType currentProduct) async {
    loading.value = true;
    update();
    log(getPackages.toString());
    int count = 0;
    Package? temp;
    switch (currentProduct) {
      case ProductType.product1:
        temp = getProduct1;
        count = ProductType.product1.count;
        break;
      case ProductType.product2:
        temp = getProduct2;
        count = ProductType.product2.count;
        break;
    }
    String? error;

    if (temp != null) {
      if (await buyPackage(temp)) {
        log(count.toString());
        log('BUY  SUCCESS');
        log('SAVE  COUNT TO USER');
      } else {
        error = 'ERRORR';
      }
    } else {
      error = AppSentences().exampleSentence;
    }
    loading.value = false;
    update();
    if (error != null) {
      return showPurchaseError(error);
    } else {
      return showMessageDialog(
          title: 'Success', body: 'Package has been bought!');
    }
  }

  void showPurchaseError(String errorMessage) {
    showMessageDialog(title: 'Oops!', body: errorMessage);
  }

  String getPrice(ProductType currentProduct) {
    String? price;
    switch (currentProduct) {
      case ProductType.product1:
        price = getProduct1?.storeProduct.priceString;
        break;
      case ProductType.product2:
        price = getProduct2?.storeProduct.priceString;
        break;
    }
    return price ?? '';
  }

  String getDescription(ProductType currentProduct) {
    String? description;
    switch (currentProduct) {
      case ProductType.product1:
        description = getProduct1?.storeProduct.description;
        break;
      case ProductType.product2:
        description = getProduct2?.storeProduct.description;
        break;
    }
    return description ?? '';
  }

  String getTitle(ProductType currentProduct) {
    String? title;
    switch (currentProduct) {
      case ProductType.product1:
        title = getProduct1?.storeProduct.title;
        break;
      case ProductType.product2:
        title = getProduct1?.storeProduct.title;
        break;
    }
    return title ?? '';
  }
}
