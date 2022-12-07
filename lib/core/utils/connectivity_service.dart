/*import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._();
  factory ConnectivityService()=> _instance;

  Connectivity connectivity = Connectivity();
  StreamController<ConnectivityStatus>connectionStatusController=StreamController<ConnectivityStatus>();

  ConnectivityService._(){
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      var connectionStatus = _getStatusFromResult(result);
      connectionStatusController.add(connectionStatus);
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result){

    switch(result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;
      case ConnectivityResult.none:
          return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }

  }
}

enum ConnectivityStatus{
  cellular,
  wifi,
  offline
}*/