enum ProductType {
  product1,
  product2,
}

extension ProductTypeExtension on ProductType {
  int get count {
    switch (this) {
      case ProductType.product1:
        return 100;
      case ProductType.product2:
        return 200;
    }
  }

  String get identifier {
    switch (this) {
      case ProductType.product1:
        return 'product_1';
      case ProductType.product2:
        return 'product_2';
    }
  }
}
