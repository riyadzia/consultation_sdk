import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_cubit.dart';
import 'injector.dart';

void initCubitModule() {
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt.get()));
  getIt.registerFactory<CallingCubit>(() => CallingCubit(getIt.get(),getIt.get()));
  getIt.registerFactory<HealthPackageCubit>(() => HealthPackageCubit(getIt.get(),getIt.get(),getIt.get()));
  // i.registerFactory<PaymentCubit>(() => PaymentCubit(i.get()));
}
