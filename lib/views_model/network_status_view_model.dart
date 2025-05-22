import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkStatusViewModel extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  void initialize() {
    // Écoute les changements de connectivité
    _connectivity.onConnectivityChanged.listen(
      (event) async {
        print("event:;;;;;;;;;;;; $event");
        final connected = event.first == ConnectivityResult.wifi ||
            event.first == ConnectivityResult.mobile;

        if (_isConnected != connected) {
          _isConnected = connected;
          notifyListeners();
        }
      },
    );

    // Vérifie l'état initial
    _connectivity.checkConnectivity().then((result) {
      final connected = result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile;

      if (_isConnected != connected) {
        _isConnected = connected;
        notifyListeners();
      }
    });
  }
}
