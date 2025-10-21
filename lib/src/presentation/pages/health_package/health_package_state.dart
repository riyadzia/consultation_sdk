import 'package:consultation_sdk/src/model/active_health_card_model.dart';
import 'package:consultation_sdk/src/model/package_model.dart';

class HealthPackageState {
  final List<PackageModel>? fulPackageList;
  final List<PackageModel>? packageList;
  final ActiveHealthCardModel? activeHealthCardModel;
  final bool isLoading;
  final bool isHealthCardLoading;

  HealthPackageState({
    this.fulPackageList,
    this.packageList,
    this.activeHealthCardModel,
    this.isLoading = false,
    this.isHealthCardLoading = false,
  });

  HealthPackageState copyWith({
    List<PackageModel>? fulPackageList,
    List<PackageModel>? packageList,
    ActiveHealthCardModel? activeHealthCardModel,
    bool? isLoading,
    bool? isHealthCardLoading,
  }) {
    return HealthPackageState(
      fulPackageList: fulPackageList ?? this.fulPackageList,
      packageList: packageList ?? this.packageList,
      activeHealthCardModel:
          activeHealthCardModel ?? this.activeHealthCardModel,
      isLoading: isLoading ?? this.isLoading,
      isHealthCardLoading: isHealthCardLoading ?? this.isHealthCardLoading,
    );
  }
}
