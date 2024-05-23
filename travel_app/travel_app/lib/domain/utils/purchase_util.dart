import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../data/enums/product_type_enum.dart';
import '../../resources/config/app_info.dart';
import '../controllers/data_controller/purchase_controller.dart';
import '../helpers/debug_helper.dart';

class PurchaseHelper {
  List<Package> packageList = <Package>[];
  List<StoreProduct> productList = <StoreProduct>[];
  late CustomerInfo purchaserInfo;

  Future<void> initPurchase() async {
    if (Platform.isAndroid) {
      await Purchases.configure(
          PurchasesConfiguration(AppInfo.revenueCatAndroidID));
    } else if (Platform.isIOS) {
      await Purchases.configure(
          PurchasesConfiguration(AppInfo.revenueCatiosID));
    }
  }

//* DONE
  Future<List<Package>?> loadProducts() async {
    try {
      final Offerings offerings = await Purchases.getOfferings();

      if (offerings.current != null) {
        packageList = offerings.current!.availablePackages;

        return packageList;
      }
    } on PlatformException catch (e) {
      DebugHelper.debugPrint(e);
    }
    return null;
  }

  Future<List<Package>> getPackages() async {
    try {
      final Offerings offerings = await Purchases.getOfferings();

      List<Package> packageList = List<Package>.empty();
      if (offerings.current != null) {
        packageList = offerings.current!.availablePackages;
      }
      return packageList;
    } on PlatformException catch (e) {
      DebugHelper.debugPrint(e);
      return <Package>[];
    }
  }

  Future<List<String>> loadPurchasedProducts({BuildContext? context}) async {
    try {
      final CustomerInfo info = await Purchases.getCustomerInfo();
      if (context != null) {}
      return info.allPurchasedProductIdentifiers;
    } on PlatformException catch (e) {
      DebugHelper.debugPrint(e);
      return <String>[];
    }
  }

  Future<bool> purchase({required Package packageToPurchase}) async {
    try {
      final CustomerInfo info =
          await Purchases.purchasePackage(packageToPurchase);
      return info.allPurchasedProductIdentifiers
          .contains(packageToPurchase.storeProduct.identifier);
    } on PlatformException catch (e) {
      final PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
      DebugHelper.debugPrint(errorCode);
      DebugHelper.debugPrint(e);
      return false;
    }
  }

  //* DONE
  Future<void> restorePurchase(BuildContext context) async {
    try {
      await loadPurchasedProducts(context: context);
    } on PlatformException catch (e) {
      DebugHelper.debugPrint(e);
    }
  }

  Future<void> buyToken(ProductType currentToken) async {
    final PurchaseController purchaseController = Get.find();

    int tokenCount = 0;
    Package? temp;
    switch (currentToken) {
      case ProductType.product1:
        tokenCount = ProductType.product1.count;
        temp = purchaseController.getProduct1;
        break;
      case ProductType.product2:
        tokenCount = ProductType.product2.count;
        temp = purchaseController.getProduct2;
        break;
    }
    log(tokenCount.toString());

    if (temp != null) {
      if (await purchaseController.buyPackage(temp)) {
        log('purchase success');
      } else {
        log('purchase failed');
      }
    } else {
      log('package error');
    }
  }
}
