import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final internetConnectionCheckerProvider = Provider<InternetConnectionChecker>((ref) {
 return InternetConnectionChecker();
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
 final internetConnectionCheckerRef = ref.read(internetConnectionCheckerProvider);
 return NetworkInfo(internetConnectionCheckerRef);
});

class NetworkInfo{
 final InternetConnectionChecker _internetConnectionChecker;
 NetworkInfo(this._internetConnectionChecker);

 Future<bool> get isConnected async=> await _internetConnectionChecker.hasConnection;
}