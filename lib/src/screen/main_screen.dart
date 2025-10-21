import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultation_sdk/src/core/app_sizes.dart';
import 'package:consultation_sdk/src/core/services/navigation_service.dart';
import 'package:consultation_sdk/src/data/repository/api_repository.dart';
import 'package:consultation_sdk/src/data/repository/remote_database.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';
import 'package:consultation_sdk/src/domain/repository/remote_database.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/auth_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/authentication/login_otp_screen.dart';
import 'package:consultation_sdk/src/presentation/pages/calling/calling_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/health_package/health_package_cubit.dart';
import 'package:consultation_sdk/src/presentation/pages/payment/payment_cubit.dart';
import 'package:consultation_sdk/src/screen/home_screen.dart';
import 'package:consultation_sdk/consultation_sdk.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.countryLetterCode,
    required this.dialCode,
    required this.phoneNumber,
    this.authToken,
    required this.setServiceToken,
    required this.onOtpVerified,
    required this.onError,
  });
  final String countryLetterCode;
  final String dialCode;
  final String phoneNumber;
  final String? authToken;
  final String setServiceToken;
  final void Function(String authToken) onOtpVerified;
  final void Function(String) onError;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RemoteDataSourceInit>(
          create: (context) => RemoteDataSource(),
        ),
        RepositoryProvider<ApiRepositoryInit>(
          create: (context) => ApiRepository(context.read()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit(context.read()),
          ),
          BlocProvider<CallingCubit>(
            create: (BuildContext context) =>
                CallingCubit(context.read(), context.read()),
          ),
          BlocProvider<HealthPackageCubit>(
            create: (BuildContext context) => HealthPackageCubit(
              context.read(),
              context.read(),
              context.read(),
            ),
          ),
          BlocProvider<PaymentCubit>(
            create: (BuildContext context) => PaymentCubit(context.read(),context.read()),
          ),
        ],
        child: MaterialApp(
          // darkTheme: ThemeData.dark(),
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: Builder(
            builder: (context) {
              if(widget.authToken == null || widget.authToken == ""){
                return LoginOtpScreen(
                  countryLetterCode: widget.countryLetterCode,
                  dialCode: widget.dialCode,
                  phoneNumber: widget.phoneNumber,
                  serviceToken: widget.setServiceToken,
                  onOtpVerified: (token){
                    widget.onOtpVerified(token);
                  },
                  onError: (error){
                    widget.onError(error);
                  },
                );
              }
              return HomeScreen(
                countryLetterCode: widget.countryLetterCode,
                dialCode: widget.dialCode,
                phoneNumber: widget.phoneNumber,
                authToken: widget.authToken,
                serviceToken: widget.setServiceToken,
              );
            }
          ),
        ),
      ),
    );
  }
}
