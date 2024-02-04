import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/error/error_response.dart';
import '../../../../../core/utils/exception/common_exception.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../domain/model/common/result.dart';
import '../../../../../domain/model/display/view_module/view_module.model.dart';
import '../../../../../domain/usecase/display/display.usecase.dart';
import '../../../../../domain/usecase/display/view_module/get_view_modules.usecase.dart';
import '../../component/view_module/view_module_factory/view_module_factory.dart';

part 'view_module_event.dart';

part 'view_module_state.dart';

//이거 추가해야 freezed 추가
part 'view_module_bloc.freezed.dart';

EventTransformer<E> _throttleDroppable<E>(Duration duration) {
  return (event, mapper) {
    return droppable<E>().call(event.throttle(duration), mapper);
  };
}

class ViewModuleBloc extends Bloc<ViewModuleEvent, ViewModuleState> {
  final DisplayUsecase _displayUsecase;

  //이벤트 등록하기
  ViewModuleBloc(this._displayUsecase) : super(ViewModuleState()) {
    on<ViewModuleInitialized>(_onViewModuleInitialized);
    on<ViewModuleFetched>(
      _onViewModuleFetched,
      transformer: _throttleDroppable(Duration(milliseconds: 400)),
    );
  }

  Future<void> _onViewModuleInitialized(
    ViewModuleInitialized event,
    Emitter<ViewModuleState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final tabId = event.tabId;
    try {
      final response = await _fetch(tabId: tabId);
      response.when(
        success: (data) {
          ViewModuleFactory viewModuleFactory = ViewModuleFactory();
          final List<Widget> viewModules =
              data.map((e) => viewModuleFactory.textToWidget(e)).toList();
          emit(state.copyWith(
            status: Status.success,
            tabId: tabId,
            viewModules: viewModules,
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

  Future<Result<List<ViewModule>>> _fetch({
    required int tabId,
    int page = 1,
  }) async {
    return await _displayUsecase.execute(
      usecase: GetViewModulesUsecase(tabId: tabId, page: page),
    );
  }

  Future<void> _onViewModuleFetched(
    ViewModuleFetched event,
    Emitter<ViewModuleState> emit,
  ) async {
    print('[test] featched call');
    //만약 끝페이지에 도달하면 리턴
    if (state.isEndofPage) return;
    final nextPage = state.currentPage + 1;
    final tabId = state.tabId;

    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _fetch(tabId: tabId, page: nextPage);
      response.when(
        success: (data) {
          if (data.isEmpty) {
            emit(state.copyWith(
              status: Status.success,
              currentPage: nextPage,
              isEndofPage: true,
            ));

            return;
          }
          final List<Widget> viewModules = [...state.viewModules];
          ViewModuleFactory viewModuleFactory = ViewModuleFactory();
          viewModules.addAll(List.generate(
            data.length,
            (index) => viewModuleFactory.textToWidget(data[index]),
          ));
          emit(state.copyWith(
            status: Status.success,
            tabId: tabId,
            viewModules: viewModules,
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
}
