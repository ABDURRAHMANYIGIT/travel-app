enum Example {
  sample1,
  sample2,
}

extension ExampleExtension on Example {
  String get toShortString {
    switch (this) {
      case Example.sample1:
        return 'sample1';

      case Example.sample2:
        return 'sample2';
    }
  }

  static Example fromString(String s) {
    switch (s) {
      case 'sample1':
        return Example.sample1;
      case 'sample2':
        return Example.sample2;
    }
    return Example.sample1;
  }
}
