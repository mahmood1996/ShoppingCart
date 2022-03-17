import 'package:flutter_test/flutter_test.dart';
import 'add_to_cart_test.dart';
import 'cart_test.dart';

class MainUnitTests {
  static void runAll() {
    group("Unit-Tests", () {
      CartTest.runAll();
      AddToCartTest.runAll();
    });
  }
}