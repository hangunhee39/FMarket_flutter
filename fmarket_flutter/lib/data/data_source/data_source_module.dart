
import 'package:injectable/injectable.dart';

import 'local_storage/display.dao.dart';
import 'mock/display/display_mock_api.dart';
import 'remote/display.api.dart';

//DI
@module
abstract class DateSourceModule{

  @singleton
  DisPlayApi get displayApi => DisplayMockApi();

  @singleton
  DisplayDao get displayDap => DisplayDao();
}