import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper{
  static Future<bool> connected()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else{
      return true;
    }
  }
}