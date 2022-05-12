import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_cart/shopping_cart.dart';

class MockLoadCart extends Mock implements LoadCartPort {}

class MockUpdateCartState extends Mock implements UpdateCartStatePort {}

class MockNetworkCheck extends Mock implements NetworkCheckPort {}

class MockAddToCartAPI extends Mock implements AddToCartAPIPort {}

class MockCartChangeListenerPort extends Mock implements CartChangeListenerPort {}

class _FakeProduct extends Product {
  _FakeProduct({int fakeId = 0, double fakePrice = 100}) : super(id: fakeId, totalPrice: fakePrice);
}

class AddToCartTest {
  static late AddToCartUseCase _addToCartUseCase;

  static late AddToCartAPIPort _addToCartAPIPort;
  static late LoadCartPort _loadCartPort;
  static late UpdateCartStatePort _updateCartStatePort;
  static late NetworkCheckPort _networkCheckPort;
  static late CartChangeListenerPort _cartChangeListenerPort;

  static void runAll() {
    group("--AddToCartUseCase--Tests--", () {
      _initializePorts();
      _initializeUseCase();
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
        var expectedCart = Cart(items: [CartItem(product: _FakeProduct())]);
        when(_networkCheckPort.isConnected).thenAnswer((_) => Future.value(true));
        when(_loadCartPort.loadCart()).thenAnswer((_) => Future.value(Cart()));
        when(_updateCartStatePort.updateCartState(expectedCart))
            .thenAnswer((_) => Future.value());
        when(_cartChangeListenerPort.listen(expectedCart)).thenAnswer((_) {});
        when(_addToCartAPIPort.addToCart(_FakeProduct())).thenAnswer((_) => Future.value());
        var result = await _addToCartUseCase.addToCart(_FakeProduct());
        expect(result.isSuccess, true);
      });
      test("cart-is-not-empty", () async {
        var storedCart   = Cart(items: [CartItem(product: _FakeProduct())]);
        var expectedCart = Cart(items: [CartItem(product: _FakeProduct(), quantity: 2)]);
        when(_networkCheckPort.isConnected).thenAnswer((_) => Future.value(true));
        when(_loadCartPort.loadCart()).thenAnswer((_) => Future.value(storedCart));
        when(_updateCartStatePort.updateCartState(expectedCart))
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
      when(_addToCartAPIPort.addToCart(_FakeProduct())).thenThrow(DomainException(failureType: FailureType.server));
      when(_loadCartPort.loadCart()).thenAnswer((_) => Future.value(Cart()));
      when(_updateCartStatePort.updateCartState(
          Cart(items: [CartItem(product: _FakeProduct())])))
          .thenAnswer((_) => Future.value());
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
      addToCartAPIPort: _addToCartAPIPort,
      cartChangeListenerPort: _cartChangeListenerPort
    );
  }

  static void _initializePorts() {
    _loadCartPort           = MockLoadCart();
    _networkCheckPort       = MockNetworkCheck();
    _addToCartAPIPort       = MockAddToCartAPI();
    _updateCartStatePort    = MockUpdateCartState();
    _cartChangeListenerPort = MockCartChangeListenerPort();
  }
}
