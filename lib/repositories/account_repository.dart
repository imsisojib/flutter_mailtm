import 'dart:convert';

import 'package:flutter_mailtm/helpers/debugger.dart';
import 'package:flutter_mailtm/models/create_account_response.dart';
import 'package:flutter_mailtm/models/domains_response.dart';
import 'package:flutter_mailtm/models/login_response.dart';
import 'package:flutter_mailtm/repositories/api_constants.dart';
import 'package:flutter_mailtm/repositories/cache_repository.dart';
import 'package:flutter_mailtm/repositories/token_repository.dart';
import 'package:http/http.dart' as http;

class AccountRepository{
  final TokenRepository tokenRepository;
  final CacheRepository cacheRepository;
  AccountRepository({required this.tokenRepository,required this.cacheRepository});

  Future<DomainsResponse?> fetchDomains() async{
    try{
      Uri url = Uri.parse(ApiConstants.baseUrl+ApiConstants.fetchDomains);
      http.Response response = await http.get(url,headers: tokenRepository.getHeadersForJsonWithoutToken(),);

      Debugger.debug(tittle: "AccountRepository.fetchDomains(): response-code",data:  response.statusCode);
      Debugger.debug(tittle: "AccountRepository.fetchDomains(): response-body",data:  response.body);

      return DomainsResponse.fromJson(jsonDecode(response.body),);

    }catch(e){
      Debugger.debug(tittle: "AccountRepository.fetchDomains(): catch-error",data:  e);
    }

    return null;
  }

  Future<CreateAccountResponse?> createAccount(String mail, String password) async{
    try{
      Uri url = Uri.parse(ApiConstants.baseUrl+ApiConstants.crateAccount);
      http.Response response = await http.post(
        url,
        body: jsonEncode({
          "address": mail,
          "password": password
        }),
        headers: tokenRepository.getHeadersForJsonWithoutToken(),
      );

      Debugger.debug(tittle: "AccountRepository.createAccount(): response-code",data:  response.statusCode);
      Debugger.debug(tittle: "AccountRepository.createAccount(): response-body",data:  response.body);

      var data = CreateAccountResponse.fromJson(jsonDecode(response.body));
      data.statusCode = response.statusCode;

      return data;

    }catch(e){
      Debugger.debug(tittle: "AccountRepository.createAccount(): catch-error",data:  e);
    }

    return null;
  }

  Future<LoginResponse?> loginAccount(String mail, String password) async{
    try{
      Uri url = Uri.parse(ApiConstants.baseUrl+ApiConstants.login);
      http.Response response = await http.post(
        url,
        body: jsonEncode({
          "address": mail,
          "password": password
        }),
        headers: tokenRepository.getHeadersForJsonWithoutToken(),
      );

      Debugger.debug(tittle: "AccountRepository.loginAccount(): response-code",data:  response.statusCode);
      Debugger.debug(tittle: "AccountRepository.loginAccount(): response-body",data:  response.body);

      return LoginResponse.fromJson(jsonDecode(response.body));

    }catch(e){
      Debugger.debug(tittle: "AccountRepository.loginAccount(): catch-error",data:  e);
    }

    return null;
  }

}