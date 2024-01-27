import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../domain/model/common/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/utils/error/error_response.dart';
import '../../../../../core/utils/exception/common_exception.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../domain/model/display/menu.model.dart';
import '../../../../../domain/usecase/display/display.usecase.dart';
import '../../../../../domain/usecase/display/menu/get_menus.usecase.dart';
import '../../../../main/cubit/mall_type_cubit.dart';

part 'menu_event.dart';

part 'menu_state.dart';

part 'menu_bloc.freezed.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final DisplayUsecase _displayUsecase;

  MenuBloc(this._displayUsecase) : super(MenuState()) {
    on<MenuInitialized>(_onMenuInitialized);
  }

  Future<void> _onMenuInitialized(
    MenuInitialized event,
    Emitter<MenuState> emit,
  ) async {
    final mallType = event.mallType;

    emit(state.copyWith(status: Status.loading));

    try {
      final Result<List<Menu>> response = await _fetch(mallType: mallType);
      response.when(
        success: (menus) {
          emit(state.copyWith(
            status: Status.success,
            menus: menus,
            mallType: mallType,
          ));
        },
        failure: (error) {
          emit(state.copyWith(
            status: Status.error,
            error: error,
          ));
        },
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(
        status: Status.error,
        error: CommonException.setError(error),
      ));
    }
  }

  Future<Result<List<Menu>>> _fetch({required MallType mallType}) async {
    return await _displayUsecase.execute(
      usecase: GetMenuUsecase(mallType: mallType),
    );
  }
}
