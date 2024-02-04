import 'package:get_it/get_it.dart';

import 'data/data_source/mock/display/display_mock_api.dart';
import 'data/data_source/remote/display.api.dart';
import 'data/repository_impl/display.repository_impl.dart';
import 'domain/repository/display.repository.dart';
import 'domain/usecase/display/display.usecase.dart';
import 'presentation/pages/home/bloc/menu_bloc/menu_bloc.dart';
import 'presentation/pages/home/bloc/view_module_bloc/view_module_bloc.dart';

//get_it (의존성)
//Service Locator 패턴

final locator = GetIt.instance;

void setLocator() {
  _data();
  _domain();
  _presentation();
}

//--singleTon--//
void _data() {
  locator.registerSingleton<DisPlayApi>(DisplayMockApi());
}

void _domain() {
  //repository
  locator.registerSingleton<DisplayRepository>(
    DisplayRepositoryImpl(locator<DisPlayApi>()),
  );

  //usecase
  locator.registerSingleton<DisplayUsecase>(
    DisplayUsecase(locator<DisplayRepository>()),
  );
}

void _presentation(){
  locator.registerFactory(() => MenuBloc(locator<DisplayUsecase>()));

  locator.registerFactory(() => ViewModuleBloc(locator<DisplayUsecase>()));
}