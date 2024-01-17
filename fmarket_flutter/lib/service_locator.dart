import 'package:get_it/get_it.dart';

import 'data/data_source/mock/display/display_mock_api.dart';
import 'data/data_source/remote/display.api.dart';
import 'data/repository_impl/display.repository_impl.dart';
import 'domain/repository/display.repository.dart';
import 'domain/usecase/display/display.usecase.dart';

//get_it (의존성)
//Service Locator 패턴

final locator = GetIt.instance;

void setLocator() {
  _data();
  _domain();
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
