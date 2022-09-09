import 'package:flutter/foundation.dart';

class Debugger{
  static void debug({required String tittle, dynamic data}){
    if(kDebugMode){
      print("-----------:> $tittle :<-----------:start");
      print(data);
      print("-----------:> $tittle :<-----------:end");
    }
  }
}