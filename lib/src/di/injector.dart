import 'package:get_it/get_it.dart';
import 'package:consultation_sdk/src/di/cubit_module.dart';
import 'package:consultation_sdk/src/di/data_source_module.dart';
import 'package:consultation_sdk/src/di/repository_module.dart';

GetIt get getIt => GetIt.instance;

void initInjector() {
  initDataSourceModule();
  initRepositoryModule();
  // initInteractorModule();
  initCubitModule();
}
