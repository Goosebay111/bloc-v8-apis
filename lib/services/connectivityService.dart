import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

//what happens when there is no internet connection.
class ConnectivityService {
  final _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}
