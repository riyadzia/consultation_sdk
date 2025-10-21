import 'package:consultation_sdk/src/di/injector.dart';
import 'package:consultation_sdk/src/data/repository/remote_database.dart';
import 'package:consultation_sdk/src/domain/repository/remote_database.dart';

void initDataSourceModule() {
  if (!getIt.isRegistered<RemoteDataSourceInit>()) {
    getIt.registerSingleton<RemoteDataSourceInit>(RemoteDataSource());
  }
}
