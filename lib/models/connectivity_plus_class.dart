import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityPlus {
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  set isConnected(bool value) {
    _isConnected = value;
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return isConnected = false;
    }
    return isConnected;
  }
}
