
import 'package:injectable/injectable.dart';

import 'mock/display/display_mock_api.dart';
import 'remote/display.api.dart';

@module
abstract class DateSourceModule{

  @singleton
  DisPlayApi get displayApi => DisplayMockApi();
}