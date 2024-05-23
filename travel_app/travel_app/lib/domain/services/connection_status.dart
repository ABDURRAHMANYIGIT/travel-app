import 'dart:async'; //For StreamController/Stream

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionStatusSingleton {
  ConnectionStatusSingleton._internal();
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton =
      ConnectionStatusSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController<bool> connectionChangeController =
      StreamController<bool>.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream<bool> get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    final bool previousConnection = hasConnection;
    final ConnectivityResult a = await _connectivity.checkConnectivity();
    switch (a) {
      case ConnectivityResult.bluetooth:
        break;
      case ConnectivityResult.wifi:
        hasConnection = true;
        break;
      case ConnectivityResult.ethernet:
        break;
      case ConnectivityResult.mobile:
        hasConnection = true;
        break;
      case ConnectivityResult.none:
        hasConnection = false;
        break;
      case ConnectivityResult.vpn:
        hasConnection = false;
        break;
      case ConnectivityResult.other:
        break;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
