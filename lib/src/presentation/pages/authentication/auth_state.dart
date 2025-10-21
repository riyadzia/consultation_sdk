import 'package:consultation_sdk/src/model/user_profile_model.dart';

class AuthState {
  final UserProfileModel? userProfileModel;
  final bool isLoading;
  final bool isLoaded;
  final String error;

  AuthState({
    this.userProfileModel,
    this.isLoading = false,
    this.isLoaded = true,
    this.error = "",
  });

  AuthState copyWith({
    UserProfileModel? userProfileModel,
    bool? isLoading,
    bool? isLoaded,
    String? error,
  }) {
    return AuthState(
      userProfileModel: userProfileModel ?? this.userProfileModel,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
    );
  }
}
