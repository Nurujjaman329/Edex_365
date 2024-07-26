abstract class NetworkInfo {
  Future<bool> get isConnected;
}
/*

class NetworkInfoImpl implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}


var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
// I am connected to a mobile network.
} else if (connectivityResult == ConnectivityResult.wifi) {
// I am connected to a wifi network.
}
*/
