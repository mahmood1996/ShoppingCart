import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_cart/domain/cart.dart';
import 'package:shopping_cart/domain/cart_item.dart';
import 'package:shopping_cart/domain/product.dart';

class _FakeProduct extends Product {
  final int fakeId;
  final double fakePrice;

  _FakeProduct({this.fakeId = 0, this.fakePrice = 100});

  @override
  int get id => fakeId;

  @override
  double get totalPrice => fakePrice;
}

class CartTest {

  static void runAll() {
    group("cart-tests", () {
      _testAddToCart();
      _testRemoveFromCart();
      _testDeleteFromCart();
    });
  }

  static void _testAddToCart() {
    test("add-to-cart-test", () {
      Cart cart = Cart();

      cart.addToCart(_FakeProduct());
      expect(cart, Cart(items: [CartItem(product: _FakeProduct())]));

      cart.addToCart(_FakeProduct());
      expect(cart, Cart(items: [CartItem(quantity: 2, product: _FakeProduct())]));

      cart.addToCart(_FakeProduct(fakeId: 1, fakePrice: 100));
      expect(cart, Cart(items: [
        CartItem(quantity: 2, product: _FakeProduct()),
        CartItem(product: _FakeProduct(fakeId: 1, fakePrice: 100)),
      ]));
    });
  }

  static void _testRemoveFromCart() {
    test("remove-from-cart-test", () {
      Cart cart = Cart();

      cart.addToCart(_FakeProduct());
      cart.addToCart(_FakeProduct());
      cart.addToCart(_FakeProduct());
      cart.removeFromCart(0);
      expect(cart, Cart(items: [CartItem(quantity: 2, product: _FakeProduct())]));

      cart.addToCart(_FakeProduct(fakeId: 1, fakePrice: 100));
      cart.addToCart(_FakeProduct(fakeId: 1, fakePrice: 100));
      cart.removeFromCart(1);
      expect(cart, Cart(items: [
        CartItem(quantity: 2, product: _FakeProduct()),
        CartItem(product: _FakeProduct(fakeId: 1, fakePrice: 100)),
      ]));
    });
  }

  static void _testDeleteFromCart() {
    test("delete-from-cart-test", () {
      Cart cart = Cart();

      cart.addToCart(_FakeProduct());
      cart.addToCart(_FakeProduct());
      cart.addToCart(_FakeProduct());
      cart.deleteFromCart(0);
      expect(cart, Cart(items: []));

      cart.addToCart(_FakeProduct());
      cart.addToCart(_FakeProduct(fakeId: 1, fakePrice: 100));
      cart.addToCart(_FakeProduct(fakeId: 1, fakePrice: 100));
      cart.addToCart(_FakeProduct(fakeId: 1, fakePrice: 100));
      cart.deleteFromCart(1);
      expect(cart, Cart(items: [
        CartItem(product: _FakeProduct()),
      ]));
    });
  }
}