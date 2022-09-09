import 'dart:io';

class TokenRepository{
  String? token;

  TokenRepository({this.token});

  Map<String,String> getHeadersForJson(){
    return {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.connectionHeader : "keep-alive",
      HttpHeaders.authorizationHeader : "Bearer $token",
    };
  }
  Map<String,String> getHeadersForJsonWithoutToken(){
    return {
      HttpHeaders.contentTypeHeader: "application/json",
    };
  }


}