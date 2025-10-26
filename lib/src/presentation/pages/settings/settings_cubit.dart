import 'package:bloc/bloc.dart';
import 'package:consultation_sdk/src/domain/repository/api_repository.dart';
import 'package:consultation_sdk/src/presentation/pages/settings/settings_state.dart';
import 'package:meta/meta.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ApiRepositoryInit _repository;
  static final initialState = SettingsState();
  SettingsCubit(this._repository) : super(initialState);

  Future<void> getAppSettingData() async {
    emit(state.copyWith(isLoading: true));
    final result = await _repository.getBanner();
    result.fold((error){
      emit(state.copyWith(isLoading: false));
    }, (data){
      emit(state.copyWith(isLoading: false, settingModel: data));
    });
  }

}
