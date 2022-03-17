import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_cart/application/ports/out/api/add_to_cart_api_port.dart';
import 'package:shopping_cart/common/exceptions/domain_exception.dart';
import 'package:shopping_cart/shopping_cart.dart';

class MockLoadCart extends Mock implements LoadCartPort {}

class MockUpdateCartState extends Mock implements UpdateCartStatePort {}

class MockNetworkCheck extends Mock implements NetworkCheckPort {}

class MockAddToCartAPI extends Mock implements AddToCartAPIPort {}

class _FakeProduct extends Product {
  @override
  int get id => 0;

  @override
  double get totalPrice => 1000;
}

class AddToCartTest {
  static late LoadCartPort _loadCartPort;
  static late UpdateCartStatePort _updateCartStatePort;
  static late NetworkCheckPort _networkCheckPort;
  static late AddToCartUseCase _addToCartUseCase;
  static late AddToCartAPIPort _addToCartAPIPort;

  static void runAll() {
    _initializePorts();
    _initializeUseCase();

    group("--AddToCartUseCase--Tests--", () {
      _testNotConnected();
      _testIfConnectedNoException();
      _testIfConnectedWithException();
    });
  }

  static void _testNotConnected() {
    test("not-connected", () async {
      when(_networkCheckPort.isConnected)
          .thenAnswer((_) => Future.value(false));
      var result = await _addToCartUseCase.addToCart(_FakeProduct());
      expect(
          result,
          Result<Failure, void>.failure(
              BaseFailure(type: FailureType.network)));
    });
  }

  static void _testIfConnectedNoException() {
    group("connected-no-exception", () {
      test("cart-is-empty", () async {
        when(_networkCheckPort.isConnected).thenAnswer((_) => Future.value(true));
        when(_loadCartPort.loadCart()).thenAnswer((_) => Future.value(Cart()));
        when(_updateCartStatePort.updateCartState(
            Cart(items: [CartItem(product: _FakeProduct())])))
            .thenAnswer((_) => Future.value());
        when(_addToCartAPIPort.addToCart(_FakeProduct())).thenAnswer((realInvocation) => Future.value());
        var result = await _addToCartUseCase.addToCart(_FakeProduct());
        expect(result.isSuccess, true);
      });
      test("cart-is-not-empty", () async {
        when(_networkCheckPort.isConnected).thenAnswer((_) => Future.value(true));
        when(_loadCartPort.loadCart()).thenAnswer((_) => Future.value(Cart(items: [CartItem(product: _FakeProduct())])));
        when(_updateCartStatePort.updateCartState(
            Cart(items: [CartItem(product: _FakeProduct(), quantity: 2)])))
            .thenAnswer((_) => Future.value());
        when(_addToCartAPIPort.addToCart(_FakeProduct())).thenAnswer((realInvocation) => Future.value());
        var result = await _addToCartUseCase.addToCart(_FakeProduct());
        expect(result.isSuccess, true);
      });
    });
  }

  static void _testIfConnectedWithException() {
    test("connected-with-exception", () async {
      when(_networkCheckPort.isConnected).thenAnswer((_) => Future.value(true));
      when(_loadCartPort.loadCart()).thenAnswer((_) => Future.value(Cart()));
      when(_updateCartStatePort.updateCartState(
          Cart(items: [CartItem(product: _FakeProduct())])))
          .thenAnswer((_) => Future.value());
      when(_addToCartAPIPort.addToCart(_FakeProduct())).thenThrow(DomainException(failureType: FailureType.server));
      var result = await _addToCartUseCase.addToCart(_FakeProduct());
      expect(result.isSuccess, false);
      expect(result, Result<Failure, void>.failure(BaseFailure(type: FailureType.server)));
    });
  }

  static void _initializeUseCase() {
    _addToCartUseCase = AddToCartService(
      networkCheckPort: _networkCheckPort,
      loadCartPort: _loadCartPort,
      updateCartStatePort: _updateCartStatePort,
      addToCartAPIPort: _addToCartAPIPort
    );
  }

  static void _initializePorts() {
    _loadCartPort        = MockLoadCart();
    _networkCheckPort    = MockNetworkCheck();
    _addToCartAPIPort    = MockAddToCartAPI();
    _updateCartStatePort = MockUpdateCartState();
  }
}
