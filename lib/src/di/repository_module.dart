
import 'package:consultation_sdk/src/data/repository/api_repository.dart';
import 'package:consultation_sdk/src/di/injector.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';

void initRepositoryModule() {
  getIt.registerSingleton<ApiRepositoryInit>(ApiRepository(getIt.get()));
}
