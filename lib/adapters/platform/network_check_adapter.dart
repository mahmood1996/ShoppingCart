import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shopping_cart/application/ports/out/platform/network_check_port.dart';

class NetworkCheckAdapter implements NetworkCheckPort {
  final Connectivity connectivity;
  NetworkCheckAdapter({required this.connectivity});

  @override
  Future<bool> get isConnected async => await _isConnected();

  Future<bool> _isConnected() async {
    var result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
