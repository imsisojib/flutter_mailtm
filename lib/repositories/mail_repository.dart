import 'dart:convert';

import 'package:flutter_mailtm/helpers/debugger.dart';
import 'package:flutter_mailtm/models/maillist_response.dart';
import 'package:flutter_mailtm/models/single_mail_response.dart';
import 'package:flutter_mailtm/repositories/cache_repository.dart';
import 'package:flutter_mailtm/repositories/token_repository.dart';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class MailRepository{
  final CacheRepository cacheRepository;
  final TokenRepository tokenRepository;
  MailRepository({required this.tokenRepository,required this.cacheRepository});

  Future<MailListResponse?> fetchMails(int index) async{
    try{
      Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.allMails}?page=$index");
      http.Response response = await http.get(url,headers: tokenRepository.getHeadersForJson(),);

      Debugger.debug(tittle: "MailRepository.fetchMails(): response-code",data:  response.statusCode);
      Debugger.debug(tittle: "MailRepository.fetchMails(): response-body",data:  response.body);
      //save for offline
      cacheRepository.saveMailList(response.body);

      return MailListResponse.fromJson(jsonDecode(response.body),);

    }catch(e){
      Debugger.debug(tittle: "MailRepository.fetchMails(): catch-error",data:  e);
    }

    return null;
  }

  Future<SingleMailResponse?> fetchSingleMail(String? mailId) async{
    try{
      Uri url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.allMails}/$mailId");
      Debugger.debug(tittle: "MailRepository.fetchSingleMail(): url",data:  url);
      http.Response response = await http.get(url,headers: tokenRepository.getHeadersForJson(),);

      Debugger.debug(tittle: "MailRepository.fetchSingleMail(): response-code",data:  response.statusCode);
      Debugger.debug(tittle: "MailRepository.fetchSingleMail(): response-body",data:  response.body);

      return SingleMailResponse.fromJson(jsonDecode(response.body),);

    }catch(e){
      Debugger.debug(tittle: "MailRepository.fetchSingleMail(): catch-error",data:  e);
    }

    return null;
  }
}