import 'package:flutter_mailtm/repositories/account_repository.dart';
import 'package:flutter_mailtm/repositories/cache_repository.dart';
import 'package:flutter_mailtm/repositories/mail_repository.dart';
import 'package:flutter_mailtm/repositories/token_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {

  //using dependency-injection
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //repositories
  sl.registerLazySingleton(() => AccountRepository(tokenRepository: sl(),cacheRepository: sl()));
  sl.registerLazySingleton(() => MailRepository(tokenRepository: sl(), cacheRepository: sl()));
  sl.registerLazySingleton(() => CacheRepository(sharedPreferences: sl()));

  //token manager
  TokenRepository tokenManager = TokenRepository();
  sl.registerSingleton(tokenManager);

}
